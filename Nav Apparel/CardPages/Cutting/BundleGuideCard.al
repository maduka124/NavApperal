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
                field("BundleGuideNo."; rec."BundleGuideNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Bundle Guide No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", rec."Style Name");
                        if StyleMasterRec.FindSet() then
                            rec."Style No." := StyleMasterRec."No.";

                        //Check whether user logged in or not
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

                        CurrPage.Update();
                    end;
                }

                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';

                    trigger OnLookup(var texts: text): Boolean
                    var
                        AssoDetailsRec: Record AssortmentDetails;
                        Colour: Code[20];
                        colorRec: Record Colour;
                    begin
                        AssoDetailsRec.RESET;
                        AssoDetailsRec.SetCurrentKey("Colour No");
                        AssoDetailsRec.SetRange("Style No.", rec."Style No.");

                        IF AssoDetailsRec.FINDFIRST THEN BEGIN
                            REPEAT
                                IF Colour <> AssoDetailsRec."Colour No" THEN BEGIN
                                    Colour := AssoDetailsRec."Colour No";

                                    AssoDetailsRec.MARK(TRUE);
                                END;
                            UNTIL AssoDetailsRec.NEXT = 0;
                            AssoDetailsRec.MARKEDONLY(TRUE);

                            if Page.RunModal(51014, AssoDetailsRec) = Action::LookupOK then begin
                                rec."Color No" := AssoDetailsRec."Colour No";
                                rec."Color Name" := AssoDetailsRec."Colour Name";
                            end;

                        END;
                    END;
                }

                field("Group ID"; rec."Group ID")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SewJobLine4Rec: Record SewingJobCreationLine4;
                    begin
                        SewJobLine4Rec.Reset();
                        SewJobLine4Rec.SetRange("Style No.", rec."Style No.");
                        SewJobLine4Rec.SetRange("Colour No", rec."Color No");
                        SewJobLine4Rec.SetRange("Group ID", rec."Group ID");
                        if SewJobLine4Rec.FindSet() then
                            rec."Po No." := SewJobLine4Rec."PO No."
                        else
                            Error('Cannot find sewing job details for Style/Color/Group');

                        CurrPage.Update();
                    end;
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
                }

                field("Cut No"; rec."Cut No")
                {
                    ApplicationArea = All;
                }

                field("Bundle Rule"; rec."Bundle Rule")
                {
                    ApplicationArea = All;
                }

                field("Bundle Method"; rec."Bundle Method")
                {
                    ApplicationArea = All;
                }
            }

            group("Bundle Details")
            {
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
                    CutProgLineRec: Record CuttingProgressLine;
                    CutProgHeadRec: Record CuttingProgressHeader;
                    BundleGuideLineRec: Record BundleGuideLine;
                    SewJobRec: Record SewingJobCreationLine4;
                    CutCreLine1Rec: Record CutCreationLine;
                    CutCreRec: Record CutCreation;
                    CutCreLineRec: Record CutCreationLine;
                    LaySheetRec: Record LaySheetHeader;
                    StyleMasPoRec: Record "Style Master PO";
                    Plies: Integer;
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
                    TempLot: text[20];
                    StyleVar: Code[50];
                    LotVar: Code[50];
                begin

                    i := 1;
                    TempQty := 0;

                    if rec."Style Name" = '' then
                        Error('Invalid Style');

                    if rec."Color Name" = '' then
                        Error('Invalid Color');

                    if rec."Group ID" = 0 then
                        Error('Invalid Group ID');

                    if rec."Component Group" = '' then
                        Error('Invalid Component Group');

                    if rec."Cut No" = 0 then
                        Error('Invalid Cut No');

                    if rec."Bundle Rule" = 0 then
                        Error('Invalid Bundle Rule');


                    //Delete old records
                    BundleGuideLineRec.Reset();
                    BundleGuideLineRec.SetRange("BundleGuideNo.", rec."BundleGuideNo.");
                    if BundleGuideLineRec.FindSet() then
                        BundleGuideLineRec.DeleteAll();


                    //Get Sewing jOb no
                    SewJobRec.Reset();
                    SewJobRec.SetRange("Style No.", rec."Style No.");
                    SewJobRec.SetRange("Colour No", rec."Color No");
                    SewJobRec.SetRange("Group ID", rec."Group ID");
                    SewJobRec.SetFilter("Record Type", '=%1', 'L');
                    if SewJobRec.FindSet() then begin


                        //Get Max bundle no
                        BundleGuideLineRec.Reset();

                        if BundleGuideLineRec.FindLast() then
                            BundleNo := BundleGuideLineRec."Bundle No";

                        if BundleNo = 9999 then
                            BundleNo := 0;


                        CutCreLineRec.Reset();
                        CutCreLineRec.SetRange("Style No.", rec."Style No.");
                        CutCreLineRec.SetRange("Colour No", rec."Color No");
                        CutCreLineRec.SetRange("Group ID", rec."Group ID");
                        CutCreLineRec.SetRange("Component Group Code", rec."Component Group");
                        //CutCreLineRec.SetFilter("Cut No", '=%1', 0);
                        CutCreLineRec.SetFilter("Record Type", '=%1', 'H');

                        if not CutCreLineRec.FindSet() then
                            Error('Cannot find sizes');


                        //Get Sizes
                        CutCreLineRec.Reset();
                        CutCreLineRec.SetRange("Style No.", rec."Style No.");
                        CutCreLineRec.SetRange("Colour No", rec."Color No");
                        CutCreLineRec.SetRange("Group ID", rec."Group ID");
                        CutCreLineRec.SetRange("Component Group Code", rec."Component Group");
                        //CutCreLineRec.SetFilter("Cut No", '=%1', 0);
                        CutCreLineRec.SetFilter("Record Type", '=%1', 'H');

                        if not CutCreLineRec.FindSet() then
                            Error('Cannot find sizes');


                        //Get ratio
                        CutCreLine1Rec.Reset();
                        CutCreLine1Rec.SetRange("Style No.", rec."Style No.");
                        CutCreLine1Rec.SetRange("Colour No", rec."Color No");
                        CutCreLine1Rec.SetRange("Group ID", rec."Group ID");
                        CutCreLine1Rec.SetRange("Component Group Code", rec."Component Group");
                        CutCreLine1Rec.SetFilter("Cut No", '=%1', 0);
                        CutCreLine1Rec.SetFilter("Record Type", '=%1', 'R');

                        if not CutCreLine1Rec.FindSet() then
                            Error('Cannot find Ratio for the sizes');


                        CutCreRec.Reset();
                        CutCreRec.SetRange("Style No.", rec."Style No.");
                        CutCreRec.SetRange("Colour No", rec."Color No");
                        CutCreRec.SetRange("Group ID", rec."Group ID");
                        CutCreRec.SetRange("Component Group", rec."Component Group");

                        if not CutCreRec.FindSet() then
                            Error('Cannot get no of plies')
                        else
                            Plies := CutCreRec."Ply Height";


                        if rec."Bundle Method" = rec."Bundle Method"::Normal then begin

                            for i := 1 To 64 do begin

                                Size := '';
                                Ratio := 0;

                                case i of
                                    1:
                                        if CutCreLineRec."1" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."1");
                                            Evaluate(Ratio, CutCreLine1Rec."1");
                                        end;

                                    2:
                                        if CutCreLineRec."2" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."2");
                                            Evaluate(Ratio, CutCreLine1Rec."2");
                                        end;
                                    3:
                                        if CutCreLineRec."3" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."3");
                                            Evaluate(Ratio, CutCreLine1Rec."3");
                                        end;

                                    4:
                                        if CutCreLineRec."4" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."4");
                                            Evaluate(Ratio, CutCreLine1Rec."4");
                                        end;
                                    5:
                                        if CutCreLineRec."5" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."5");
                                            Evaluate(Ratio, CutCreLine1Rec."5");
                                        end;

                                    6:
                                        if CutCreLineRec."6" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."6");
                                            Evaluate(Ratio, CutCreLine1Rec."6");
                                        end;
                                    7:
                                        if CutCreLineRec."7" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."7");
                                            Evaluate(Ratio, CutCreLine1Rec."7");
                                        end;

                                    8:
                                        if CutCreLineRec."8" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."8");
                                            Evaluate(Ratio, CutCreLine1Rec."8");
                                        end;
                                    9:
                                        if CutCreLineRec."9" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."9");
                                            Evaluate(Ratio, CutCreLine1Rec."9");
                                        end;

                                    10:
                                        if CutCreLineRec."10" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."10");
                                            Evaluate(Ratio, CutCreLine1Rec."10");
                                        end;

                                    11:
                                        if CutCreLineRec."11" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."11");
                                            Evaluate(Ratio, CutCreLine1Rec."11");
                                        end;

                                    12:
                                        if CutCreLineRec."12" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."12");
                                            Evaluate(Ratio, CutCreLine1Rec."12");
                                        end;
                                    13:
                                        if CutCreLineRec."13" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."13");
                                            Evaluate(Ratio, CutCreLine1Rec."13");
                                        end;

                                    14:
                                        if CutCreLineRec."14" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."14");
                                            Evaluate(Ratio, CutCreLine1Rec."14");
                                        end;
                                    15:
                                        if CutCreLineRec."15" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."15");
                                            Evaluate(Ratio, CutCreLine1Rec."15");
                                        end;

                                    16:
                                        if CutCreLineRec."16" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."16");
                                            Evaluate(Ratio, CutCreLine1Rec."16");
                                        end;
                                    17:
                                        if CutCreLineRec."17" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."17");
                                            Evaluate(Ratio, CutCreLine1Rec."17");
                                        end;

                                    18:
                                        if CutCreLineRec."18" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."18");
                                            Evaluate(Ratio, CutCreLine1Rec."18");
                                        end;
                                    19:
                                        if CutCreLineRec."19" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."19");
                                            Evaluate(Ratio, CutCreLine1Rec."19");
                                        end;

                                    20:
                                        if CutCreLineRec."20" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."20");
                                            Evaluate(Ratio, CutCreLine1Rec."20");
                                        end;
                                    21:
                                        if CutCreLineRec."21" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."21");
                                            Evaluate(Ratio, CutCreLine1Rec."21");
                                        end;

                                    22:
                                        if CutCreLineRec."22" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."22");
                                            Evaluate(Ratio, CutCreLine1Rec."22");
                                        end;
                                    23:
                                        if CutCreLineRec."23" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."23");
                                            Evaluate(Ratio, CutCreLine1Rec."23");
                                        end;

                                    24:
                                        if CutCreLineRec."24" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."24");
                                            Evaluate(Ratio, CutCreLine1Rec."24");
                                        end;
                                    25:
                                        if CutCreLineRec."25" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."25");
                                            Evaluate(Ratio, CutCreLine1Rec."25");
                                        end;

                                    26:
                                        if CutCreLineRec."26" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."26");
                                            Evaluate(Ratio, CutCreLine1Rec."26");
                                        end;
                                    27:
                                        if CutCreLineRec."27" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."27");
                                            Evaluate(Ratio, CutCreLine1Rec."27");
                                        end;

                                    28:
                                        if CutCreLineRec."28" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."28");
                                            Evaluate(Ratio, CutCreLine1Rec."28");
                                        end;
                                    29:
                                        if CutCreLineRec."29" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."29");
                                            Evaluate(Ratio, CutCreLine1Rec."29");
                                        end;

                                    30:
                                        if CutCreLineRec."30" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."30");
                                            Evaluate(Ratio, CutCreLine1Rec."30");
                                        end;
                                    31:
                                        if CutCreLineRec."31" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."31");
                                            Evaluate(Ratio, CutCreLine1Rec."31");
                                        end;

                                    32:
                                        if CutCreLineRec."32" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."32");
                                            Evaluate(Ratio, CutCreLine1Rec."32");
                                        end;
                                    33:
                                        if CutCreLineRec."33" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."33");
                                            Evaluate(Ratio, CutCreLine1Rec."33");
                                        end;

                                    34:
                                        if CutCreLineRec."34" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."34");
                                            Evaluate(Ratio, CutCreLine1Rec."34");
                                        end;
                                    35:
                                        if CutCreLineRec."35" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."35");
                                            Evaluate(Ratio, CutCreLine1Rec."35");
                                        end;

                                    36:
                                        if CutCreLineRec."36" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."36");
                                            Evaluate(Ratio, CutCreLine1Rec."36");
                                        end;
                                    37:
                                        if CutCreLineRec."37" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."37");
                                            Evaluate(Ratio, CutCreLine1Rec."37");
                                        end;

                                    38:
                                        if CutCreLineRec."38" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."38");
                                            Evaluate(Ratio, CutCreLine1Rec."38");
                                        end;
                                    39:
                                        if CutCreLineRec."39" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."39");
                                            Evaluate(Ratio, CutCreLine1Rec."39");
                                        end;

                                    40:
                                        if CutCreLineRec."40" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."40");
                                            Evaluate(Ratio, CutCreLine1Rec."40");
                                        end;
                                    41:
                                        if CutCreLineRec."41" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."41");
                                            Evaluate(Ratio, CutCreLine1Rec."41");
                                        end;

                                    42:
                                        if CutCreLineRec."42" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."42");
                                            Evaluate(Ratio, CutCreLine1Rec."42");
                                        end;
                                    43:
                                        if CutCreLineRec."43" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."43");
                                            Evaluate(Ratio, CutCreLine1Rec."43");
                                        end;

                                    44:
                                        if CutCreLineRec."44" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."44");
                                            Evaluate(Ratio, CutCreLine1Rec."44");
                                        end;
                                    45:
                                        if CutCreLineRec."45" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."45");
                                            Evaluate(Ratio, CutCreLine1Rec."45");
                                        end;

                                    46:
                                        if CutCreLineRec."46" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."46");
                                            Evaluate(Ratio, CutCreLine1Rec."46");
                                        end;
                                    47:
                                        if CutCreLineRec."47" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."47");
                                            Evaluate(Ratio, CutCreLine1Rec."47");
                                        end;

                                    48:
                                        if CutCreLineRec."48" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."48");
                                            Evaluate(Ratio, CutCreLine1Rec."48");
                                        end;
                                    49:
                                        if CutCreLineRec."49" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."49");
                                            Evaluate(Ratio, CutCreLine1Rec."49");
                                        end;

                                    50:
                                        if CutCreLineRec."50" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."50");
                                            Evaluate(Ratio, CutCreLine1Rec."50");
                                        end;
                                    51:
                                        if CutCreLineRec."51" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."51");
                                            Evaluate(Ratio, CutCreLine1Rec."51");
                                        end;

                                    52:
                                        if CutCreLineRec."52" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."52");
                                            Evaluate(Ratio, CutCreLine1Rec."52");
                                        end;
                                    53:
                                        if CutCreLineRec."53" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."53");
                                            Evaluate(Ratio, CutCreLine1Rec."53");
                                        end;

                                    54:
                                        if CutCreLineRec."54" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."54");
                                            Evaluate(Ratio, CutCreLine1Rec."54");
                                        end;
                                    55:
                                        if CutCreLineRec."55" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."55");
                                            Evaluate(Ratio, CutCreLine1Rec."55");
                                        end;

                                    56:
                                        if CutCreLineRec."56" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."56");
                                            Evaluate(Ratio, CutCreLine1Rec."56");
                                        end;
                                    57:
                                        if CutCreLineRec."57" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."57");
                                            Evaluate(Ratio, CutCreLine1Rec."57");
                                        end;

                                    58:
                                        if CutCreLineRec."58" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."58");
                                            Evaluate(Ratio, CutCreLine1Rec."58");
                                        end;
                                    59:
                                        if CutCreLineRec."59" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."59");
                                            Evaluate(Ratio, CutCreLine1Rec."59");
                                        end;

                                    60:
                                        if CutCreLineRec."60" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."60");
                                            Evaluate(Ratio, CutCreLine1Rec."60");
                                        end;
                                    61:
                                        if CutCreLineRec."61" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."61");
                                            Evaluate(Ratio, CutCreLine1Rec."61");
                                        end;

                                    62:
                                        if CutCreLineRec."62" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."62");
                                            Evaluate(Ratio, CutCreLine1Rec."62");
                                        end;
                                    63:
                                        if CutCreLineRec."63" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."63");
                                            Evaluate(Ratio, CutCreLine1Rec."63");
                                        end;

                                    64:
                                        if CutCreLineRec."64" <> '' then begin
                                            Evaluate(Size, CutCreLineRec."64");
                                            Evaluate(Ratio, CutCreLine1Rec."64");
                                        end;
                                end;

                                if Size <> '' then begin

                                    for j := 1 To Ratio do begin

                                        TempQty := 0;
                                        BundleQty := 0;

                                        Size1 := j + 64;

                                        repeat
                                            //insert
                                            LineNo += 1;
                                            BundleNo += 1;
                                            StickerSeq := Format(TempQty + 1) + '-' + Format(TempQty + rec."Bundle Rule");

                                            if TempQty + rec."Bundle Rule" < Plies then begin

                                                BundleQty := rec."Bundle Rule";
                                                BundleGuideLineRec.Init();
                                                BundleGuideLineRec."Bundle No" := BundleNo;
                                                BundleGuideLineRec."BundleGuideNo." := rec."BundleGuideNo.";
                                                BundleGuideLineRec."Color Name" := rec."Color Name";
                                                BundleGuideLineRec."Color No" := rec."Color No";
                                                BundleGuideLineRec."Created Date" := Today;
                                                BundleGuideLineRec."Created User" := UserId;
                                                BundleGuideLineRec."Cut No" := rec."Cut No";
                                                BundleGuideLineRec."Line No" := LineNo;
                                                BundleGuideLineRec.Qty := BundleQty;
                                                BundleGuideLineRec.Size := Size + '-' + Size1;
                                                BundleGuideLineRec.SJCNo := SewJobRec."Sewing Job No.";
                                                BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                BundleGuideLineRec."Bundle Method" := rec."Bundle Method"::Normal;
                                                BundleGuideLineRec."Role ID" := '';
                                                BundleGuideLineRec."Style No" := rec."Style No.";
                                                BundleGuideLineRec."Style Name" := rec."Style Name";

                                                TempLot := SewJobRec."Sewing Job No.";
                                                TempLot := TempLot.Substring(1, TempLot.IndexOfAny('-') - 1);
                                                BundleGuideLineRec.Lot := TempLot;

                                                StyleMasPoRec.Reset();
                                                StyleMasPoRec.SetRange("Style No.", rec."Style No.");
                                                StyleMasPoRec.SetRange("Lot No.", TempLot);
                                                if not StyleMasPoRec.FindSet() then
                                                    Error('Cannot find Sewing job no.');

                                                BundleGuideLineRec.PO := StyleMasPoRec."PO No.";
                                                BundleGuideLineRec.Insert();

                                            end
                                            else begin
                                                BundleQty := Plies - TempQty;

                                                if Plies - TempQty > rec."Bundle Rule" / 2 then begin

                                                    BundleQty := Plies - TempQty;
                                                    StickerSeq := Format(TempQty + 1) + '-' + Format(TempQty + BundleQty);

                                                    BundleGuideLineRec.Init();
                                                    BundleGuideLineRec."Bundle No" := BundleNo;
                                                    BundleGuideLineRec."BundleGuideNo." := rec."BundleGuideNo.";
                                                    BundleGuideLineRec."Color Name" := rec."Color Name";
                                                    BundleGuideLineRec."Color No" := rec."Color No";
                                                    BundleGuideLineRec."Created Date" := Today;
                                                    BundleGuideLineRec."Created User" := UserId;
                                                    BundleGuideLineRec."Cut No" := rec."Cut No";
                                                    BundleGuideLineRec."Line No" := LineNo;
                                                    BundleGuideLineRec.Qty := BundleQty;
                                                    BundleGuideLineRec.Size := Size + '-' + Size1;
                                                    BundleGuideLineRec.SJCNo := SewJobRec."Sewing Job No.";
                                                    BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                    BundleGuideLineRec."Bundle Method" := rec."Bundle Method"::Normal;
                                                    BundleGuideLineRec."Style No" := rec."Style No.";
                                                    BundleGuideLineRec."Style Name" := rec."Style Name";
                                                    BundleGuideLineRec."Role ID" := '';

                                                    TempLot := SewJobRec."Sewing Job No.";
                                                    TempLot := TempLot.Substring(1, TempLot.IndexOfAny('-') - 1);
                                                    BundleGuideLineRec.Lot := TempLot;

                                                    StyleMasPoRec.Reset();
                                                    StyleMasPoRec.SetRange("Style No.", rec."Style No.");
                                                    StyleMasPoRec.SetRange("Lot No.", TempLot);
                                                    if not StyleMasPoRec.FindSet() then
                                                        Error('Cannot find Sewing job no.');


                                                    BundleGuideLineRec.PO := StyleMasPoRec."PO No.";

                                                    BundleGuideLineRec.Insert()

                                                end
                                                else begin

                                                    BundleQty := Plies - TempQty;
                                                    StickerSeq := Format(TempQty - rec."Bundle Rule" + 1) + '-' + Format(TempQty + BundleQty);

                                                    //modify previous entry
                                                    BundleGuideLineRec.Reset();
                                                    BundleGuideLineRec.SetRange("BundleGuideNo.", rec."BundleGuideNo.");
                                                    BundleGuideLineRec.SetRange("Line No", LineNo - 1);
                                                    BundleGuideLineRec.FindSet();
                                                    BundleGuideLineRec.Qty := BundleGuideLineRec.Qty + BundleQty;
                                                    BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                    BundleGuideLineRec.Modify();

                                                end;
                                            end;

                                            TempQty := TempQty + BundleQty;
                                        until TempQty >= Plies;

                                    end;

                                end;

                            end;

                        end
                        else begin
                            if rec."Bundle Method" = rec."Bundle Method"::"Roll Wise" then begin

                                LaySheetRec.Reset();
                                LaySheetRec.SetRange("Style No.", rec."Style No.");
                                LaySheetRec.SetRange("Color No.", rec."Color No");
                                LaySheetRec.SetRange("Group ID", rec."Group ID");
                                LaySheetRec.SetRange("Component Group Code", rec."Component Group");
                                LaySheetRec.SetRange("Cut No.", rec."Cut No");

                                if not LaySheetRec.FindSet() then
                                    Error('Cannot find matching Laysheet');

                                CutProgHeadRec.Reset();
                                CutProgHeadRec.SetRange("LaySheetNo", LaySheetRec."LaySheetNo.");

                                if not CutProgHeadRec.FindSet() then
                                    Error('Cannot find matching Cutting Progress number');

                                CutProgLineRec.Reset();
                                CutProgLineRec.SetRange("CutProNo.", CutProgHeadRec."CutProNo.");

                                if not CutProgLineRec.FindSet() then
                                    Error('Cannot find matching Cutting Progress lines')
                                else begin

                                    repeat

                                        for i := 1 To 64 do begin

                                            Size := '';
                                            Ratio := 0;

                                            case i of
                                                1:
                                                    if CutCreLineRec."1" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."1");
                                                        Evaluate(Ratio, CutCreLine1Rec."1");
                                                    end;

                                                2:
                                                    if CutCreLineRec."2" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."2");
                                                        Evaluate(Ratio, CutCreLine1Rec."2");
                                                    end;
                                                3:
                                                    if CutCreLineRec."3" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."3");
                                                        Evaluate(Ratio, CutCreLine1Rec."3");
                                                    end;

                                                4:
                                                    if CutCreLineRec."4" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."4");
                                                        Evaluate(Ratio, CutCreLine1Rec."4");
                                                    end;
                                                5:
                                                    if CutCreLineRec."5" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."5");
                                                        Evaluate(Ratio, CutCreLine1Rec."5");
                                                    end;

                                                6:
                                                    if CutCreLineRec."6" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."6");
                                                        Evaluate(Ratio, CutCreLine1Rec."6");
                                                    end;
                                                7:
                                                    if CutCreLineRec."7" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."7");
                                                        Evaluate(Ratio, CutCreLine1Rec."7");
                                                    end;

                                                8:
                                                    if CutCreLineRec."8" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."8");
                                                        Evaluate(Ratio, CutCreLine1Rec."8");
                                                    end;
                                                9:
                                                    if CutCreLineRec."9" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."9");
                                                        Evaluate(Ratio, CutCreLine1Rec."9");
                                                    end;

                                                10:
                                                    if CutCreLineRec."10" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."10");
                                                        Evaluate(Ratio, CutCreLine1Rec."10");
                                                    end;

                                                11:
                                                    if CutCreLineRec."11" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."11");
                                                        Evaluate(Ratio, CutCreLine1Rec."11");
                                                    end;

                                                12:
                                                    if CutCreLineRec."12" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."12");
                                                        Evaluate(Ratio, CutCreLine1Rec."12");
                                                    end;
                                                13:
                                                    if CutCreLineRec."13" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."13");
                                                        Evaluate(Ratio, CutCreLine1Rec."13");
                                                    end;

                                                14:
                                                    if CutCreLineRec."14" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."14");
                                                        Evaluate(Ratio, CutCreLine1Rec."14");
                                                    end;
                                                15:
                                                    if CutCreLineRec."15" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."15");
                                                        Evaluate(Ratio, CutCreLine1Rec."15");
                                                    end;

                                                16:
                                                    if CutCreLineRec."16" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."16");
                                                        Evaluate(Ratio, CutCreLine1Rec."16");
                                                    end;
                                                17:
                                                    if CutCreLineRec."17" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."17");
                                                        Evaluate(Ratio, CutCreLine1Rec."17");
                                                    end;

                                                18:
                                                    if CutCreLineRec."18" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."18");
                                                        Evaluate(Ratio, CutCreLine1Rec."18");
                                                    end;
                                                19:
                                                    if CutCreLineRec."19" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."19");
                                                        Evaluate(Ratio, CutCreLine1Rec."19");
                                                    end;

                                                20:
                                                    if CutCreLineRec."20" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."20");
                                                        Evaluate(Ratio, CutCreLine1Rec."20");
                                                    end;
                                                21:
                                                    if CutCreLineRec."21" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."21");
                                                        Evaluate(Ratio, CutCreLine1Rec."21");
                                                    end;

                                                22:
                                                    if CutCreLineRec."22" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."22");
                                                        Evaluate(Ratio, CutCreLine1Rec."22");
                                                    end;
                                                23:
                                                    if CutCreLineRec."23" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."23");
                                                        Evaluate(Ratio, CutCreLine1Rec."23");
                                                    end;

                                                24:
                                                    if CutCreLineRec."24" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."24");
                                                        Evaluate(Ratio, CutCreLine1Rec."24");
                                                    end;
                                                25:
                                                    if CutCreLineRec."25" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."25");
                                                        Evaluate(Ratio, CutCreLine1Rec."25");
                                                    end;

                                                26:
                                                    if CutCreLineRec."26" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."26");
                                                        Evaluate(Ratio, CutCreLine1Rec."26");
                                                    end;
                                                27:
                                                    if CutCreLineRec."27" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."27");
                                                        Evaluate(Ratio, CutCreLine1Rec."27");
                                                    end;

                                                28:
                                                    if CutCreLineRec."28" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."28");
                                                        Evaluate(Ratio, CutCreLine1Rec."28");
                                                    end;
                                                29:
                                                    if CutCreLineRec."29" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."29");
                                                        Evaluate(Ratio, CutCreLine1Rec."29");
                                                    end;

                                                30:
                                                    if CutCreLineRec."30" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."30");
                                                        Evaluate(Ratio, CutCreLine1Rec."30");
                                                    end;
                                                31:
                                                    if CutCreLineRec."31" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."31");
                                                        Evaluate(Ratio, CutCreLine1Rec."31");
                                                    end;

                                                32:
                                                    if CutCreLineRec."32" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."32");
                                                        Evaluate(Ratio, CutCreLine1Rec."32");
                                                    end;
                                                33:
                                                    if CutCreLineRec."33" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."33");
                                                        Evaluate(Ratio, CutCreLine1Rec."33");
                                                    end;

                                                34:
                                                    if CutCreLineRec."34" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."34");
                                                        Evaluate(Ratio, CutCreLine1Rec."34");
                                                    end;
                                                35:
                                                    if CutCreLineRec."35" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."35");
                                                        Evaluate(Ratio, CutCreLine1Rec."35");
                                                    end;

                                                36:
                                                    if CutCreLineRec."36" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."36");
                                                        Evaluate(Ratio, CutCreLine1Rec."36");
                                                    end;
                                                37:
                                                    if CutCreLineRec."37" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."37");
                                                        Evaluate(Ratio, CutCreLine1Rec."37");
                                                    end;

                                                38:
                                                    if CutCreLineRec."38" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."38");
                                                        Evaluate(Ratio, CutCreLine1Rec."38");
                                                    end;
                                                39:
                                                    if CutCreLineRec."39" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."39");
                                                        Evaluate(Ratio, CutCreLine1Rec."39");
                                                    end;

                                                40:
                                                    if CutCreLineRec."40" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."40");
                                                        Evaluate(Ratio, CutCreLine1Rec."40");
                                                    end;
                                                41:
                                                    if CutCreLineRec."41" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."41");
                                                        Evaluate(Ratio, CutCreLine1Rec."41");
                                                    end;

                                                42:
                                                    if CutCreLineRec."42" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."42");
                                                        Evaluate(Ratio, CutCreLine1Rec."42");
                                                    end;
                                                43:
                                                    if CutCreLineRec."43" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."43");
                                                        Evaluate(Ratio, CutCreLine1Rec."43");
                                                    end;

                                                44:
                                                    if CutCreLineRec."44" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."44");
                                                        Evaluate(Ratio, CutCreLine1Rec."44");
                                                    end;
                                                45:
                                                    if CutCreLineRec."45" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."45");
                                                        Evaluate(Ratio, CutCreLine1Rec."45");
                                                    end;

                                                46:
                                                    if CutCreLineRec."46" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."46");
                                                        Evaluate(Ratio, CutCreLine1Rec."46");
                                                    end;
                                                47:
                                                    if CutCreLineRec."47" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."47");
                                                        Evaluate(Ratio, CutCreLine1Rec."47");
                                                    end;

                                                48:
                                                    if CutCreLineRec."48" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."48");
                                                        Evaluate(Ratio, CutCreLine1Rec."48");
                                                    end;
                                                49:
                                                    if CutCreLineRec."49" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."49");
                                                        Evaluate(Ratio, CutCreLine1Rec."49");
                                                    end;

                                                50:
                                                    if CutCreLineRec."50" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."50");
                                                        Evaluate(Ratio, CutCreLine1Rec."50");
                                                    end;
                                                51:
                                                    if CutCreLineRec."51" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."51");
                                                        Evaluate(Ratio, CutCreLine1Rec."51");
                                                    end;

                                                52:
                                                    if CutCreLineRec."52" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."52");
                                                        Evaluate(Ratio, CutCreLine1Rec."52");
                                                    end;
                                                53:
                                                    if CutCreLineRec."53" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."53");
                                                        Evaluate(Ratio, CutCreLine1Rec."53");
                                                    end;

                                                54:
                                                    if CutCreLineRec."54" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."54");
                                                        Evaluate(Ratio, CutCreLine1Rec."54");
                                                    end;
                                                55:
                                                    if CutCreLineRec."55" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."55");
                                                        Evaluate(Ratio, CutCreLine1Rec."55");
                                                    end;

                                                56:
                                                    if CutCreLineRec."56" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."56");
                                                        Evaluate(Ratio, CutCreLine1Rec."56");
                                                    end;
                                                57:
                                                    if CutCreLineRec."57" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."57");
                                                        Evaluate(Ratio, CutCreLine1Rec."57");
                                                    end;

                                                58:
                                                    if CutCreLineRec."58" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."58");
                                                        Evaluate(Ratio, CutCreLine1Rec."58");
                                                    end;
                                                59:
                                                    if CutCreLineRec."59" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."59");
                                                        Evaluate(Ratio, CutCreLine1Rec."59");
                                                    end;

                                                60:
                                                    if CutCreLineRec."60" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."60");
                                                        Evaluate(Ratio, CutCreLine1Rec."60");
                                                    end;
                                                61:
                                                    if CutCreLineRec."61" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."61");
                                                        Evaluate(Ratio, CutCreLine1Rec."61");
                                                    end;

                                                62:
                                                    if CutCreLineRec."62" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."62");
                                                        Evaluate(Ratio, CutCreLine1Rec."62");
                                                    end;
                                                63:
                                                    if CutCreLineRec."63" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."63");
                                                        Evaluate(Ratio, CutCreLine1Rec."63");
                                                    end;

                                                64:
                                                    if CutCreLineRec."64" <> '' then begin
                                                        Evaluate(Size, CutCreLineRec."64");
                                                        Evaluate(Ratio, CutCreLine1Rec."64");
                                                    end;
                                            end;

                                            if Size <> '' then begin

                                                for j := 1 To Ratio do begin

                                                    TempQty := 0;
                                                    BundleQty := 0;

                                                    Size1 := j + 64;

                                                    repeat
                                                        //insert
                                                        LineNo += 1;
                                                        BundleNo += 1;

                                                        if CutProgLineRec."Actual Plies" <= rec."Bundle Rule" then
                                                            BundleQty := CutProgLineRec."Actual Plies"
                                                        else
                                                            BundleQty := rec."Bundle Rule";

                                                        StickerSeq := Format(TempQty + 1) + '-' + Format(TempQty + BundleQty);

                                                        if TempQty + BundleQty <= CutProgLineRec."Actual Plies" then begin

                                                            //BundleQty := "Bundle Rule";
                                                            BundleGuideLineRec.Init();
                                                            BundleGuideLineRec."Bundle No" := BundleNo;
                                                            BundleGuideLineRec."BundleGuideNo." := rec."BundleGuideNo.";
                                                            BundleGuideLineRec."Color Name" := rec."Color Name";
                                                            BundleGuideLineRec."Color No" := rec."Color No";
                                                            BundleGuideLineRec."Created Date" := Today;
                                                            BundleGuideLineRec."Created User" := UserId;
                                                            BundleGuideLineRec."Cut No" := rec."Cut No";
                                                            BundleGuideLineRec."Line No" := LineNo;
                                                            BundleGuideLineRec.Qty := BundleQty;
                                                            BundleGuideLineRec.Size := Size + '-' + Size1;
                                                            BundleGuideLineRec.SJCNo := SewJobRec."Sewing Job No.";
                                                            BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                            BundleGuideLineRec."Bundle Method" := rec."Bundle Method"::Normal;
                                                            BundleGuideLineRec."Role ID" := CutProgLineRec."Role ID";
                                                            BundleGuideLineRec."Shade Name" := CutProgLineRec.Shade;
                                                            BundleGuideLineRec."Shade No" := CutProgLineRec."Shade No";
                                                            BundleGuideLineRec."Style No" := rec."Style No.";
                                                            BundleGuideLineRec."Style Name" := rec."Style Name";

                                                            TempLot := SewJobRec."Sewing Job No.";
                                                            TempLot := TempLot.Substring(1, TempLot.IndexOfAny('-') - 1);
                                                            BundleGuideLineRec.Lot := TempLot;

                                                            StyleMasPoRec.Reset();
                                                            StyleMasPoRec.SetRange("Style No.", rec."Style No.");
                                                            StyleMasPoRec.SetRange("Lot No.", TempLot);
                                                            if not StyleMasPoRec.FindSet() then
                                                                Error('Cannot find Sewing job no.');


                                                            BundleGuideLineRec.PO := StyleMasPoRec."PO No.";
                                                            BundleGuideLineRec.Insert();

                                                            PreviuosBundleQty := BundleQty;

                                                        end
                                                        else begin
                                                            BundleQty := CutProgLineRec."Actual Plies" - TempQty;

                                                            if CutProgLineRec."Actual Plies" - TempQty > rec."Bundle Rule" / 2 then begin

                                                                BundleQty := CutProgLineRec."Actual Plies" - TempQty;
                                                                StickerSeq := Format(TempQty + 1) + '-' + Format(TempQty + BundleQty);

                                                                BundleGuideLineRec.Init();
                                                                BundleGuideLineRec."Bundle No" := BundleNo;
                                                                BundleGuideLineRec."BundleGuideNo." := rec."BundleGuideNo.";
                                                                BundleGuideLineRec."Color Name" := rec."Color Name";
                                                                BundleGuideLineRec."Color No" := rec."Color No";
                                                                BundleGuideLineRec."Created Date" := Today;
                                                                BundleGuideLineRec."Created User" := UserId;
                                                                BundleGuideLineRec."Cut No" := rec."Cut No";
                                                                BundleGuideLineRec."Line No" := LineNo;
                                                                BundleGuideLineRec.Qty := BundleQty;
                                                                BundleGuideLineRec.Size := Size + '-' + Size1;
                                                                BundleGuideLineRec.SJCNo := SewJobRec."Sewing Job No.";
                                                                BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                                BundleGuideLineRec."Bundle Method" := rec."Bundle Method"::Normal;
                                                                BundleGuideLineRec."Role ID" := CutProgLineRec."Role ID";
                                                                BundleGuideLineRec."Shade Name" := CutProgLineRec.Shade;
                                                                BundleGuideLineRec."Shade No" := CutProgLineRec."Shade No";
                                                                BundleGuideLineRec."Style No" := rec."Style No.";
                                                                BundleGuideLineRec."Style Name" := rec."Style Name";

                                                                TempLot := SewJobRec."Sewing Job No.";
                                                                TempLot := TempLot.Substring(1, TempLot.IndexOfAny('-') - 1);
                                                                BundleGuideLineRec.Lot := TempLot;

                                                                StyleMasPoRec.Reset();
                                                                StyleMasPoRec.SetRange("Style No.", rec."Style No.");
                                                                StyleMasPoRec.SetRange("Lot No.", TempLot);
                                                                if not StyleMasPoRec.FindSet() then
                                                                    Error('Cannot find Sewing job no.');


                                                                BundleGuideLineRec.PO := StyleMasPoRec."PO No.";
                                                                BundleGuideLineRec.Insert();

                                                                PreviuosBundleQty := BundleQty;

                                                            end
                                                            else begin

                                                                BundleQty := CutProgLineRec."Actual Plies" - TempQty;
                                                                StickerSeq := Format(TempQty - PreviuosBundleQty + 1) + '-' + Format(TempQty + BundleQty);

                                                                //modify previous entry
                                                                BundleGuideLineRec.Reset();
                                                                BundleGuideLineRec.SetRange("BundleGuideNo.", rec."BundleGuideNo.");
                                                                BundleGuideLineRec.SetRange("Line No", LineNo - 1);
                                                                BundleGuideLineRec.FindSet();
                                                                BundleGuideLineRec.Qty := BundleGuideLineRec.Qty + BundleQty;
                                                                BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                                BundleGuideLineRec.Modify();

                                                                PreviuosBundleQty := BundleQty;

                                                            end;
                                                        end;

                                                        TempQty := TempQty + BundleQty;
                                                    until TempQty >= CutProgLineRec."Actual Plies";

                                                end;

                                            end;

                                        end;

                                    until CutProgLineRec.Next() = 0;

                                end;

                            end;
                        end;



                        //get Total bundle qty for the 
                        BundleQty := 0;
                        BundleGuideLineRec.Reset();
                        BundleGuideLineRec.SetRange("Style No", rec."Style No.");
                        BundleGuideLineRec.SetRange(PO, rec."PO No.");

                        if BundleGuideLineRec.FindSet() then begin
                            repeat
                                BundleQty += BundleGuideLineRec.Qty;
                            until BundleGuideLineRec.Next() = 0;
                        end;

                        //Update Style/PO Cut in qty
                        StyleMasPoRec.Reset();
                        StyleMasPoRec.SetRange("Style No.", rec."Style No.");
                        StyleMasPoRec.SetRange("PO No.", rec."PO No.");

                        if StyleMasPoRec.FindSet() then begin
                            StyleMasPoRec."Cut In Qty" := BundleQty;
                            StyleMasPoRec.Modify();
                        end;

                        // BundleQty := 0;
                        // //Calculate total for a style/po and update style master cut in qty
                        // BundleGuideLineRec.Reset();
                        // BundleGuideLineRec.SetCurrentKey("Style No", Lot);
                        // BundleGuideLineRec.SetRange("BundleGuideNo.", rec."BundleGuideNo.");

                        // if BundleGuideLineRec.FindSet() then begin
                        //     repeat

                        //         if (StyleVar = BundleGuideLineRec."Style No") and (LotVar = BundleGuideLineRec.Lot) then begin
                        //             BundleQty += BundleGuideLineRec.Qty;
                        //             StyleVar := BundleGuideLineRec."Style No";
                        //             LotVar := BundleGuideLineRec."Lot";
                        //         end
                        //         else begin
                        //             StyleMasPoRec.Reset();
                        //             StyleMasPoRec.SetRange("Style No.", StyleVar);
                        //             StyleMasPoRec.SetRange("Lot No.", LotVar);

                        //             if StyleMasPoRec.FindSet() then begin
                        //                 StyleMasPoRec."Cut In Qty" += BundleQty;
                        //                 StyleMasPoRec.Modify();
                        //             end;

                        //             StyleVar := BundleGuideLineRec."Style No";
                        //             LotVar := BundleGuideLineRec.Lot;
                        //             BundleQty := 0;
                        //             BundleQty += BundleGuideLineRec.Qty;
                        //         end;

                        //     until BundleGuideLineRec.Next() = 0;

                        //     StyleMasPoRec.Reset();
                        //     StyleMasPoRec.SetRange("Style No.", StyleVar);
                        //     StyleMasPoRec.SetRange("Lot No.", LotVar);

                        //     if StyleMasPoRec.FindSet() then begin
                        //         StyleMasPoRec."Cut In Qty" += BundleQty;
                        //         StyleMasPoRec.Modify();
                        //     end;

                        // end;


                        //Coor wise total
                        // BundleQty := 0;
                        // //Calculate total for a style/po and update style master cut in qty
                        // BundleGuideLineRec.Reset();
                        // BundleGuideLineRec.SetCurrentKey("Style No", Lot, "Color No");
                        // BundleGuideLineRec.SetRange("BundleGuideNo.", "BundleGuideNo.");

                        // if BundleGuideLineRec.FindSet() then begin
                        //     repeat

                        //         if (StyleVar = BundleGuideLineRec."Style No") and (LotVar = BundleGuideLineRec.Lot) then begin
                        //             BundleQty += BundleGuideLineRec.Qty;
                        //             StyleVar := BundleGuideLineRec."Style No";
                        //             LotVar := BundleGuideLineRec."Lot";
                        //         end
                        //         else begin
                        //             StyleMasPoRec.Reset();
                        //             StyleMasPoRec.SetRange("Style No.", StyleVar);
                        //             StyleMasPoRec.SetRange("Lot No.", LotVar);

                        //             if StyleMasPoRec.FindSet() then begin
                        //                 StyleMasPoRec."Cut In Qty" := BundleQty;
                        //                 StyleMasPoRec.Modify();
                        //             end;

                        //             StyleVar := BundleGuideLineRec."Style No";
                        //             LotVar := BundleGuideLineRec.Lot;
                        //             BundleQty := 0;
                        //             BundleQty += BundleGuideLineRec.Qty;
                        //         end;

                        //     until BundleGuideLineRec.Next() = 0;

                        //     StyleMasPoRec.Reset();
                        //     StyleMasPoRec.SetRange("Style No.", StyleVar);
                        //     StyleMasPoRec.SetRange("Lot No.", LotVar);

                        //     if StyleMasPoRec.FindSet() then begin
                        //         StyleMasPoRec."Cut In Qty" := BundleQty;
                        //         StyleMasPoRec.Modify();
                        //     end;

                        // end;

                    end
                    else
                        Error('Cannot find Sewing Job Details for the Style : %1', rec."Style Name");

                    Message('Completed.');

                end;
            }
        }
    }



    trigger OnDeleteRecord(): Boolean
    var
        BundleGuideLineRec: Record BundleGuideLine;
    begin
        BundleGuideLineRec.reset();
        BundleGuideLineRec.SetRange("BundleGuideNo.", rec."BundleGuideNo.");
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
}