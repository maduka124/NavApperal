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
                                LaySheetHeaderRec.MARK(TRUE);
                            UNTIL LaySheetHeaderRec.NEXT = 0;
                            LaySheetHeaderRec.MARKEDONLY(TRUE);

                            if Page.RunModal(51320, LaySheetHeaderRec) = Action::LookupOK then begin
                                rec."LaySheetNo." := LaySheetHeaderRec."LaySheetNo.";

                                LaySheetHeaderRec.Reset();
                                LaySheetHeaderRec.SetRange("LaySheetNo.", rec."LaySheetNo.");
                                if LaySheetHeaderRec.FindSet() then begin
                                    // rec."Color Name" := LaySheetHeaderRec.Color;
                                    // rec."Color No" := LaySheetHeaderRec."Color No.";
                                    rec."Style Name" := LaySheetHeaderRec."Style Name";
                                    rec."Style No." := LaySheetHeaderRec."Style No.";
                                    // rec."Group ID" := LaySheetHeaderRec."Group ID";
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

                    // trigger OnValidate()
                    // var
                    //     StyleMasterRec: Record "Style Master";
                    //     LoginSessionsRec: Record LoginSessions;
                    //     LoginRec: Page "Login Card";
                    //     UserRec: Record "User Setup";
                    // begin
                    //     StyleMasterRec.Reset();
                    //     StyleMasterRec.SetRange("Style No.", rec."Style Name");
                    //     if StyleMasterRec.FindSet() then
                    //         rec."Style No." := StyleMasterRec."No.";

                    //     //Check whether user logged in or not
                    //     LoginSessionsRec.Reset();
                    //     LoginSessionsRec.SetRange(SessionID, SessionId());

                    //     if not LoginSessionsRec.FindSet() then begin  //not logged in
                    //         Clear(LoginRec);
                    //         LoginRec.LookupMode(true);
                    //         LoginRec.RunModal();

                    //         LoginSessionsRec.Reset();
                    //         LoginSessionsRec.SetRange(SessionID, SessionId());
                    //         if LoginSessionsRec.FindSet() then
                    //             rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                    //     end
                    //     else begin   //logged in
                    //         rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                    //     end;
                    //     CurrPage.Update();

                    //     //Done By Sachith on 03/04/23 
                    //     UserRec.Reset();
                    //     UserRec.Get(UserId);

                    //     if UserRec."Factory Code" <> '' then begin
                    //         Rec."Factory Code" := UserRec."Factory Code";
                    //         CurrPage.Update();
                    //     end
                    //     else
                    //         Error('Factory not assigned for the user.');

                    // end;
                }



                // field("Color Name"; rec."Color Name")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Color';
                //     Editable = false;

                //     trigger OnLookup(var texts: text): Boolean
                //     var
                //         AssoDetailsRec: Record AssortmentDetails;
                //         Colour: Code[20];
                //         colorRec: Record Colour;
                //     begin
                //         AssoDetailsRec.RESET;
                //         AssoDetailsRec.SetCurrentKey("Colour No");
                //         AssoDetailsRec.SetRange("Style No.", rec."Style No.");

                //         IF AssoDetailsRec.FINDFIRST THEN BEGIN
                //             REPEAT
                //                 IF Colour <> AssoDetailsRec."Colour No" THEN BEGIN
                //                     Colour := AssoDetailsRec."Colour No";

                //                     AssoDetailsRec.MARK(TRUE);
                //                 END;
                //             UNTIL AssoDetailsRec.NEXT = 0;
                //             AssoDetailsRec.MARKEDONLY(TRUE);

                //             if Page.RunModal(51014, AssoDetailsRec) = Action::LookupOK then begin
                //                 rec."Color No" := AssoDetailsRec."Colour No";
                //                 rec."Color Name" := AssoDetailsRec."Colour Name";
                //             end;

                //         END;
                //     END;
                // }

                // field("Group ID"; rec."Group ID")
                // {
                //     ApplicationArea = All;
                //     Editable = false;

                //     // trigger OnValidate()
                //     // var
                //     //     SewJobLine4Rec: Record SewingJobCreationLine4;
                //     // begin
                //     //     SewJobLine4Rec.Reset();
                //     //     SewJobLine4Rec.SetRange("Style No.", rec."Style No.");
                //     //     SewJobLine4Rec.SetRange("Colour No", rec."Color No");
                //     //     SewJobLine4Rec.SetRange("Group ID", rec."Group ID");
                //     //     if SewJobLine4Rec.FindSet() then
                //     //         rec."Po No." := SewJobLine4Rec."PO No."
                //     //     else
                //     //         Error('Cannot find sewing job details for Style/Color/Group');

                //     //     CurrPage.Update();
                //     // end;
                // }

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
                    // CutProgLineRec: Record CuttingProgressLine;
                    // CutProgHeadRec: Record CuttingProgressHeader;
                    BundleGuideLineRec: Record BundleGuideLine;
                    //SewJobRec: Record SewingJobCreationLine4;
                    //CutCreLine1Rec: Record CutCreationLine;
                    //CutCreRec: Record CutCreation;
                    // CutCreLineRec: Record CutCreationLine;
                    LaySheetLine1Rec: Record LaySheetLine1;
                    LaySheetLine2Rec: Record LaySheetLine1;
                    LaySheetRec: Record LaySheetHeader;
                    LaySheetLine4Rec: Record LaySheetLine4;
                    StyleMasPoRec: Record "Style Master PO";
                    //Plies: Integer;
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

                    i := 1;
                    TempQty := 0;

                    if rec."Style Name" = '' then
                        Error('Invalid Style');

                    // if rec."Color Name" = '' then
                    //     Error('Invalid Color');

                    // if rec."Group ID" = 0 then
                    //     Error('Invalid Group ID');

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

                    // //Get Sewing jOb no
                    // SewJobRec.Reset();
                    // SewJobRec.SetRange("Style No.", rec."Style No.");
                    // SewJobRec.SetRange("Colour No", rec."Color No");
                    // SewJobRec.SetRange("Group ID", rec."Group ID");
                    // SewJobRec.SetFilter("Record Type", '=%1', 'L');
                    // if SewJobRec.FindSet() then begin

                    //Get Max bundle no
                    BundleGuideLineRec.Reset();
                    if BundleGuideLineRec.FindLast() then
                        BundleNo := BundleGuideLineRec."Bundle No";

                    // if BundleNo = 9999 then
                    //     BundleNo := 0;

                    // CutCreLineRec.Reset();
                    // CutCreLineRec.SetRange("Style No.", rec."Style No.");
                    // CutCreLineRec.SetRange("Colour No", rec."Color No");
                    // CutCreLineRec.SetRange("Group ID", rec."Group ID");
                    // CutCreLineRec.SetRange("Component Group Code", rec."Component Group");
                    // //CutCreLineRec.SetFilter("Cut No", '=%1', 0);
                    // CutCreLineRec.SetFilter("Record Type", '=%1', 'H');

                    // if not CutCreLineRec.FindSet() then
                    //     Error('Cannot find sizes');


                    // //Get Sizes
                    // CutCreLineRec.Reset();
                    // CutCreLineRec.SetRange("Style No.", rec."Style No.");
                    // CutCreLineRec.SetRange("Colour No", rec."Color No");
                    // CutCreLineRec.SetRange("Group ID", rec."Group ID");
                    // CutCreLineRec.SetRange("Component Group Code", rec."Component Group");
                    // //CutCreLineRec.SetFilter("Cut No", '=%1', 0);
                    // CutCreLineRec.SetFilter("Record Type", '=%1', 'H');

                    // if not CutCreLineRec.FindSet() then
                    //     Error('Cannot find sizes');

                    //Get Sizes
                    LaySheetLine1Rec.Reset();
                    LaySheetLine1Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
                    LaySheetLine1Rec.SetFilter("Record Type", '=%1', 'SIZE');
                    if not LaySheetLine1Rec.FindSet() then
                        Error('Cannot find Sizes in Laysheet');


                    // //Get ratio
                    // CutCreLine1Rec.Reset();
                    // CutCreLine1Rec.SetRange("Style No.", rec."Style No.");
                    // CutCreLine1Rec.SetRange("Colour No", rec."Color No");
                    // CutCreLine1Rec.SetRange("Group ID", rec."Group ID");
                    // CutCreLine1Rec.SetRange("Component Group Code", rec."Component Group");
                    // CutCreLine1Rec.SetFilter("Cut No", '=%1', 0);
                    // CutCreLine1Rec.SetFilter("Record Type", '=%1', 'R');

                    // if not CutCreLine1Rec.FindSet() then
                    //     Error('Cannot find Ratio for the sizes');


                    //Get ratio
                    LaySheetLine2Rec.Reset();
                    LaySheetLine2Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
                    LaySheetLine2Rec.SetFilter("Record Type", '=%1', 'RATIO');
                    if not LaySheetLine2Rec.FindSet() then
                        Error('Cannot find Ratio in Laysheet');


                    // CutCreRec.Reset();
                    // CutCreRec.SetRange("Style No.", rec."Style No.");
                    // CutCreRec.SetRange("Colour No", rec."Color No");
                    // CutCreRec.SetRange("Group ID", rec."Group ID");
                    // CutCreRec.SetRange("Component Group", rec."Component Group");

                    // if not CutCreRec.FindSet() then
                    //     Error('Cannot get no of plies')
                    // else
                    //     Plies := CutCreRec."Ply Height";

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

                                        TempQty := 0;
                                        BundleQty := 0;
                                        Size1 := j + 64;

                                        repeat
                                            if LaySheetLine4Rec."Actual Plies" = 0 then
                                                Error('Actual Plies is zero in Laysheet.');

                                            if LaySheetLine4Rec."Actual Plies" <= rec."Bundle Rule" then
                                                BundleQty := LaySheetLine4Rec."Actual Plies"
                                            else
                                                BundleQty := rec."Bundle Rule";

                                            //insert
                                            LineNo += 1;
                                            BundleNo += 1;
                                            StickerSeq := Format(TempQty + 1) + '-' + Format(TempQty + BundleQty);
                                            //StickerSeq := Format(TempQty + 1) + '-' + Format(TempQty + rec."Bundle Rule");
                                            // if TempQty + rec."Bundle Rule" < Plies then begin

                                            if (TempQty + BundleQty) < 10000 then begin
                                                //BundleQty := rec."Bundle Rule";
                                                BundleGuideLineRec.Init();
                                                BundleGuideLineRec."Bundle No" := BundleNo;
                                                BundleGuideLineRec."BundleGuideNo." := rec."BundleGuideNo.";
                                                BundleGuideLineRec."Color Name" := LaySheetLine4Rec.Color;
                                                BundleGuideLineRec."Color No" := LaySheetLine4Rec."Color No.";
                                                BundleGuideLineRec."Created Date" := Today;
                                                BundleGuideLineRec."Created User" := UserId;
                                                BundleGuideLineRec."Cut No New" := rec."Cut No New";
                                                BundleGuideLineRec."Line No" := LineNo;
                                                BundleGuideLineRec.Qty := BundleQty;
                                                BundleGuideLineRec.Size := Size + '-' + Size1;
                                                //BundleGuideLineRec.SJCNo := SewJobRec."Sewing Job No.";
                                                BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                BundleGuideLineRec."Bundle Method" := rec."Bundle Method"::Normal;
                                                BundleGuideLineRec."Role ID" := '';
                                                BundleGuideLineRec."Style No" := rec."Style No.";
                                                BundleGuideLineRec."Style Name" := rec."Style Name";

                                                //TempLot := SewJobRec."Sewing Job No.";
                                                //TempLot := TempLot.Substring(1, TempLot.IndexOfAny('-') - 1);
                                                BundleGuideLineRec.Lot := '';

                                                // StyleMasPoRec.Reset();
                                                // StyleMasPoRec.SetRange("Style No.", rec."Style No.");
                                                // StyleMasPoRec.SetRange("Lot No.", TempLot);
                                                // if not StyleMasPoRec.FindSet() then
                                                //     Error('Cannot find Sewing job no.');

                                                BundleGuideLineRec.PO := LaySheetRec."PO No.";
                                                BundleGuideLineRec.Insert();

                                                TempQty := TempQty + BundleQty;
                                                PreviuosBundleQty := BundleQty;
                                            end
                                            else begin
                                                //BundleQty := Plies - TempQty;
                                                //if Plies - TempQty > rec."Bundle Rule" / 2 then begin
                                                // BundleQty := Plies - TempQty;
                                                // StickerSeq := Format(TempQty + 1) + '-' + Format(TempQty + BundleQty);

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
                                                //BundleGuideLineRec.Qty := BundleQty;
                                                //BundleGuideLineRec.Size := Size + '-' + Size1;
                                                //BundleGuideLineRec.SJCNo := SewJobRec."Sewing Job No.";

                                                BundleGuideLineRec.Qty := 9999 - TempQty;

                                                if Ratio = 1 then
                                                    BundleGuideLineRec.Size := Size
                                                else
                                                    BundleGuideLineRec.Size := Size + '-' + Size1;

                                                BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                BundleGuideLineRec."Bundle Method" := rec."Bundle Method"::Normal;
                                                BundleGuideLineRec."Style No" := rec."Style No.";
                                                BundleGuideLineRec."Style Name" := rec."Style Name";
                                                BundleGuideLineRec."Role ID" := '';

                                                //TempLot := SewJobRec."Sewing Job No.";
                                                //TempLot := TempLot.Substring(1, TempLot.IndexOfAny('-') - 1);
                                                BundleGuideLineRec.Lot := '';

                                                // StyleMasPoRec.Reset();
                                                // StyleMasPoRec.SetRange("Style No.", rec."Style No.");
                                                // StyleMasPoRec.SetRange("Lot No.", TempLot);
                                                // if not StyleMasPoRec.FindSet() then
                                                //     Error('Cannot find Sewing job no.');

                                                BundleGuideLineRec.PO := LaySheetRec."PO No.";
                                                BundleGuideLineRec.Insert();
                                                // end
                                                // else begin
                                                //     BundleQty := Plies - TempQty;
                                                StickerSeq := Format(TempQty - rec."Bundle Rule" + 1) + '-' + Format(TempQty + BundleQty);

                                                ////modify previous entry
                                                // BundleGuideLineRec.Reset();
                                                // BundleGuideLineRec.SetRange("BundleGuideNo.", rec."BundleGuideNo.");
                                                // BundleGuideLineRec.SetRange("Line No", LineNo - 1);
                                                // BundleGuideLineRec.FindSet();
                                                // BundleGuideLineRec.Qty := BundleGuideLineRec.Qty + BundleQty;
                                                // BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                // BundleGuideLineRec.Modify();

                                                //end;
                                                //end;
                                                //TempQty := TempQty + BundleQty;
                                                TempQty := 0;
                                                PreviuosBundleQty := 9999 - TempQty;
                                            end;
                                        //until TempQty >= Plies;
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
                                            LaySheetLine4Rec.FindSet();

                                            repeat

                                                if LaySheetLine4Rec."Actual Plies" = 0 then
                                                    Error('Actual Plies is zero in Laysheet.');

                                                if LaySheetLine4Rec."Actual Plies" <= rec."Bundle Rule" then
                                                    BundleQty := LaySheetLine4Rec."Actual Plies"
                                                else
                                                    BundleQty := rec."Bundle Rule";

                                                if (TempQty + BundleQty) < 10000 then begin

                                                    StickerSeq := Format(TempQty + 1) + '-' + Format(TempQty + BundleQty);
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
                                                    BundleGuideLineRec.Qty := BundleQty;

                                                    if Ratio = 1 then
                                                        BundleGuideLineRec.Size := Size
                                                    else
                                                        BundleGuideLineRec.Size := Size + '-' + Size1;

                                                    //BundleGuideLineRec.SJCNo := SewJobRec."Sewing Job No.";
                                                    BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                    BundleGuideLineRec."Bundle Method" := rec."Bundle Method"::Normal;
                                                    BundleGuideLineRec."Role ID" := LaySheetLine4Rec."Role ID";
                                                    BundleGuideLineRec."Shade Name" := LaySheetLine4Rec.Shade;
                                                    BundleGuideLineRec."Shade No" := LaySheetLine4Rec."Shade No";
                                                    BundleGuideLineRec."Style No" := rec."Style No.";
                                                    BundleGuideLineRec."Style Name" := rec."Style Name";

                                                    //TempLot := SewJobRec."Sewing Job No.";
                                                    //TempLot := TempLot.Substring(1, TempLot.IndexOfAny('-') - 1);
                                                    BundleGuideLineRec.Lot := '';

                                                    // StyleMasPoRec.Reset();
                                                    // StyleMasPoRec.SetRange("Style No.", rec."Style No.");
                                                    // StyleMasPoRec.SetRange("Lot No.", TempLot);
                                                    // if not StyleMasPoRec.FindSet() then
                                                    //     Error('Cannot find Sewing job no.');

                                                    BundleGuideLineRec.PO := LaySheetRec."PO No.";
                                                    BundleGuideLineRec.Insert();

                                                    TempQty := TempQty + BundleQty;
                                                    PreviuosBundleQty := BundleQty;

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
                                                    BundleGuideLineRec.Qty := 9999 - TempQty;

                                                    if Ratio = 1 then
                                                        BundleGuideLineRec.Size := Size
                                                    else
                                                        BundleGuideLineRec.Size := Size + '-' + Size1;

                                                    //BundleGuideLineRec.SJCNo := SewJobRec."Sewing Job No.";
                                                    BundleGuideLineRec."Sticker Sequence" := StickerSeq;
                                                    BundleGuideLineRec."Bundle Method" := rec."Bundle Method"::Normal;
                                                    BundleGuideLineRec."Role ID" := LaySheetLine4Rec."Role ID";
                                                    BundleGuideLineRec."Shade Name" := LaySheetLine4Rec.Shade;
                                                    BundleGuideLineRec."Shade No" := LaySheetLine4Rec."Shade No";
                                                    BundleGuideLineRec."Style No" := rec."Style No.";
                                                    BundleGuideLineRec."Style Name" := rec."Style Name";

                                                    //TempLot := SewJobRec."Sewing Job No.";
                                                    //TempLot := TempLot.Substring(1, TempLot.IndexOfAny('-') - 1);
                                                    BundleGuideLineRec.Lot := '';

                                                    // StyleMasPoRec.Reset();
                                                    // StyleMasPoRec.SetRange("Style No.", rec."Style No.");
                                                    // StyleMasPoRec.SetRange("Lot No.", TempLot);
                                                    // if not StyleMasPoRec.FindSet() then
                                                    //     Error('Cannot find Sewing job no.');

                                                    BundleGuideLineRec.PO := LaySheetRec."PO No.";
                                                    BundleGuideLineRec.Insert();

                                                    TempQty := 0;
                                                    PreviuosBundleQty := 9999 - TempQty;
                                                end;
                                            until LaySheetLine4Rec.Next() = 0;
                                        end;
                                    end;
                                end;
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

                    // end
                    // else
                    //     Error('Cannot find Sewing Job Details for the Style : %1', rec."Style Name");

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