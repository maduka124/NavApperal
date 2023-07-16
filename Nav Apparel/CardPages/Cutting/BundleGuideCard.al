page 50665 "Bundle Guide Card"
{
    PageType = Card;
    SourceTable = BundleGuideHeader;
    Caption = 'Bundle Guide';

    layout
    {
        area(Content)
        {
            group(General)
            {
                //Done By sachith on 03/04/23
                Editable = EditableGB;
                field("BundleGuideNo."; rec."BundleGuideNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Bundle Guide No';
                    Editable = EditableGB;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("LaySheetNo."; rec."LaySheetNo.")
                {
                    ApplicationArea = All;
                    Caption = 'LaySheet No';

                    trigger OnLookup(var texts: text): Boolean
                    var
                        LaySheetHeaderRec: Record LaySheetHeader;
                        LoginSessionsRec: Record LoginSessions;
                        BundleGRec: Record BundleGuideHeader;
                        LoginRec: Page "Login Card";
                        UserRec: Record "User Setup";
                    begin
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());
                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;

                        UserRec.Reset();
                        UserRec.Get(UserId);
                        if UserRec."Factory Code" <> '' then begin
                            Rec."Factory Code" := UserRec."Factory Code";
                        end
                        else
                            Error('Factory not assigned for the user.');

                        LaySheetHeaderRec.RESET;
                        LaySheetHeaderRec.SetCurrentKey("LaySheetNo.");
                        LaySheetHeaderRec.Ascending(false);
                        LaySheetHeaderRec.SetRange("Factory Code", rec."Factory Code");

                        IF LaySheetHeaderRec.FINDFIRST THEN BEGIN
                            REPEAT
                                BundleGRec.Reset();
                                BundleGRec.SetRange("LaySheetNo.", LaySheetHeaderRec."LaySheetNo.");
                                if not BundleGRec.FindSet() then
                                    LaySheetHeaderRec.MARK(TRUE);
                            UNTIL LaySheetHeaderRec.NEXT = 0;
                            LaySheetHeaderRec.MARKEDONLY(TRUE);

                            if Page.RunModal(51320, LaySheetHeaderRec) = Action::LookupOK then begin
                                rec."LaySheetNo." := LaySheetHeaderRec."LaySheetNo.";

                                LaySheetHeaderRec.Reset();
                                LaySheetHeaderRec.SetRange("LaySheetNo.", rec."LaySheetNo.");
                                if LaySheetHeaderRec.FindSet() then begin
                                    rec."Style Name" := LaySheetHeaderRec."Style Name";
                                    rec."Style No." := LaySheetHeaderRec."Style No.";
                                    rec."PO No." := LaySheetHeaderRec."PO No.";
                                    rec."Component Group" := LaySheetHeaderRec."Component Group Name";
                                    rec."Cut No New" := LaySheetHeaderRec."Cut No New";
                                end
                                else
                                    Error('Invalid Layshhet No.');

                                CurrPage.Update();
                            end;
                        END;
                    END;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    Editable = false;
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'PO No';
                }

                field("Component Group"; rec."Component Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Cut No"; rec."Cut No New")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Cut No';
                }

                field("Bundle Rule"; rec."Bundle Rule")
                {
                    ApplicationArea = All;
                    Caption = 'Bundle Qty';
                }

                field("Bundle Method"; rec."Bundle Method")
                {
                    ApplicationArea = All;
                    Caption = 'Bundle Type';
                }

                field("Bundle No Start"; rec."Bundle No Start")
                {
                    ApplicationArea = All;
                    Caption = 'Bundle No Start At';
                }

                field("Sticker Seq Start"; rec."Sticker Seq Start")
                {
                    ApplicationArea = All;
                    Caption = 'Sticker Seq Start At';
                }
            }

            group("Bundle Details")
            {
                //Done By sachith on 03/04/23
                Editable = EditableGB;

                part(BundleGuideLineListpart; BundleGuideLineListpart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "BundleGuideNo." = FIELD("BundleGuideNo.");
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action("Create Bundles")
            {
                ApplicationArea = All;
                Image = CreateMovement;

                trigger OnAction()
                var
                    BundleGuideLineRec: Record BundleGuideLine;
                    LaySheetLine1Rec: Record LaySheetLine1;
                    LaySheetLine2Rec: Record LaySheetLine1;
                    LaySheetRec: Record LaySheetHeader;
                    LaySheetLine4Rec: Record LaySheetLine4;
                    StyleMasPoRec: Record "Style Master PO";
                    LocationRec: Record Location;
                    TempQty1: BigInteger;
                    i: Integer;
                    j: Integer;
                    Size: Code[20];
                    Size1: char;
                    Ratio: Integer;
                    TempQty: Integer;
                    BundleNo: Integer;
                    BundleQty: Integer;
                    PreviuosBundleQty: Integer;
                    LineNo: Integer;
                    StickerSeq: Code[50];
                    //TempLot: text[20];
                    StyleVar: Code[50];
                    LotVar: Code[50];
                    X: Integer;
                    UserRec: Record "User Setup";
                    SizeSeq: BigInteger;
                begin
                    //Done By sachith on 18/04/23
                    UserRec.Reset();
                    UserRec.Get(UserId);
                    if UserRec."Factory Code" <> '' then begin
                        if (UserRec."Factory Code" <> rec."Factory Code") then
                            Error('You are not authorized to Create Bundles.')
                    end
                    else
                        Error('Factory not assigned for the user.');

                    LocationRec.Reset();
                    LocationRec.SetRange(Code, rec."Factory Code");
                    if not LocationRec.FindSet() then
                        Error('Cannot find Factory in location details.');

                    i := 1;
                    TempQty := 0;

                    if rec."Style Name" = '' then
                        Error('Invalid Style');

                    if rec."Component Group" = '' then
                        Error('Invalid Component Group');

                    if rec."Cut No New" = '' then
                        Error('Invalid Cut No');

                    if rec."Bundle Rule" = 0 then
                        Error('Invalid Bundle Rule');


                    //Delete old records
                    BundleGuideLineRec.Reset();
                    BundleGuideLineRec.SetRange("BundleGuideNo.", rec."BundleGuideNo.");
                    if BundleGuideLineRec.FindSet() then
                        BundleGuideLineRec.DeleteAll();

                    LaySheetRec.Reset();
                    LaySheetRec.SetRange("LaySheetNo.", rec."LaySheetNo.");
                    if not LaySheetRec.FindSet() then
                        Error('Cannot find matching Laysheet');

                    //Get Max bundle no
                    if LocationRec."Bundle Guide Sequence" = LocationRec."Bundle Guide Sequence"::Continue then begin
                        if Rec."Bundle No Start" = 0 then begin
                            //Get Max bundle no
                            BundleGuideLineRec.Reset();
                            BundleGuideLineRec.SetRange("Style No", rec."Style No.");
                            BundleGuideLineRec.SetCurrentKey("Bundle No");
                            BundleGuideLineRec.Ascending(true);
                            if BundleGuideLineRec.FindLast() then
                                BundleNo := BundleGuideLineRec."Bundle No";
                        end
                        else
                            BundleNo := Rec."Bundle No Start";
                    end
                    else
                        BundleNo := 0;


                    //Get Max Tempqty
                    if LocationRec."Bundle Guide Sequence" = LocationRec."Bundle Guide Sequence"::Continue then begin
                        if Rec."Sticker Seq Start" = 0 then begin
                            BundleGuideLineRec.Reset();
                            BundleGuideLineRec.SetRange("Style No", rec."Style No.");
                            BundleGuideLineRec.SetCurrentKey("Line No");
                            BundleGuideLineRec.Ascending(true);
                            if BundleGuideLineRec.FindLast() then
                                TempQty := BundleGuideLineRec.TempQty;
                        end
                        else
                            TempQty := Rec."Sticker Seq Start";
                    end
                    else
                        TempQty := 0;

                    //Get Sizes
                    LaySheetLine1Rec.Reset();
                    LaySheetLine1Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
                    LaySheetLine1Rec.SetFilter("Record Type", '=%1', 'SIZE');
                    if not LaySheetLine1Rec.FindSet() then
                        Error('Cannot find Sizes in Laysheet');

                    //Get ratio
                    LaySheetLine2Rec.Reset();
                    LaySheetLine2Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
                    LaySheetLine2Rec.SetFilter("Record Type", '=%1', 'RATIO');
                    if not LaySheetLine2Rec.FindSet() then
                        Error('Cannot find Ratio in Laysheet');

                    if rec."Bundle Method" = rec."Bundle Method"::Normal then begin

                        BundleQty := 0;
                        LaySheetLine4Rec.Reset();
                        LaySheetLine4Rec.SetRange("LaySheetNo.", LaySheetRec."LaySheetNo.");

                        if not LaySheetLine4Rec.FindSet() then
                            Error('Cannot find Roll/Shade Details in Laysheet Lines')
                        else begin

                            for i := 1 To 64 do begin

                                Size := '';
                                Ratio := 0;

                                case i of
                                    1:
                                        if LaySheetLine1Rec."1" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."1");
                                            if LaySheetLine2Rec."1" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."1");
                                        end;

                                    2:
                                        if LaySheetLine1Rec."2" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."2");
                                            if LaySheetLine2Rec."2" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."2");
                                        end;
                                    3:
                                        if LaySheetLine1Rec."3" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."3");
                                            if LaySheetLine2Rec."3" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."3");
                                        end;

                                    4:
                                        if LaySheetLine1Rec."4" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."4");
                                            if LaySheetLine2Rec."4" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."4");
                                        end;
                                    5:
                                        if LaySheetLine1Rec."5" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."5");
                                            if LaySheetLine2Rec."5" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."5");
                                        end;

                                    6:
                                        if LaySheetLine1Rec."6" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."6");
                                            if LaySheetLine2Rec."6" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."6");
                                        end;
                                    7:
                                        if LaySheetLine1Rec."7" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."7");
                                            if LaySheetLine2Rec."7" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."7");
                                        end;

                                    8:
                                        if LaySheetLine1Rec."8" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."8");
                                            if LaySheetLine2Rec."8" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."8");
                                        end;
                                    9:
                                        if LaySheetLine1Rec."9" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."9");
                                            if LaySheetLine2Rec."9" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."9");
                                        end;

                                    10:
                                        if LaySheetLine1Rec."10" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."10");
                                            if LaySheetLine2Rec."10" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."10");
                                        end;

                                    11:
                                        if LaySheetLine1Rec."11" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."11");
                                            if LaySheetLine2Rec."11" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."11");
                                        end;

                                    12:
                                        if LaySheetLine1Rec."12" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."12");
                                            if LaySheetLine2Rec."12" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."12");
                                        end;
                                    13:
                                        if LaySheetLine1Rec."13" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."13");
                                            if LaySheetLine2Rec."13" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."13");
                                        end;

                                    14:
                                        if LaySheetLine1Rec."14" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."14");
                                            if LaySheetLine2Rec."4" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."14");
                                        end;
                                    15:
                                        if LaySheetLine1Rec."15" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."15");
                                            if LaySheetLine2Rec."15" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."15");
                                        end;

                                    16:
                                        if LaySheetLine1Rec."16" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."16");
                                            if LaySheetLine2Rec."16" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."16");
                                        end;
                                    17:
                                        if LaySheetLine1Rec."17" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."17");
                                            if LaySheetLine2Rec."17" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."17");
                                        end;

                                    18:
                                        if LaySheetLine1Rec."18" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."18");
                                            if LaySheetLine2Rec."18" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."18");
                                        end;
                                    19:
                                        if LaySheetLine1Rec."19" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."19");
                                            if LaySheetLine2Rec."19" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."19");
                                        end;

                                    20:
                                        if LaySheetLine1Rec."20" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."20");
                                            if LaySheetLine2Rec."20" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."20");
                                        end;
                                    21:
                                        if LaySheetLine1Rec."21" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."21");
                                            if LaySheetLine2Rec."21" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."21");
                                        end;

                                    22:
                                        if LaySheetLine1Rec."22" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."22");
                                            if LaySheetLine2Rec."22" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."22");
                                        end;
                                    23:
                                        if LaySheetLine1Rec."23" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."23");
                                            if LaySheetLine2Rec."23" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."23");
                                        end;

                                    24:
                                        if LaySheetLine1Rec."24" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."24");
                                            if LaySheetLine2Rec."24" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."24");
                                        end;
                                    25:
                                        if LaySheetLine1Rec."25" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."25");
                                            if LaySheetLine2Rec."25" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."25");
                                        end;

                                    26:
                                        if LaySheetLine1Rec."26" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."26");
                                            if LaySheetLine2Rec."26" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."26");
                                        end;
                                    27:
                                        if LaySheetLine1Rec."27" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."27");
                                            if LaySheetLine2Rec."27" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."27");
                                        end;

                                    28:
                                        if LaySheetLine1Rec."28" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."28");
                                            if LaySheetLine2Rec."28" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."28");
                                        end;
                                    29:
                                        if LaySheetLine1Rec."29" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."29");
                                            if LaySheetLine2Rec."29" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."29");
                                        end;

                                    30:
                                        if LaySheetLine1Rec."30" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."30");
                                            if LaySheetLine2Rec."30" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."30");
                                        end;
                                    31:
                                        if LaySheetLine1Rec."31" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."31");
                                            if LaySheetLine2Rec."31" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."31");
                                        end;

                                    32:
                                        if LaySheetLine1Rec."32" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."32");
                                            if LaySheetLine2Rec."32" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."32");
                                        end;
                                    33:
                                        if LaySheetLine1Rec."33" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."33");
                                            if LaySheetLine2Rec."33" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."33");
                                        end;

                                    34:
                                        if LaySheetLine1Rec."34" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."34");
                                            if LaySheetLine2Rec."34" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."34");
                                        end;
                                    35:
                                        if LaySheetLine1Rec."35" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."35");
                                            if LaySheetLine2Rec."35" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."35");
                                        end;

                                    36:
                                        if LaySheetLine1Rec."36" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."36");
                                            if LaySheetLine2Rec."36" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."36");
                                        end;
                                    37:
                                        if LaySheetLine1Rec."37" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."37");
                                            if LaySheetLine2Rec."37" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."37");
                                        end;

                                    38:
                                        if LaySheetLine1Rec."38" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."38");
                                            if LaySheetLine2Rec."38" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."38");
                                        end;
                                    39:
                                        if LaySheetLine1Rec."39" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."39");
                                            if LaySheetLine2Rec."39" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."39");
                                        end;

                                    40:
                                        if LaySheetLine1Rec."40" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."40");
                                            if LaySheetLine2Rec."40" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."40");
                                        end;
                                    41:
                                        if LaySheetLine1Rec."41" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."41");
                                            if LaySheetLine2Rec."41" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."41");
                                        end;

                                    42:
                                        if LaySheetLine1Rec."42" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."42");
                                            if LaySheetLine2Rec."42" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."42");
                                        end;
                                    43:
                                        if LaySheetLine1Rec."43" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."43");
                                            if LaySheetLine2Rec."43" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."43");
                                        end;

                                    44:
                                        if LaySheetLine1Rec."44" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."44");
                                            if LaySheetLine2Rec."44" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."44");
                                        end;
                                    45:
                                        if LaySheetLine1Rec."45" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."45");
                                            if LaySheetLine2Rec."45" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."45");
                                        end;

                                    46:
                                        if LaySheetLine1Rec."46" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."46");
                                            if LaySheetLine2Rec."46" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."46");
                                        end;
                                    47:
                                        if LaySheetLine1Rec."47" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."47");
                                            if LaySheetLine2Rec."47" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."47");
                                        end;

                                    48:
                                        if LaySheetLine1Rec."48" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."48");
                                            if LaySheetLine2Rec."48" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."48");
                                        end;
                                    49:
                                        if LaySheetLine1Rec."49" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."49");
                                            if LaySheetLine2Rec."49" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."49");
                                        end;

                                    50:
                                        if LaySheetLine1Rec."50" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."50");
                                            if LaySheetLine2Rec."50" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."50");
                                        end;
                                    51:
                                        if LaySheetLine1Rec."51" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."51");
                                            if LaySheetLine2Rec."51" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."51");
                                        end;

                                    52:
                                        if LaySheetLine1Rec."52" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."52");
                                            if LaySheetLine2Rec."52" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."52");
                                        end;
                                    53:
                                        if LaySheetLine1Rec."53" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."53");
                                            if LaySheetLine2Rec."53" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."53");
                                        end;

                                    54:
                                        if LaySheetLine1Rec."54" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."54");
                                            if LaySheetLine2Rec."54" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."54");
                                        end;
                                    55:
                                        if LaySheetLine1Rec."55" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."55");
                                            if LaySheetLine2Rec."55" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."55");
                                        end;

                                    56:
                                        if LaySheetLine1Rec."56" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."56");
                                            if LaySheetLine2Rec."56" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."56");
                                        end;
                                    57:
                                        if LaySheetLine1Rec."57" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."57");
                                            if LaySheetLine2Rec."57" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."57");
                                        end;

                                    58:
                                        if LaySheetLine1Rec."58" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."58");
                                            if LaySheetLine2Rec."58" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."58");
                                        end;
                                    59:
                                        if LaySheetLine1Rec."59" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."59");
                                            if LaySheetLine2Rec."59" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."59");
                                        end;

                                    60:
                                        if LaySheetLine1Rec."60" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."60");
                                            if LaySheetLine2Rec."60" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."60");
                                        end;
                                    61:
                                        if LaySheetLine1Rec."61" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."61");
                                            if LaySheetLine2Rec."61" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."61");
                                        end;

                                    62:
                                        if LaySheetLine1Rec."62" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."62");
                                            if LaySheetLine2Rec."62" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."62");
                                        end;
                                    63:
                                        if LaySheetLine1Rec."63" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."63");
                                            if LaySheetLine2Rec."63" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."63");
                                        end;

                                    64:
                                        if LaySheetLine1Rec."64" <> '' then begin
                                            Evaluate(Size, LaySheetLine1Rec."64");
                                            if LaySheetLine2Rec."64" <> '' then
                                                Evaluate(Ratio, LaySheetLine2Rec."64");
                                        end;
                                end;

                                if Size <> '' then begin

                                    for j := 1 To Ratio do begin

                                        Size1 := j + 64;
                                        SizeSeq += 1;
                                        LaySheetLine4Rec.FindSet();

                                        repeat
                                            TempQty1 := 0;
                                            repeat
                                                if LaySheetLine4Rec."Actual Plies" = 0 then
                                                    Error('Actual Plies is zero in Laysheet.');

                                                if LaySheetLine4Rec."Actual Plies" <= rec."Bundle Rule" then
                                                    BundleQty := LaySheetLine4Rec."Actual Plies"
                                                else
                                                    BundleQty := rec."Bundle Rule";

                                                if TempQty1 + BundleQty <= LaySheetLine4Rec."Actual Plies" then begin

                                                    if (TempQty + BundleQty) < 10000 then begin

                                                        LineNo += 1;
                                                        BundleNo += 1;
                                                        StickerSeq := Format(TempQty + 1) + '-' + Format(TempQty + BundleQty);

                                                        BundleGuideLineRec.Init();
                                                        BundleGuideLineRec."Bundle No" := BundleNo;
                                                        BundleGuideLineRec."BundleGuideNo." := rec."BundleGuideNo.";
                                                        BundleGuideLineRec."Color Name" := LaySheetLine4Rec.Color;
                                                        BundleGuideLineRec."Color No" := LaySheetLine4Rec."Color No.";
                                                        BundleGuideLineRec."Created Date" := Today;
                                                        BundleGuideLineRec."Created User" := UserId;
                                                        BundleGuideLineRec."Cut No New" := rec."Cut No New";
                                                        BundleGuideLineRec."Line No" := LineNo;
                                                        BundleGuideLineRec."Shade Name" := LaySheetLine4Rec.Shade;
                                                        BundleGuideLineRec."Shade No" := LaySheetLine4Rec."Shade No";
                                                        BundleGuideLineRec.Qty := BundleQty;
                                                        BundleGuideLineRec.TempQty := TempQty + BundleQty;

                                                        if Ratio = 1 then
                                                            BundleGuideLineRec.Size := Size
                                                        else
                                                            BundleGuideLineRec.Size := Size + '-' + Size1;

                                                        BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                        BundleGuideLineRec."Bundle Method" := rec."Bundle Method"::Normal;
                                                        BundleGuideLineRec."Role ID" := '';
                                                        BundleGuideLineRec."Style No" := rec."Style No.";
                                                        BundleGuideLineRec."Style Name" := rec."Style Name";
                                                        BundleGuideLineRec.Lot := '';
                                                        BundleGuideLineRec.PO := LaySheetRec."PO No.";
                                                        BundleGuideLineRec.SizeSeq := SizeSeq;
                                                        BundleGuideLineRec.Insert();

                                                        TempQty := TempQty + BundleQty;
                                                        PreviuosBundleQty := BundleQty;
                                                        TempQty1 := TempQty1 + BundleQty;
                                                    end
                                                    else begin

                                                        StickerSeq := Format(TempQty + 1) + '-' + Format(9999);
                                                        LineNo += 1;
                                                        BundleNo += 1;

                                                        BundleGuideLineRec.Init();
                                                        BundleGuideLineRec."Bundle No" := BundleNo;
                                                        BundleGuideLineRec."BundleGuideNo." := rec."BundleGuideNo.";
                                                        BundleGuideLineRec."Color Name" := LaySheetLine4Rec.Color;
                                                        BundleGuideLineRec."Color No" := LaySheetLine4Rec."Color No.";
                                                        BundleGuideLineRec."Created Date" := Today;
                                                        BundleGuideLineRec."Created User" := UserId;
                                                        BundleGuideLineRec."Cut No New" := rec."Cut No New";
                                                        BundleGuideLineRec."Line No" := LineNo;
                                                        BundleGuideLineRec."Shade Name" := LaySheetLine4Rec.Shade;
                                                        BundleGuideLineRec."Shade No" := LaySheetLine4Rec."Shade No";
                                                        BundleGuideLineRec.Qty := 9999 - TempQty;
                                                        BundleGuideLineRec.TempQty := 0;

                                                        if Ratio = 1 then
                                                            BundleGuideLineRec.Size := Size
                                                        else
                                                            BundleGuideLineRec.Size := Size + '-' + Size1;

                                                        BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                        BundleGuideLineRec."Bundle Method" := rec."Bundle Method"::Normal;
                                                        BundleGuideLineRec."Style No" := rec."Style No.";
                                                        BundleGuideLineRec."Style Name" := rec."Style Name";
                                                        BundleGuideLineRec."Role ID" := '';
                                                        BundleGuideLineRec.Lot := '';
                                                        BundleGuideLineRec.PO := LaySheetRec."PO No.";
                                                        BundleGuideLineRec.SizeSeq := SizeSeq;
                                                        BundleGuideLineRec.Insert();

                                                        PreviuosBundleQty := 9999 - TempQty;
                                                        TempQty1 := TempQty1 + (9999 - TempQty);
                                                        TempQty := 0;
                                                    end;
                                                end
                                                else begin
                                                    if (LaySheetLine4Rec."Actual Plies" - TempQty1) > rec."Bundle Rule" / 2 then begin
                                                        if (TempQty + BundleQty) < 10000 then begin

                                                            LineNo += 1;
                                                            BundleNo += 1;
                                                            StickerSeq := Format(TempQty + 1) + '-' + Format(TempQty + (LaySheetLine4Rec."Actual Plies" - TempQty1));

                                                            BundleGuideLineRec.Init();
                                                            BundleGuideLineRec."Bundle No" := BundleNo;
                                                            BundleGuideLineRec."BundleGuideNo." := rec."BundleGuideNo.";
                                                            BundleGuideLineRec."Color Name" := LaySheetLine4Rec.Color;
                                                            BundleGuideLineRec."Color No" := LaySheetLine4Rec."Color No.";
                                                            BundleGuideLineRec."Created Date" := Today;
                                                            BundleGuideLineRec."Created User" := UserId;
                                                            BundleGuideLineRec."Cut No New" := rec."Cut No New";
                                                            BundleGuideLineRec."Line No" := LineNo;
                                                            BundleGuideLineRec."Shade Name" := LaySheetLine4Rec.Shade;
                                                            BundleGuideLineRec."Shade No" := LaySheetLine4Rec."Shade No";
                                                            BundleGuideLineRec.Qty := LaySheetLine4Rec."Actual Plies" - TempQty1;
                                                            BundleGuideLineRec.TempQty := TempQty + LaySheetLine4Rec."Actual Plies" - TempQty1;

                                                            if Ratio = 1 then
                                                                BundleGuideLineRec.Size := Size
                                                            else
                                                                BundleGuideLineRec.Size := Size + '-' + Size1;

                                                            BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                            BundleGuideLineRec."Bundle Method" := rec."Bundle Method"::Normal;
                                                            BundleGuideLineRec."Role ID" := '';
                                                            BundleGuideLineRec."Style No" := rec."Style No.";
                                                            BundleGuideLineRec."Style Name" := rec."Style Name";
                                                            BundleGuideLineRec.Lot := '';
                                                            BundleGuideLineRec.PO := LaySheetRec."PO No.";
                                                            BundleGuideLineRec.SizeSeq := SizeSeq;
                                                            BundleGuideLineRec.Insert();

                                                            TempQty := TempQty + LaySheetLine4Rec."Actual Plies" - TempQty1;
                                                            PreviuosBundleQty := LaySheetLine4Rec."Actual Plies" - TempQty1;
                                                            TempQty1 := TempQty1 + (LaySheetLine4Rec."Actual Plies" - TempQty1);
                                                        end
                                                        else begin

                                                            StickerSeq := Format(TempQty + 1) + '-' + Format(9999);
                                                            LineNo += 1;
                                                            BundleNo += 1;

                                                            BundleGuideLineRec.Init();
                                                            BundleGuideLineRec."Bundle No" := BundleNo;
                                                            BundleGuideLineRec."BundleGuideNo." := rec."BundleGuideNo.";
                                                            BundleGuideLineRec."Color Name" := LaySheetLine4Rec.Color;
                                                            BundleGuideLineRec."Color No" := LaySheetLine4Rec."Color No.";
                                                            BundleGuideLineRec."Created Date" := Today;
                                                            BundleGuideLineRec."Created User" := UserId;
                                                            BundleGuideLineRec."Cut No New" := rec."Cut No New";
                                                            BundleGuideLineRec."Line No" := LineNo;
                                                            BundleGuideLineRec."Shade Name" := LaySheetLine4Rec.Shade;
                                                            BundleGuideLineRec."Shade No" := LaySheetLine4Rec."Shade No";
                                                            BundleGuideLineRec.Qty := 9999 - LaySheetLine4Rec."Actual Plies" - TempQty1;
                                                            BundleGuideLineRec.TempQty := 0;

                                                            if Ratio = 1 then
                                                                BundleGuideLineRec.Size := Size
                                                            else
                                                                BundleGuideLineRec.Size := Size + '-' + Size1;

                                                            BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                            BundleGuideLineRec."Bundle Method" := rec."Bundle Method"::Normal;
                                                            BundleGuideLineRec."Style No" := rec."Style No.";
                                                            BundleGuideLineRec."Style Name" := rec."Style Name";
                                                            BundleGuideLineRec."Role ID" := '';
                                                            BundleGuideLineRec.Lot := '';
                                                            BundleGuideLineRec.PO := LaySheetRec."PO No.";
                                                            BundleGuideLineRec.SizeSeq := SizeSeq;
                                                            BundleGuideLineRec.Insert();

                                                            PreviuosBundleQty := 9999 - TempQty;
                                                            TempQty1 := TempQty1 + (9999 - TempQty);
                                                            TempQty := 0;
                                                        end;
                                                    end
                                                    else begin
                                                        BundleQty := LaySheetLine4Rec."Actual Plies" - TempQty1;
                                                        StickerSeq := Format(TempQty - PreviuosBundleQty + 1) + '-' + Format(TempQty + BundleQty);

                                                        //modify previous entry
                                                        BundleGuideLineRec.Reset();
                                                        BundleGuideLineRec.SetRange("BundleGuideNo.", rec."BundleGuideNo.");
                                                        BundleGuideLineRec.SetRange("Line No", LineNo);
                                                        BundleGuideLineRec.FindSet();
                                                        BundleGuideLineRec.Qty := BundleGuideLineRec.Qty + BundleQty;
                                                        BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                        BundleGuideLineRec.TempQty := TempQty + BundleQty;
                                                        BundleGuideLineRec.Modify();

                                                        TempQty1 := TempQty1 + BundleQty;
                                                        TempQty := TempQty + BundleQty;
                                                    end;
                                                end;
                                            until TempQty1 >= LaySheetLine4Rec."Actual Plies";
                                        until LaySheetLine4Rec.Next() = 0;
                                    end;
                                end;
                            end;
                        end;
                    end
                    else begin
                        if rec."Bundle Method" = rec."Bundle Method"::"Roll Wise" then begin

                            BundleQty := 0;
                            LaySheetLine4Rec.Reset();
                            LaySheetLine4Rec.SetRange("LaySheetNo.", LaySheetRec."LaySheetNo.");

                            if not LaySheetLine4Rec.FindSet() then
                                Error('Cannot find Roll/Shade Details in Laysheet Lines')
                            else begin

                                for i := 1 To 64 do begin

                                    Size := '';
                                    Ratio := 0;

                                    case i of
                                        1:
                                            if LaySheetLine1Rec."1" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."1");
                                                if LaySheetLine2Rec."1" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."1");
                                            end;

                                        2:
                                            if LaySheetLine1Rec."2" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."2");
                                                if LaySheetLine2Rec."2" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."2");
                                            end;
                                        3:
                                            if LaySheetLine1Rec."3" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."3");
                                                if LaySheetLine2Rec."3" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."3");
                                            end;

                                        4:
                                            if LaySheetLine1Rec."4" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."4");
                                                if LaySheetLine2Rec."4" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."4");
                                            end;
                                        5:
                                            if LaySheetLine1Rec."5" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."5");
                                                if LaySheetLine2Rec."5" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."5");
                                            end;

                                        6:
                                            if LaySheetLine1Rec."6" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."6");
                                                if LaySheetLine2Rec."6" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."6");
                                            end;
                                        7:
                                            if LaySheetLine1Rec."7" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."7");
                                                if LaySheetLine2Rec."7" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."7");
                                            end;

                                        8:
                                            if LaySheetLine1Rec."8" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."8");
                                                if LaySheetLine2Rec."8" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."8");
                                            end;
                                        9:
                                            if LaySheetLine1Rec."9" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."9");
                                                if LaySheetLine2Rec."9" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."9");
                                            end;

                                        10:
                                            if LaySheetLine1Rec."10" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."10");
                                                if LaySheetLine2Rec."10" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."10");
                                            end;

                                        11:
                                            if LaySheetLine1Rec."11" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."11");
                                                if LaySheetLine2Rec."11" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."11");
                                            end;

                                        12:
                                            if LaySheetLine1Rec."12" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."12");
                                                if LaySheetLine2Rec."12" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."12");
                                            end;
                                        13:
                                            if LaySheetLine1Rec."13" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."13");
                                                if LaySheetLine2Rec."13" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."13");
                                            end;

                                        14:
                                            if LaySheetLine1Rec."14" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."14");
                                                if LaySheetLine2Rec."4" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."14");
                                            end;
                                        15:
                                            if LaySheetLine1Rec."15" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."15");
                                                if LaySheetLine2Rec."15" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."15");
                                            end;

                                        16:
                                            if LaySheetLine1Rec."16" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."16");
                                                if LaySheetLine2Rec."16" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."16");
                                            end;
                                        17:
                                            if LaySheetLine1Rec."17" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."17");
                                                if LaySheetLine2Rec."17" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."17");
                                            end;

                                        18:
                                            if LaySheetLine1Rec."18" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."18");
                                                if LaySheetLine2Rec."18" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."18");
                                            end;
                                        19:
                                            if LaySheetLine1Rec."19" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."19");
                                                if LaySheetLine2Rec."19" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."19");
                                            end;

                                        20:
                                            if LaySheetLine1Rec."20" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."20");
                                                if LaySheetLine2Rec."20" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."20");
                                            end;
                                        21:
                                            if LaySheetLine1Rec."21" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."21");
                                                if LaySheetLine2Rec."21" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."21");
                                            end;

                                        22:
                                            if LaySheetLine1Rec."22" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."22");
                                                if LaySheetLine2Rec."22" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."22");
                                            end;
                                        23:
                                            if LaySheetLine1Rec."23" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."23");
                                                if LaySheetLine2Rec."23" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."23");
                                            end;

                                        24:
                                            if LaySheetLine1Rec."24" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."24");
                                                if LaySheetLine2Rec."24" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."24");
                                            end;
                                        25:
                                            if LaySheetLine1Rec."25" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."25");
                                                if LaySheetLine2Rec."25" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."25");
                                            end;

                                        26:
                                            if LaySheetLine1Rec."26" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."26");
                                                if LaySheetLine2Rec."26" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."26");
                                            end;
                                        27:
                                            if LaySheetLine1Rec."27" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."27");
                                                if LaySheetLine2Rec."27" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."27");
                                            end;

                                        28:
                                            if LaySheetLine1Rec."28" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."28");
                                                if LaySheetLine2Rec."28" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."28");
                                            end;
                                        29:
                                            if LaySheetLine1Rec."29" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."29");
                                                if LaySheetLine2Rec."29" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."29");
                                            end;

                                        30:
                                            if LaySheetLine1Rec."30" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."30");
                                                if LaySheetLine2Rec."30" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."30");
                                            end;
                                        31:
                                            if LaySheetLine1Rec."31" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."31");
                                                if LaySheetLine2Rec."31" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."31");
                                            end;

                                        32:
                                            if LaySheetLine1Rec."32" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."32");
                                                if LaySheetLine2Rec."32" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."32");
                                            end;
                                        33:
                                            if LaySheetLine1Rec."33" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."33");
                                                if LaySheetLine2Rec."33" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."33");
                                            end;

                                        34:
                                            if LaySheetLine1Rec."34" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."34");
                                                if LaySheetLine2Rec."34" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."34");
                                            end;
                                        35:
                                            if LaySheetLine1Rec."35" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."35");
                                                if LaySheetLine2Rec."35" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."35");
                                            end;

                                        36:
                                            if LaySheetLine1Rec."36" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."36");
                                                if LaySheetLine2Rec."36" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."36");
                                            end;
                                        37:
                                            if LaySheetLine1Rec."37" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."37");
                                                if LaySheetLine2Rec."37" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."37");
                                            end;

                                        38:
                                            if LaySheetLine1Rec."38" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."38");
                                                if LaySheetLine2Rec."38" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."38");
                                            end;
                                        39:
                                            if LaySheetLine1Rec."39" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."39");
                                                if LaySheetLine2Rec."39" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."39");
                                            end;

                                        40:
                                            if LaySheetLine1Rec."40" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."40");
                                                if LaySheetLine2Rec."40" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."40");
                                            end;
                                        41:
                                            if LaySheetLine1Rec."41" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."41");
                                                if LaySheetLine2Rec."41" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."41");
                                            end;

                                        42:
                                            if LaySheetLine1Rec."42" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."42");
                                                if LaySheetLine2Rec."42" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."42");
                                            end;
                                        43:
                                            if LaySheetLine1Rec."43" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."43");
                                                if LaySheetLine2Rec."43" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."43");
                                            end;

                                        44:
                                            if LaySheetLine1Rec."44" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."44");
                                                if LaySheetLine2Rec."44" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."44");
                                            end;
                                        45:
                                            if LaySheetLine1Rec."45" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."45");
                                                if LaySheetLine2Rec."45" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."45");
                                            end;

                                        46:
                                            if LaySheetLine1Rec."46" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."46");
                                                if LaySheetLine2Rec."46" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."46");
                                            end;
                                        47:
                                            if LaySheetLine1Rec."47" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."47");
                                                if LaySheetLine2Rec."47" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."47");
                                            end;

                                        48:
                                            if LaySheetLine1Rec."48" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."48");
                                                if LaySheetLine2Rec."48" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."48");
                                            end;
                                        49:
                                            if LaySheetLine1Rec."49" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."49");
                                                if LaySheetLine2Rec."49" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."49");
                                            end;

                                        50:
                                            if LaySheetLine1Rec."50" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."50");
                                                if LaySheetLine2Rec."50" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."50");
                                            end;
                                        51:
                                            if LaySheetLine1Rec."51" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."51");
                                                if LaySheetLine2Rec."51" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."51");
                                            end;

                                        52:
                                            if LaySheetLine1Rec."52" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."52");
                                                if LaySheetLine2Rec."52" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."52");
                                            end;
                                        53:
                                            if LaySheetLine1Rec."53" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."53");
                                                if LaySheetLine2Rec."53" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."53");
                                            end;

                                        54:
                                            if LaySheetLine1Rec."54" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."54");
                                                if LaySheetLine2Rec."54" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."54");
                                            end;
                                        55:
                                            if LaySheetLine1Rec."55" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."55");
                                                if LaySheetLine2Rec."55" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."55");
                                            end;

                                        56:
                                            if LaySheetLine1Rec."56" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."56");
                                                if LaySheetLine2Rec."56" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."56");
                                            end;
                                        57:
                                            if LaySheetLine1Rec."57" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."57");
                                                if LaySheetLine2Rec."57" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."57");
                                            end;

                                        58:
                                            if LaySheetLine1Rec."58" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."58");
                                                if LaySheetLine2Rec."58" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."58");
                                            end;
                                        59:
                                            if LaySheetLine1Rec."59" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."59");
                                                if LaySheetLine2Rec."59" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."59");
                                            end;

                                        60:
                                            if LaySheetLine1Rec."60" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."60");
                                                if LaySheetLine2Rec."60" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."60");
                                            end;
                                        61:
                                            if LaySheetLine1Rec."61" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."61");
                                                if LaySheetLine2Rec."61" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."61");
                                            end;

                                        62:
                                            if LaySheetLine1Rec."62" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."62");
                                                if LaySheetLine2Rec."62" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."62");
                                            end;
                                        63:
                                            if LaySheetLine1Rec."63" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."63");
                                                if LaySheetLine2Rec."63" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."63");
                                            end;

                                        64:
                                            if LaySheetLine1Rec."64" <> '' then begin
                                                Evaluate(Size, LaySheetLine1Rec."64");
                                                if LaySheetLine2Rec."64" <> '' then
                                                    Evaluate(Ratio, LaySheetLine2Rec."64");
                                            end;
                                    end;

                                    if Size <> '' then begin

                                        for j := 1 To Ratio do begin

                                            Size1 := j + 64;
                                            SizeSeq += 1;
                                            LaySheetLine4Rec.FindSet();

                                            repeat
                                                TempQty1 := 0;
                                                repeat
                                                    if LaySheetLine4Rec."Actual Plies" = 0 then
                                                        Error('Actual Plies is zero in Laysheet.');

                                                    if LaySheetLine4Rec."Actual Plies" <= rec."Bundle Rule" then
                                                        BundleQty := LaySheetLine4Rec."Actual Plies"
                                                    else
                                                        BundleQty := rec."Bundle Rule";

                                                    if TempQty1 + BundleQty <= LaySheetLine4Rec."Actual Plies" then begin

                                                        if (TempQty + BundleQty) < 10000 then begin

                                                            LineNo += 1;
                                                            BundleNo += 1;
                                                            StickerSeq := Format(TempQty + 1) + '-' + Format(TempQty + BundleQty);

                                                            BundleGuideLineRec.Init();
                                                            BundleGuideLineRec."Bundle No" := BundleNo;
                                                            BundleGuideLineRec."BundleGuideNo." := rec."BundleGuideNo.";
                                                            BundleGuideLineRec."Color Name" := LaySheetLine4Rec.Color;
                                                            BundleGuideLineRec."Color No" := LaySheetLine4Rec."Color No.";
                                                            BundleGuideLineRec."Created Date" := Today;
                                                            BundleGuideLineRec."Created User" := UserId;
                                                            BundleGuideLineRec."Cut No New" := rec."Cut No New";
                                                            BundleGuideLineRec."Line No" := LineNo;
                                                            BundleGuideLineRec."Shade Name" := LaySheetLine4Rec.Shade;
                                                            BundleGuideLineRec."Shade No" := LaySheetLine4Rec."Shade No";
                                                            BundleGuideLineRec.Qty := BundleQty;
                                                            BundleGuideLineRec.TempQty := TempQty + BundleQty;

                                                            if Ratio = 1 then
                                                                BundleGuideLineRec.Size := Size
                                                            else
                                                                BundleGuideLineRec.Size := Size + '-' + Size1;

                                                            BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                            BundleGuideLineRec."Bundle Method" := rec."Bundle Method"::"Roll Wise";
                                                            BundleGuideLineRec."Role ID" := LaySheetLine4Rec."Role ID";
                                                            BundleGuideLineRec."Style No" := rec."Style No.";
                                                            BundleGuideLineRec."Style Name" := rec."Style Name";
                                                            BundleGuideLineRec.Lot := LaySheetLine4Rec."Role ID";
                                                            BundleGuideLineRec.PO := LaySheetRec."PO No.";
                                                            BundleGuideLineRec.SizeSeq := SizeSeq;
                                                            BundleGuideLineRec.Insert();

                                                            TempQty := TempQty + BundleQty;
                                                            PreviuosBundleQty := BundleQty;
                                                            TempQty1 := TempQty1 + BundleQty;
                                                        end
                                                        else begin

                                                            StickerSeq := Format(TempQty + 1) + '-' + Format(9999);
                                                            LineNo += 1;
                                                            BundleNo += 1;

                                                            BundleGuideLineRec.Init();
                                                            BundleGuideLineRec."Bundle No" := BundleNo;
                                                            BundleGuideLineRec."BundleGuideNo." := rec."BundleGuideNo.";
                                                            BundleGuideLineRec."Color Name" := LaySheetLine4Rec.Color;
                                                            BundleGuideLineRec."Color No" := LaySheetLine4Rec."Color No.";
                                                            BundleGuideLineRec."Created Date" := Today;
                                                            BundleGuideLineRec."Created User" := UserId;
                                                            BundleGuideLineRec."Cut No New" := rec."Cut No New";
                                                            BundleGuideLineRec."Line No" := LineNo;
                                                            BundleGuideLineRec."Shade Name" := LaySheetLine4Rec.Shade;
                                                            BundleGuideLineRec."Shade No" := LaySheetLine4Rec."Shade No";
                                                            BundleGuideLineRec.Qty := 9999 - TempQty;
                                                            BundleGuideLineRec.TempQty := 0;

                                                            if Ratio = 1 then
                                                                BundleGuideLineRec.Size := Size
                                                            else
                                                                BundleGuideLineRec.Size := Size + '-' + Size1;

                                                            BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                            BundleGuideLineRec."Bundle Method" := rec."Bundle Method"::"Roll Wise";
                                                            BundleGuideLineRec."Style No" := rec."Style No.";
                                                            BundleGuideLineRec."Style Name" := rec."Style Name";
                                                            BundleGuideLineRec."Role ID" := LaySheetLine4Rec."Role ID";
                                                            BundleGuideLineRec.Lot := '';
                                                            BundleGuideLineRec.PO := LaySheetRec."PO No.";
                                                            BundleGuideLineRec.SizeSeq := SizeSeq;
                                                            BundleGuideLineRec.Insert();

                                                            PreviuosBundleQty := 9999 - TempQty;
                                                            TempQty1 := TempQty1 + (9999 - TempQty);
                                                            TempQty := 0;
                                                        end;
                                                    end
                                                    else begin
                                                        if (LaySheetLine4Rec."Actual Plies" - TempQty1) > rec."Bundle Rule" / 2 then begin
                                                            if (TempQty + BundleQty) < 10000 then begin

                                                                LineNo += 1;
                                                                BundleNo += 1;
                                                                StickerSeq := Format(TempQty + 1) + '-' + Format(TempQty + (LaySheetLine4Rec."Actual Plies" - TempQty1));

                                                                BundleGuideLineRec.Init();
                                                                BundleGuideLineRec."Bundle No" := BundleNo;
                                                                BundleGuideLineRec."BundleGuideNo." := rec."BundleGuideNo.";
                                                                BundleGuideLineRec."Color Name" := LaySheetLine4Rec.Color;
                                                                BundleGuideLineRec."Color No" := LaySheetLine4Rec."Color No.";
                                                                BundleGuideLineRec."Created Date" := Today;
                                                                BundleGuideLineRec."Created User" := UserId;
                                                                BundleGuideLineRec."Cut No New" := rec."Cut No New";
                                                                BundleGuideLineRec."Line No" := LineNo;
                                                                BundleGuideLineRec."Shade Name" := LaySheetLine4Rec.Shade;
                                                                BundleGuideLineRec."Shade No" := LaySheetLine4Rec."Shade No";
                                                                BundleGuideLineRec.Qty := LaySheetLine4Rec."Actual Plies" - TempQty1;
                                                                BundleGuideLineRec.TempQty := TempQty + LaySheetLine4Rec."Actual Plies" - TempQty1;

                                                                if Ratio = 1 then
                                                                    BundleGuideLineRec.Size := Size
                                                                else
                                                                    BundleGuideLineRec.Size := Size + '-' + Size1;

                                                                BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                                BundleGuideLineRec."Bundle Method" := rec."Bundle Method"::"Roll Wise";
                                                                BundleGuideLineRec."Role ID" := LaySheetLine4Rec."Role ID";
                                                                BundleGuideLineRec."Style No" := rec."Style No.";
                                                                BundleGuideLineRec."Style Name" := rec."Style Name";
                                                                BundleGuideLineRec.Lot := '';
                                                                BundleGuideLineRec.PO := LaySheetRec."PO No.";
                                                                BundleGuideLineRec.SizeSeq := SizeSeq;
                                                                BundleGuideLineRec.Insert();

                                                                TempQty := TempQty + LaySheetLine4Rec."Actual Plies" - TempQty1;
                                                                PreviuosBundleQty := LaySheetLine4Rec."Actual Plies" - TempQty1;
                                                                TempQty1 := TempQty1 + (LaySheetLine4Rec."Actual Plies" - TempQty1);
                                                            end
                                                            else begin

                                                                StickerSeq := Format(TempQty + 1) + '-' + Format(9999);
                                                                LineNo += 1;
                                                                BundleNo += 1;

                                                                BundleGuideLineRec.Init();
                                                                BundleGuideLineRec."Bundle No" := BundleNo;
                                                                BundleGuideLineRec."BundleGuideNo." := rec."BundleGuideNo.";
                                                                BundleGuideLineRec."Color Name" := LaySheetLine4Rec.Color;
                                                                BundleGuideLineRec."Color No" := LaySheetLine4Rec."Color No.";
                                                                BundleGuideLineRec."Created Date" := Today;
                                                                BundleGuideLineRec."Created User" := UserId;
                                                                BundleGuideLineRec."Cut No New" := rec."Cut No New";
                                                                BundleGuideLineRec."Line No" := LineNo;
                                                                BundleGuideLineRec."Shade Name" := LaySheetLine4Rec.Shade;
                                                                BundleGuideLineRec."Shade No" := LaySheetLine4Rec."Shade No";
                                                                BundleGuideLineRec.Qty := 9999 - LaySheetLine4Rec."Actual Plies" - TempQty1;
                                                                BundleGuideLineRec.TempQty := 0;

                                                                if Ratio = 1 then
                                                                    BundleGuideLineRec.Size := Size
                                                                else
                                                                    BundleGuideLineRec.Size := Size + '-' + Size1;

                                                                BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                                BundleGuideLineRec."Bundle Method" := rec."Bundle Method"::"Roll Wise";
                                                                BundleGuideLineRec."Style No" := rec."Style No.";
                                                                BundleGuideLineRec."Style Name" := rec."Style Name";
                                                                BundleGuideLineRec."Role ID" := LaySheetLine4Rec."Role ID";
                                                                BundleGuideLineRec.Lot := '';
                                                                BundleGuideLineRec.PO := LaySheetRec."PO No.";
                                                                BundleGuideLineRec.SizeSeq := SizeSeq;
                                                                BundleGuideLineRec.Insert();

                                                                PreviuosBundleQty := 9999 - TempQty;
                                                                TempQty1 := TempQty1 + (9999 - TempQty);
                                                                TempQty := 0;
                                                            end;
                                                        end
                                                        else begin
                                                            BundleQty := LaySheetLine4Rec."Actual Plies" - TempQty1;
                                                            StickerSeq := Format(TempQty - PreviuosBundleQty + 1) + '-' + Format(TempQty + BundleQty);

                                                            //modify previous entry
                                                            BundleGuideLineRec.Reset();
                                                            BundleGuideLineRec.SetRange("BundleGuideNo.", rec."BundleGuideNo.");
                                                            BundleGuideLineRec.SetRange("Line No", LineNo);
                                                            BundleGuideLineRec.FindSet();
                                                            BundleGuideLineRec.Qty := BundleGuideLineRec.Qty + BundleQty;
                                                            BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                            BundleGuideLineRec.TempQty := TempQty + BundleQty;
                                                            BundleGuideLineRec.Modify();

                                                            TempQty1 := TempQty1 + BundleQty;
                                                            TempQty := TempQty + BundleQty;
                                                        end;
                                                    end;
                                                until TempQty1 >= LaySheetLine4Rec."Actual Plies";
                                            until LaySheetLine4Rec.Next() = 0;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;

                    Message('Completed.');
                end;
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        BundleGuideLineRec: Record BundleGuideLine;
        UserRec: Record "User Setup";
    begin
        //Done By sachith on 04/04/23
        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.')
        end
        else
            Error('You are not authorized to delete records.');

        BundleGuideLineRec.reset();
        BundleGuideLineRec.SetRange("BundleGuideNo.", rec."BundleGuideNo.");
        if BundleGuideLineRec.FindSet() then
            BundleGuideLineRec.DeleteAll();
    end;


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."BundleGuide Nos.", xRec."BundleGuideNo.", rec."BundleGuideNo.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."BundleGuideNo.");
            EXIT(TRUE);
        END;
    end;


    //Done By Sachith on 03/04/23 
    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        UserRec.Reset();
        UserRec.Get(UserId);
        if rec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> '') then begin
                if (UserRec."Factory Code" = rec."Factory Code") then
                    EditableGB := true
                else
                    EditableGB := false;
            end
            else
                EditableGB := false;
        end
        else
            if (UserRec."Factory Code" = '') then begin
                Error('Factory not assigned for the user.');
                EditableGB := false;
            end
            else
                EditableGB := true;
    end;


    var
        EditableGB: Boolean;
}