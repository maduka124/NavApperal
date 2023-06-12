page 50656 "LaySheetCard"
{
    PageType = Card;
    SourceTable = LaySheetHeader;
    Caption = 'Lay Sheet';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = EditableGB;

                field("LaySheetNo."; rec."LaySheetNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Lay Sheet No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;

                    // trigger OnLookup(var texts: text): Boolean
                    // var
                    //     RoleIssuHeadRec: Record RoleIssuingNoteHeader;
                    //     LaySheetHeadRec: Record LaySheetHeader;
                    //     RoleIssuNo: Code[20];
                    //     colorRec: Record Colour;
                    //     UserRec: Record "User Setup";
                    // begin
                    //     RoleIssuHeadRec.RESET;
                    //     RoleIssuHeadRec.SetCurrentKey("RoleIssuNo.");

                    //     IF RoleIssuHeadRec.FindSet() THEN BEGIN
                    //         REPEAT
                    //             LaySheetHeadRec.RESET;
                    //             LaySheetHeadRec.SetRange("LaySheetNo.", RoleIssuHeadRec."RoleIssuNo.");
                    //             IF not LaySheetHeadRec.FindSet() THEN
                    //                 RoleIssuHeadRec.MARK(TRUE);
                    //         UNTIL RoleIssuHeadRec.NEXT = 0;

                    //         RoleIssuHeadRec.MARKEDONLY(TRUE);

                    //         if Page.RunModal(50826, RoleIssuHeadRec) = Action::LookupOK then begin
                    //             rec."LaySheetNo." := RoleIssuHeadRec."RoleIssuNo.";

                    //             //Done By Sachith on 03/04/23 
                    //             UserRec.Reset();
                    //             UserRec.Get(UserId);

                    //             if UserRec."Factory Code" <> '' then begin
                    //                 Rec."Factory Code" := UserRec."Factory Code";
                    //                 CurrPage.Update();
                    //             end
                    //             else
                    //                 Error('Factory not assigned for the user.');
                    //         end;


                    //     END;
                    // END;
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange(Name, rec."Buyer Name");
                        if BuyerRec.FindSet() then
                            rec."Buyer No." := BuyerRec."No.";


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
                    end;
                }

                // field("FabReqNo."; rec."FabReqNo.")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Fabric Requsition No';
                //     ShowMandatory = true;

                //     trigger onvalidate()
                //     var
                //         FabricRequRec: Record FabricRequsition;
                //         FabricMapRec: Record FabricMapping;
                //         TableRec: Record TableCreartionLine;
                //         LoginSessionsRec: Record LoginSessions;
                //         LoginRec: Page "Login Card";
                //     begin

                //         //Check whether user logged in or not
                //         LoginSessionsRec.Reset();
                //         LoginSessionsRec.SetRange(SessionID, SessionId());

                //         if not LoginSessionsRec.FindSet() then begin  //not logged in
                //             Clear(LoginRec);
                //             LoginRec.LookupMode(true);
                //             LoginRec.RunModal();

                //             LoginSessionsRec.Reset();
                //             LoginSessionsRec.SetRange(SessionID, SessionId());
                //             if LoginSessionsRec.FindSet() then
                //                 rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                //         end
                //         else begin   //logged in
                //             rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                //         end;


                //         //Get details
                //         FabricRequRec.Reset();
                //         FabricRequRec.SetRange("FabReqNo.", rec."FabReqNo.");

                //         if FabricRequRec.FindSet() then begin
                //             rec."Cut No." := FabricRequRec."Cut No";
                //             rec."Style No." := FabricRequRec."Style No.";
                //             rec."Style Name" := FabricRequRec."Style Name";
                //             rec."Group ID" := FabricRequRec."Group ID";
                //             rec.Color := FabricRequRec."Colour Name";
                //             rec."Color No." := FabricRequRec."Colour No";
                //             rec."Component Group Name" := FabricRequRec."Component Group Name";
                //             rec."Component Group Code" := FabricRequRec."Component Group Code";
                //             rec."Marker Name" := FabricRequRec."Marker Name";
                //             rec."Po No." := FabricRequRec."PO No.";
                //         end;

                //         // Get item name
                //         FabricMapRec.Reset();
                //         FabricMapRec.SetRange("Style No.", rec."Style No.");
                //         FabricMapRec.SetRange("Colour No", rec."Color No.");
                //         FabricMapRec.SetRange("Component Group", rec."Component Group Code");

                //         if FabricMapRec.FindSet() then
                //             rec."Item Name" := FabricMapRec."Item Name";


                //         //Get plan date
                //         TableRec.Reset();
                //         TableRec.SetRange("Style No.", rec."Style No.");
                //         TableRec.SetRange("Colour No", rec."Color No.");
                //         TableRec.SetRange("Component Group", rec."Component Group Code");
                //         TableRec.SetRange("Group ID", rec."Group ID");
                //         TableRec.SetRange("Marker Name", rec."Marker Name");
                //         TableRec.SetRange("Cut No", rec."Cut No.");

                //         if TableRec.FindSet() then
                //             rec."Plan Date" := DT2Date(TableRec."Cut Start Date/Time");

                //         Insert_Lines1();
                //         Insert_Lines2();
                //         Insert_Lines3_4();
                //         Insert_Lines5();

                //     end;

                // }            

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';

                    trigger OnLookup(var text: Text): Boolean
                    var
                        NavProdDetRec: Record "NavApp Prod Plans Details";
                        Users: Record "User Setup";
                        StyleMasterRec: Record "Style Master";
                        StyleName: text[50];
                    begin

                        Users.Reset();
                        Users.SetRange("User ID", UserId());
                        Users.FindSet();
                        if Users."Factory Code" = '' then
                            Error('Factory is not setup for the user : %1 in User Setup. Cannot proceed.', UserId);

                        NavProdDetRec.Reset();
                        NavProdDetRec.SetRange("Factory No.", rec."Factory Code");
                        if NavProdDetRec.FindSet() then begin
                            repeat
                                if StyleName <> NavProdDetRec."Style Name" then begin
                                    NavProdDetRec.Mark(true);
                                    StyleName := NavProdDetRec."Style Name";
                                end
                                else
                                    StyleName := NavProdDetRec."Style Name";
                            until NavProdDetRec.Next() = 0;

                            NavProdDetRec.MARKEDONLY(TRUE);
                        end
                        else
                            Error('Cannot find styles for the factory : %1', rec."Factory Code");

                        if Page.RunModal(50511, NavProdDetRec) = Action::LookupOK then begin
                            rec."Style No." := NavProdDetRec."Style No.";
                            StyleMasterRec.Reset();
                            StyleMasterRec.get(rec."Style No.");
                            rec."Style Name" := StyleMasterRec."Style No.";
                        end;
                    end;
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LaySsheetColorRec: Record LaySheetColor;
                        AssoColorRec: Record AssortmentDetails;
                    begin
                        Insert_Lines1();

                        LaySsheetColorRec.Reset();
                        LaySsheetColorRec.SetRange("LaySheetNo.", rec."LaySheetNo.");
                        if LaySsheetColorRec.FindSet() then
                            LaySsheetColorRec.DeleteAll();

                        AssoColorRec.Reset();
                        AssoColorRec.SetRange("Style No.", rec."Style No.");
                        AssoColorRec.SetRange("PO No.", rec."PO No.");
                        AssoColorRec.SetFilter(Type, '=%1', '1');
                        if AssoColorRec.FindSet() then begin
                            repeat
                                LaySsheetColorRec.Init();
                                LaySsheetColorRec."LaySheetNo." := rec."LaySheetNo.";
                                LaySsheetColorRec.Color := AssoColorRec."Colour Name";
                                LaySsheetColorRec."Color No." := AssoColorRec."Colour No";
                                LaySsheetColorRec.Insert();
                            until AssoColorRec.Next() = 0;
                        end;
                    end;
                }

                field("Cut No."; rec."Cut No New")
                {
                    ApplicationArea = All;
                    Caption = 'Cut No';
                }

                // field(Color; rec.Color)
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }

                field("Component Group Name"; rec."Component Group Name")
                {
                    ApplicationArea = All;
                    Caption = 'Component Group';

                    trigger OnValidate()
                    var
                        MarkerCategoryRec: Record MarkerCategory;
                    begin
                        MarkerCategoryRec.Reset();
                        MarkerCategoryRec.SetRange("Marker Category", rec."Component Group Name");
                        if MarkerCategoryRec.FindSet() then
                            rec."Component Group Code" := MarkerCategoryRec."No.";
                    end;
                }

                field("Marker Name"; rec."Marker Name")
                {
                    ApplicationArea = All;
                    Caption = 'Marker';
                }

                field(TotalPies; rec.TotalPies)
                {
                    ApplicationArea = All;
                    Caption = 'Total Plies';
                    Editable = false;
                    DecimalPlaces = 0;
                }

                // field("Item Name"; rec."Item Name")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     Caption = 'Item';
                // }

                // field("Fab Direction"; rec."Fab Direction")
                // {
                //     ApplicationArea = All;
                // }

                // field("Plan Date"; rec."Plan Date")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
            }

            group("Size/Ratio/Qty")
            {
                Editable = EditableGB;

                part("Lay Sheet Line1"; "Lay Sheet Line1")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "LaySheetNo." = FIELD("LaySheetNo.");
                }
            }

            // group("Fabric Width/Length")
            // {

            //     Editable = EditableGB;

            //     part("Lay Sheet Line2"; "Lay Sheet Line2")
            //     {
            //         ApplicationArea = All;
            //         Caption = ' ';
            //         SubPageLink = "LaySheetNo." = FIELD("LaySheetNo.");
            //     }
            // }

            // group("Roll/Shade Summary")
            // {

            //     Editable = EditableGB;

            //     part("Lay Sheet Line3"; "Lay Sheet Line3")
            //     {
            //         ApplicationArea = All;
            //         Caption = ' ';
            //         SubPageLink = "LaySheetNo." = FIELD("LaySheetNo.");
            //     }
            // }

            group("Roll/Shade Details")
            {
                Editable = EditableGB;
                part("Lay Sheet Line4"; "Lay Sheet Line4")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "LaySheetNo." = FIELD("LaySheetNo.");
                }
            }

            // group(" ")
            // {
            //     Editable = EditableGB;
            //     part("Lay Sheet Line5"; "Lay Sheet Line5")
            //     {
            //         ApplicationArea = All;
            //         Caption = ' ';
            //         SubPageLink = "LaySheetNo." = FIELD("LaySheetNo.");
            //     }
            // }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."LaySheet Nos.", xRec."LaySheetNo.", rec."LaySheetNo.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."LaySheetNo.");
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        LaySheetLine1Rec: Record LaySheetLine1;
        LaySheetLine2Rec: Record LaySheetLine2;
        LaySheetLine3Rec: Record LaySheetLine3;
        LaySheetLine4Rec: Record LaySheetLine4;
        LaySheetLine5Rec: Record LaySheetLine5;
        //CutProRec: Record CuttingProgressHeader;
        BundleGuideRec: Record BundleGuideHeader;
        UserRec: Record "User Setup";
    begin

        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.')
        end
        else
            Error('You are not authorized to delete records.');

        //Check in the cutting progress
        // CutProRec.Reset();
        // CutProRec.SetRange(LaySheetNo, rec."LaySheetNo.");

        // if CutProRec.FindSet() then begin
        //     Message('Cannot delete. Lay Sheet No already used in the Cutting Progress No : %1', CutProRec."CutProNo.");
        //     exit(false);
        // end;


        //Check in the Lay SHeet
        BundleGuideRec.Reset();
        BundleGuideRec.SetRange("Style No.", rec."Style No.");
        BundleGuideRec.SetRange("Color No", rec."Color No.");
        // BundleGuideRec.SetRange("Group ID", rec."Group ID");
        BundleGuideRec.SetRange("Component Group", rec."Component Group Code");
        BundleGuideRec.SetRange("Cut No New", rec."Cut No New");

        if BundleGuideRec.FindSet() then begin
            Message('Cannot delete. Lay Sheet details already used in the Bundle Guide No : %1', BundleGuideRec."BundleGuideNo.");
            exit(false);
        end;

        LaySheetLine1Rec.Reset();
        LaySheetLine1Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
        if LaySheetLine1Rec.FindSet() then
            LaySheetLine1Rec.DeleteAll();

        LaySheetLine2Rec.Reset();
        LaySheetLine2Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
        if LaySheetLine2Rec.FindSet() then
            LaySheetLine2Rec.DeleteAll();

        LaySheetLine3Rec.Reset();
        LaySheetLine3Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
        if LaySheetLine3Rec.FindSet() then
            LaySheetLine3Rec.DeleteAll();

        LaySheetLine4Rec.Reset();
        LaySheetLine4Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
        if LaySheetLine4Rec.FindSet() then
            LaySheetLine4Rec.DeleteAll();

        LaySheetLine5Rec.Reset();
        LaySheetLine5Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
        if LaySheetLine5Rec.FindSet() then
            LaySheetLine5Rec.DeleteAll();
    end;

    procedure Insert_Lines1()
    var
        AssColSizeRatioViewRec: Record AssorColorSizeRatioView;
        LaySheetLine1Rec: Record LaySheetLine1;
    begin

        //Delete old records
        LaySheetLine1Rec.Reset();
        LaySheetLine1Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
        LaySheetLine1Rec.DeleteAll();

        //Get Sizes
        AssColSizeRatioViewRec.Reset();
        AssColSizeRatioViewRec.SetRange("Style No.", rec."Style No.");
        AssColSizeRatioViewRec.SetRange("PO No.", rec."PO No.");
        AssColSizeRatioViewRec.SetFilter("Colour Name", '=%1', '*');

        if AssColSizeRatioViewRec.FindSet() then begin
            LaySheetLine1Rec.Init();
            LaySheetLine1Rec."LaySheetNo." := rec."LaySheetNo.";
            LaySheetLine1Rec."Line No" := 1;
            LaySheetLine1Rec."Record Type" := 'SIZE';
            LaySheetLine1Rec."1" := AssColSizeRatioViewRec."1";
            LaySheetLine1Rec."2" := AssColSizeRatioViewRec."2";
            LaySheetLine1Rec."3" := AssColSizeRatioViewRec."3";
            LaySheetLine1Rec."4" := AssColSizeRatioViewRec."4";
            LaySheetLine1Rec."5" := AssColSizeRatioViewRec."5";
            LaySheetLine1Rec."6" := AssColSizeRatioViewRec."6";
            LaySheetLine1Rec."7" := AssColSizeRatioViewRec."7";
            LaySheetLine1Rec."8" := AssColSizeRatioViewRec."8";
            LaySheetLine1Rec."9" := AssColSizeRatioViewRec."9";
            LaySheetLine1Rec."10" := AssColSizeRatioViewRec."10";
            LaySheetLine1Rec."11" := AssColSizeRatioViewRec."11";
            LaySheetLine1Rec."12" := AssColSizeRatioViewRec."12";
            LaySheetLine1Rec."13" := AssColSizeRatioViewRec."13";
            LaySheetLine1Rec."14" := AssColSizeRatioViewRec."14";
            LaySheetLine1Rec."15" := AssColSizeRatioViewRec."15";
            LaySheetLine1Rec."16" := AssColSizeRatioViewRec."16";
            LaySheetLine1Rec."17" := AssColSizeRatioViewRec."17";
            LaySheetLine1Rec."18" := AssColSizeRatioViewRec."18";
            LaySheetLine1Rec."19" := AssColSizeRatioViewRec."19";
            LaySheetLine1Rec."20" := AssColSizeRatioViewRec."20";
            LaySheetLine1Rec."21" := AssColSizeRatioViewRec."21";
            LaySheetLine1Rec."22" := AssColSizeRatioViewRec."22";
            LaySheetLine1Rec."23" := AssColSizeRatioViewRec."23";
            LaySheetLine1Rec."24" := AssColSizeRatioViewRec."24";
            LaySheetLine1Rec."25" := AssColSizeRatioViewRec."25";
            LaySheetLine1Rec."26" := AssColSizeRatioViewRec."26";
            LaySheetLine1Rec."27" := AssColSizeRatioViewRec."27";
            LaySheetLine1Rec."28" := AssColSizeRatioViewRec."28";
            LaySheetLine1Rec."29" := AssColSizeRatioViewRec."29";
            LaySheetLine1Rec."30" := AssColSizeRatioViewRec."30";
            LaySheetLine1Rec."31" := AssColSizeRatioViewRec."31";
            LaySheetLine1Rec."32" := AssColSizeRatioViewRec."32";
            LaySheetLine1Rec."33" := AssColSizeRatioViewRec."33";
            LaySheetLine1Rec."34" := AssColSizeRatioViewRec."34";
            LaySheetLine1Rec."35" := AssColSizeRatioViewRec."35";
            LaySheetLine1Rec."36" := AssColSizeRatioViewRec."36";
            LaySheetLine1Rec."37" := AssColSizeRatioViewRec."37";
            LaySheetLine1Rec."38" := AssColSizeRatioViewRec."38";
            LaySheetLine1Rec."39" := AssColSizeRatioViewRec."39";
            LaySheetLine1Rec."40" := AssColSizeRatioViewRec."40";
            LaySheetLine1Rec."41" := AssColSizeRatioViewRec."41";
            LaySheetLine1Rec."42" := AssColSizeRatioViewRec."42";
            LaySheetLine1Rec."43" := AssColSizeRatioViewRec."43";
            LaySheetLine1Rec."44" := AssColSizeRatioViewRec."44";
            LaySheetLine1Rec."45" := AssColSizeRatioViewRec."45";
            LaySheetLine1Rec."46" := AssColSizeRatioViewRec."46";
            LaySheetLine1Rec."47" := AssColSizeRatioViewRec."47";
            LaySheetLine1Rec."48" := AssColSizeRatioViewRec."48";
            LaySheetLine1Rec."49" := AssColSizeRatioViewRec."49";
            LaySheetLine1Rec."50" := AssColSizeRatioViewRec."50";
            LaySheetLine1Rec."51" := AssColSizeRatioViewRec."51";
            LaySheetLine1Rec."52" := AssColSizeRatioViewRec."52";
            LaySheetLine1Rec."53" := AssColSizeRatioViewRec."53";
            LaySheetLine1Rec."54" := AssColSizeRatioViewRec."54";
            LaySheetLine1Rec."55" := AssColSizeRatioViewRec."55";
            LaySheetLine1Rec."56" := AssColSizeRatioViewRec."56";
            LaySheetLine1Rec."57" := AssColSizeRatioViewRec."57";
            LaySheetLine1Rec."58" := AssColSizeRatioViewRec."58";
            LaySheetLine1Rec."59" := AssColSizeRatioViewRec."59";
            LaySheetLine1Rec."60" := AssColSizeRatioViewRec."60";
            LaySheetLine1Rec."61" := AssColSizeRatioViewRec."61";
            LaySheetLine1Rec."62" := AssColSizeRatioViewRec."62";
            LaySheetLine1Rec."63" := AssColSizeRatioViewRec."63";
            LaySheetLine1Rec."64" := AssColSizeRatioViewRec."64";
            LaySheetLine1Rec."Color Total" := AssColSizeRatioViewRec.Total;
            LaySheetLine1Rec."Created User" := UserId;
            LaySheetLine1Rec.Insert();
        end
        else
            Error('Cannot find Cut color details in assorment card.');


        // //Get ratio
        // CutCreLineRec.Reset();
        // CutCreLineRec.SetRange("Style No.", rec."Style No.");
        // CutCreLineRec.SetRange("Colour No", rec."Color No.");
        // CutCreLineRec.SetRange("Group ID", rec."Group ID");
        // CutCreLineRec.SetRange("Component Group Code", rec."Component Group Code");
        // CutCreLineRec.SetRange("Record Type", 'R');
        // CutCreLineRec.SetRange("Cut No", 0);
        // CutCreLineRec.SetRange("Marker Name", rec."Marker Name");

        // if CutCreLineRec.FindSet() then begin

        LaySheetLine1Rec.Init();
        LaySheetLine1Rec."LaySheetNo." := rec."LaySheetNo.";
        LaySheetLine1Rec."Line No" := 2;
        LaySheetLine1Rec."Record Type" := 'RATIO';
        // LaySheetLine1Rec."1" := CutCreLineRec."1";
        // LaySheetLine1Rec."2" := CutCreLineRec."2";
        // LaySheetLine1Rec."3" := CutCreLineRec."3";
        // LaySheetLine1Rec."4" := CutCreLineRec."4";
        // LaySheetLine1Rec."5" := CutCreLineRec."5";
        // LaySheetLine1Rec."6" := CutCreLineRec."6";
        // LaySheetLine1Rec."7" := CutCreLineRec."7";
        // LaySheetLine1Rec."8" := CutCreLineRec."8";
        // LaySheetLine1Rec."9" := CutCreLineRec."9";
        // LaySheetLine1Rec."10" := CutCreLineRec."10";
        // LaySheetLine1Rec."11" := CutCreLineRec."11";
        // LaySheetLine1Rec."12" := CutCreLineRec."12";
        // LaySheetLine1Rec."13" := CutCreLineRec."13";
        // LaySheetLine1Rec."14" := CutCreLineRec."14";
        // LaySheetLine1Rec."15" := CutCreLineRec."15";
        // LaySheetLine1Rec."16" := CutCreLineRec."16";
        // LaySheetLine1Rec."17" := CutCreLineRec."17";
        // LaySheetLine1Rec."18" := CutCreLineRec."18";
        // LaySheetLine1Rec."19" := CutCreLineRec."19";
        // LaySheetLine1Rec."20" := CutCreLineRec."20";
        // LaySheetLine1Rec."21" := CutCreLineRec."21";
        // LaySheetLine1Rec."22" := CutCreLineRec."22";
        // LaySheetLine1Rec."23" := CutCreLineRec."23";
        // LaySheetLine1Rec."24" := CutCreLineRec."24";
        // LaySheetLine1Rec."25" := CutCreLineRec."25";
        // LaySheetLine1Rec."26" := CutCreLineRec."26";
        // LaySheetLine1Rec."27" := CutCreLineRec."27";
        // LaySheetLine1Rec."28" := CutCreLineRec."28";
        // LaySheetLine1Rec."29" := CutCreLineRec."29";
        // LaySheetLine1Rec."30" := CutCreLineRec."30";
        // LaySheetLine1Rec."31" := CutCreLineRec."31";
        // LaySheetLine1Rec."32" := CutCreLineRec."32";
        // LaySheetLine1Rec."33" := CutCreLineRec."33";
        // LaySheetLine1Rec."34" := CutCreLineRec."34";
        // LaySheetLine1Rec."35" := CutCreLineRec."35";
        // LaySheetLine1Rec."36" := CutCreLineRec."36";
        // LaySheetLine1Rec."37" := CutCreLineRec."37";
        // LaySheetLine1Rec."38" := CutCreLineRec."38";
        // LaySheetLine1Rec."39" := CutCreLineRec."39";
        // LaySheetLine1Rec."40" := CutCreLineRec."40";
        // LaySheetLine1Rec."41" := CutCreLineRec."41";
        // LaySheetLine1Rec."42" := CutCreLineRec."42";
        // LaySheetLine1Rec."43" := CutCreLineRec."43";
        // LaySheetLine1Rec."44" := CutCreLineRec."44";
        // LaySheetLine1Rec."45" := CutCreLineRec."45";
        // LaySheetLine1Rec."46" := CutCreLineRec."46";
        // LaySheetLine1Rec."47" := CutCreLineRec."47";
        // LaySheetLine1Rec."48" := CutCreLineRec."48";
        // LaySheetLine1Rec."49" := CutCreLineRec."49";
        // LaySheetLine1Rec."50" := CutCreLineRec."50";
        // LaySheetLine1Rec."51" := CutCreLineRec."51";
        // LaySheetLine1Rec."52" := CutCreLineRec."52";
        // LaySheetLine1Rec."53" := CutCreLineRec."53";
        // LaySheetLine1Rec."54" := CutCreLineRec."54";
        // LaySheetLine1Rec."55" := CutCreLineRec."55";
        // LaySheetLine1Rec."56" := CutCreLineRec."56";
        // LaySheetLine1Rec."57" := CutCreLineRec."57";
        // LaySheetLine1Rec."58" := CutCreLineRec."58";
        // LaySheetLine1Rec."59" := CutCreLineRec."59";
        // LaySheetLine1Rec."60" := CutCreLineRec."60";
        // LaySheetLine1Rec."61" := CutCreLineRec."61";
        // LaySheetLine1Rec."62" := CutCreLineRec."62";
        // LaySheetLine1Rec."63" := CutCreLineRec."63";
        // LaySheetLine1Rec."64" := CutCreLineRec."64";
        // LaySheetLine1Rec."Color Total" := CutCreLineRec."Color Total";
        LaySheetLine1Rec."Created User" := UserId;
        LaySheetLine1Rec.Insert();

        // end
        // else
        //     Error('Cannot find Cut Creation details.');


        // //Get Quantity
        // CutCreLineRec.Reset();
        // CutCreLineRec.SetRange("Style No.", rec."Style No.");
        // CutCreLineRec.SetRange("Colour No", rec."Color No.");
        // CutCreLineRec.SetRange("Group ID", rec."Group ID");
        // CutCreLineRec.SetRange("Component Group Code", rec."Component Group Code");
        // CutCreLineRec.SetRange("Record Type", 'R');
        // CutCreLineRec.SetRange("Marker Name", rec."Marker Name");
        // CutCreLineRec.SetRange("Cut No", rec."Cut No.");

        // if CutCreLineRec.FindSet() then begin

        //     Evaluate(PlyHieght, CutCreLineRec."1");

        //     LaySheetLine1Rec.Init();
        //     LaySheetLine1Rec."LaySheetNo." := rec."LaySheetNo.";
        //     LaySheetLine1Rec."Line No" := 3;
        //     LaySheetLine1Rec."Record Type" := 'QTY';
        //     LaySheetLine1Rec."1" := CutCreLineRec."1";
        //     LaySheetLine1Rec."2" := CutCreLineRec."2";
        //     LaySheetLine1Rec."3" := CutCreLineRec."3";
        //     LaySheetLine1Rec."4" := CutCreLineRec."4";
        //     LaySheetLine1Rec."5" := CutCreLineRec."5";
        //     LaySheetLine1Rec."6" := CutCreLineRec."6";
        //     LaySheetLine1Rec."7" := CutCreLineRec."7";
        //     LaySheetLine1Rec."8" := CutCreLineRec."8";
        //     LaySheetLine1Rec."9" := CutCreLineRec."9";
        //     LaySheetLine1Rec."10" := CutCreLineRec."10";
        //     LaySheetLine1Rec."11" := CutCreLineRec."11";
        //     LaySheetLine1Rec."12" := CutCreLineRec."12";
        //     LaySheetLine1Rec."13" := CutCreLineRec."13";
        //     LaySheetLine1Rec."14" := CutCreLineRec."14";
        //     LaySheetLine1Rec."15" := CutCreLineRec."15";
        //     LaySheetLine1Rec."16" := CutCreLineRec."16";
        //     LaySheetLine1Rec."17" := CutCreLineRec."17";
        //     LaySheetLine1Rec."18" := CutCreLineRec."18";
        //     LaySheetLine1Rec."19" := CutCreLineRec."19";
        //     LaySheetLine1Rec."20" := CutCreLineRec."20";
        //     LaySheetLine1Rec."21" := CutCreLineRec."21";
        //     LaySheetLine1Rec."22" := CutCreLineRec."22";
        //     LaySheetLine1Rec."23" := CutCreLineRec."23";
        //     LaySheetLine1Rec."24" := CutCreLineRec."24";
        //     LaySheetLine1Rec."25" := CutCreLineRec."25";
        //     LaySheetLine1Rec."26" := CutCreLineRec."26";
        //     LaySheetLine1Rec."27" := CutCreLineRec."27";
        //     LaySheetLine1Rec."28" := CutCreLineRec."28";
        //     LaySheetLine1Rec."29" := CutCreLineRec."29";
        //     LaySheetLine1Rec."30" := CutCreLineRec."30";
        //     LaySheetLine1Rec."31" := CutCreLineRec."31";
        //     LaySheetLine1Rec."32" := CutCreLineRec."32";
        //     LaySheetLine1Rec."33" := CutCreLineRec."33";
        //     LaySheetLine1Rec."34" := CutCreLineRec."34";
        //     LaySheetLine1Rec."35" := CutCreLineRec."35";
        //     LaySheetLine1Rec."36" := CutCreLineRec."36";
        //     LaySheetLine1Rec."37" := CutCreLineRec."37";
        //     LaySheetLine1Rec."38" := CutCreLineRec."38";
        //     LaySheetLine1Rec."39" := CutCreLineRec."39";
        //     LaySheetLine1Rec."40" := CutCreLineRec."40";
        //     LaySheetLine1Rec."41" := CutCreLineRec."41";
        //     LaySheetLine1Rec."42" := CutCreLineRec."42";
        //     LaySheetLine1Rec."43" := CutCreLineRec."43";
        //     LaySheetLine1Rec."44" := CutCreLineRec."44";
        //     LaySheetLine1Rec."45" := CutCreLineRec."45";
        //     LaySheetLine1Rec."46" := CutCreLineRec."46";
        //     LaySheetLine1Rec."47" := CutCreLineRec."47";
        //     LaySheetLine1Rec."48" := CutCreLineRec."48";
        //     LaySheetLine1Rec."49" := CutCreLineRec."49";
        //     LaySheetLine1Rec."50" := CutCreLineRec."50";
        //     LaySheetLine1Rec."51" := CutCreLineRec."51";
        //     LaySheetLine1Rec."52" := CutCreLineRec."52";
        //     LaySheetLine1Rec."53" := CutCreLineRec."53";
        //     LaySheetLine1Rec."54" := CutCreLineRec."54";
        //     LaySheetLine1Rec."55" := CutCreLineRec."55";
        //     LaySheetLine1Rec."56" := CutCreLineRec."56";
        //     LaySheetLine1Rec."57" := CutCreLineRec."57";
        //     LaySheetLine1Rec."58" := CutCreLineRec."58";
        //     LaySheetLine1Rec."59" := CutCreLineRec."59";
        //     LaySheetLine1Rec."60" := CutCreLineRec."60";
        //     LaySheetLine1Rec."61" := CutCreLineRec."61";
        //     LaySheetLine1Rec."62" := CutCreLineRec."62";
        //     LaySheetLine1Rec."63" := CutCreLineRec."63";
        //     LaySheetLine1Rec."64" := CutCreLineRec."64";
        //     LaySheetLine1Rec."Color Total" := CutCreLineRec."Color Total";
        //     LaySheetLine1Rec."Created User" := UserId;
        //     LaySheetLine1Rec.Insert();

        // end
        // else
        //     Error('Cannot find Cut Creation details.');

    end;

    // procedure Insert_Lines2()
    // var
    //     FabReqRec: Record FabricRequsition;
    //     RatioCreRec: Record RatioCreationLine;
    //     LaySheetLine2Rec: Record LaySheetLine2;
    // begin

    //     //Delete old records
    //     LaySheetLine2Rec.Reset();
    //     LaySheetLine2Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
    //     LaySheetLine2Rec.DeleteAll();

    //     LaySheetLine2Rec.Init();
    //     LaySheetLine2Rec."LaySheetNo." := rec."LaySheetNo.";
    //     LaySheetLine2Rec."Line No" := 1;

    //     //Get details from Ratio Creation
    //     RatioCreRec.Reset();
    //     RatioCreRec.SetRange("Style No.", rec."Style No.");
    //     RatioCreRec.SetRange("Colour No", rec."Color No.");
    //     RatioCreRec.SetRange("Group ID", rec."Group ID");
    //     RatioCreRec.SetRange("Component Group Code", rec."Component Group Code");
    //     RatioCreRec.SetRange("Marker Name", rec."Marker Name");
    //     RatioCreRec.SetRange("Record Type", 'R');

    //     if RatioCreRec.FindSet() then begin

    //         LaySheetLine2Rec."Pattern Version" := RatioCreRec."Pattern Version";
    //         //LaySheetLine2Rec."No of Plies" := RatioCreRec.Plies;
    //         LaySheetLine2Rec."No of Plies" := PlyHieght;

    //         if RatioCreRec."UOM Code" = 'YDS' then
    //             LaySheetLine2Rec.LayLength := (RatioCreRec.Length + ((RatioCreRec."Length Tollarance  " * 2) / 36))
    //         else
    //             if RatioCreRec."UOM Code" = 'MTS' then
    //                 LaySheetLine2Rec.LayLength := (RatioCreRec.Length + ((RatioCreRec."Length Tollarance  " * 2) / 100));

    //         LaySheetLine2Rec."UOM Code" := RatioCreRec."UOM Code";
    //         LaySheetLine2Rec."UOM" := RatioCreRec."UOM";

    //     end
    //     else
    //         Error('Cannot find Ratio details.');


    //     //Get details from FabricRequsitionLine
    //     FabReqRec.Reset();
    //     FabReqRec.SetRange("Style No.", rec."Style No.");
    //     FabReqRec.SetRange("Colour No", rec."Color No.");
    //     FabReqRec.SetRange("Group ID", rec."Group ID");
    //     FabReqRec.SetRange("Component Group Code", rec."Component Group Code");
    //     FabReqRec.SetRange("Marker Name", rec."Marker Name");
    //     FabReqRec.SetRange("Cut No", rec."Cut No.");

    //     if FabReqRec.FindSet() then begin
    //         LaySheetLine2Rec."Fab. Req. For Lay" := FabReqRec."Required Length";
    //         LaySheetLine2Rec."Act. Width" := FabReqRec."Marker Width";
    //     end
    //     else
    //         Error('Cannot find Fabric Requisition details.');


    //     LaySheetLine2Rec."Created User" := UserId;
    //     LaySheetLine2Rec.Insert();

    // end;

    // procedure Insert_Lines3_4()
    // var
    //     RoleIssHeadeRec: Record RoleIssuingNoteHeader;
    //     RatioLineRec: Record RatioCreationLine;
    //     RatioHeadRec: Record RatioCreation;
    //     RoleIssRec: Record RoleIssuingNoteLine;
    //     LaySheetLine3Rec: Record LaySheetLine3;
    //     LaySheetLine4Rec: Record LaySheetLine4;
    //     UOM: text[20];
    //     UOMCode: code[20];
    //     LIneNo: Integer;
    //     LIneNo1: Integer;
    //     Shade: Code[20];
    //     TotalQty: Decimal;
    // begin

    //     RatioHeadRec.Reset();
    //     RatioHeadRec.SetRange("Style No.", rec."Style No.");
    //     RatioHeadRec.SetRange("Colour No", rec."Color No.");
    //     RatioHeadRec.SetRange("Component Group", rec."Component Group Code");
    //     RatioHeadRec.SetRange("Group ID", rec."Group ID");

    //     if RatioHeadRec.FindSet() then begin
    //         RatioLineRec.Reset();
    //         RatioLineRec.SetRange(RatioCreNo, RatioHeadRec.RatioCreNo);
    //         RatioLineRec.SetRange("Marker Name", rec."Marker Name");
    //         RatioLineRec.FindSet();
    //     end;


    //     //Delete old records
    //     LaySheetLine3Rec.Reset();
    //     LaySheetLine3Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
    //     LaySheetLine3Rec.DeleteAll();

    //     //Delete old records
    //     LaySheetLine4Rec.Reset();
    //     LaySheetLine4Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
    //     LaySheetLine4Rec.DeleteAll();

    //     RoleIssHeadeRec.Reset();
    //     RoleIssHeadeRec.SetRange("RoleIssuNo.", rec."LaySheetNo.");
    //     if RoleIssHeadeRec.FindSet() then begin
    //         UOM := RoleIssHeadeRec.UOM;
    //         UOMCode := RoleIssHeadeRec."UOM Code";
    //     end;

    //     //Get details from FabricRequsitionLine (Table 3)
    //     RoleIssRec.Reset();
    //     RoleIssRec.SetRange("RoleIssuNo.", rec."LaySheetNo.");
    //     RoleIssRec.SetCurrentKey("Shade No");
    //     RoleIssRec.SetFilter(Selected, '=%1', true);
    //     RoleIssRec.Ascending(true);

    //     if RoleIssRec.FindSet() then begin
    //         repeat
    //             if Shade <> RoleIssRec.Shade then begin
    //                 TotalQty := 0;
    //                 LIneNo1 += 1;
    //                 LaySheetLine3Rec.Init();
    //                 LaySheetLine3Rec."LaySheetNo." := rec."LaySheetNo.";
    //                 LaySheetLine3Rec."LineNo." := LIneNo1;
    //                 LaySheetLine3Rec."Shade No" := RoleIssRec."Shade No";
    //                 LaySheetLine3Rec.Shade := RoleIssRec.Shade;
    //                 LaySheetLine3Rec."Shade Wise Total Fab (Meters)" := RoleIssRec."Length Allocated";
    //                 LaySheetLine3Rec."No of Plies From Shade" := 0;
    //                 LaySheetLine3Rec."Created User" := UserId;
    //                 LaySheetLine3Rec.Insert();
    //             end
    //             else begin
    //                 TotalQty += RoleIssRec."Length Allocated";

    //                 LaySheetLine3Rec.Reset();
    //                 LaySheetLine3Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
    //                 LaySheetLine3Rec.SetRange("LineNo.", LIneNo1);

    //                 if LaySheetLine3Rec.FindSet() then
    //                     LaySheetLine3Rec.ModifyAll("Shade Wise Total Fab (Meters)", TotalQty);
    //             end;

    //             Shade := RoleIssRec.Shade;
    //         until RoleIssRec.Next() = 0;
    //     end;


    //     //Get details from FabricRequsitionLine (Table 4)
    //     RoleIssRec.Reset();
    //     RoleIssRec.SetRange("RoleIssuNo.", rec."LaySheetNo.");
    //     RoleIssRec.SetCurrentKey("Selected Seq");
    //     RoleIssRec.SetFilter(Selected, '=%1', true);
    //     RoleIssRec.Ascending(true);

    //     if RoleIssRec.FindSet() then begin
    //         repeat
    //             LIneNo += 1;
    //             LaySheetLine4Rec.Init();
    //             LaySheetLine4Rec."LaySheetNo." := rec."LaySheetNo.";
    //             LaySheetLine4Rec."Line No." := LIneNo;
    //             LaySheetLine4Rec."Shade No" := RoleIssRec."Shade No";
    //             LaySheetLine4Rec.Shade := RoleIssRec.Shade;
    //             LaySheetLine4Rec.Batch := RoleIssRec."Supplier Batch No.";
    //             LaySheetLine4Rec."Role ID" := RoleIssRec."Role ID";
    //             LaySheetLine4Rec."Ticket Length" := RoleIssRec."Length Tag";

    //             if (RatioLineRec.Length + RatioLineRec."Length Tollarance  ") > 0 then
    //                 LaySheetLine4Rec."Planned Plies" := round(RoleIssRec."Length Tag" / (RatioLineRec.Length + RatioLineRec."Length Tollarance  "), 1)
    //             else
    //                 LaySheetLine4Rec."Planned Plies" := 0;

    //             LaySheetLine4Rec."Allocated Qty" := RoleIssRec."Length Allocated";
    //             LaySheetLine4Rec.UOM := UOM;
    //             LaySheetLine4Rec."UOM Code" := UOMCode;
    //             LaySheetLine4Rec."Created User" := UserId;
    //             LaySheetLine4Rec.Insert();
    //         until RoleIssRec.Next() = 0;
    //     end;

    // end;

    // procedure Insert_Lines5()
    // var
    //     LaySheetLine5Rec: Record LaySheetLine5;
    // begin
    //     LaySheetLine5Rec.Reset();
    //     LaySheetLine5Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");

    //     if not LaySheetLine5Rec.FindSet() then begin

    //         LaySheetLine5Rec.Init();
    //         LaySheetLine5Rec."LaySheetNo." := rec."LaySheetNo.";
    //         LaySheetLine5Rec.Type := 'Team';
    //         LaySheetLine5Rec."Created Date" := Today;
    //         LaySheetLine5Rec."Created User" := UserId;
    //         LaySheetLine5Rec.Insert();

    //         LaySheetLine5Rec.Init();
    //         LaySheetLine5Rec."LaySheetNo." := rec."LaySheetNo.";
    //         LaySheetLine5Rec.Type := 'Emp No1';
    //         LaySheetLine5Rec."Created Date" := Today;
    //         LaySheetLine5Rec."Created User" := UserId;
    //         LaySheetLine5Rec.Insert();

    //         LaySheetLine5Rec.Init();
    //         LaySheetLine5Rec."LaySheetNo." := rec."LaySheetNo.";
    //         LaySheetLine5Rec.Type := 'Emp No2';
    //         LaySheetLine5Rec."Created Date" := Today;
    //         LaySheetLine5Rec."Created User" := UserId;
    //         LaySheetLine5Rec.Insert();

    //         LaySheetLine5Rec.Init();
    //         LaySheetLine5Rec."LaySheetNo." := rec."LaySheetNo.";
    //         LaySheetLine5Rec.Type := 'Emp No3';
    //         LaySheetLine5Rec."Created Date" := Today;
    //         LaySheetLine5Rec."Created User" := UserId;
    //         LaySheetLine5Rec.Insert();

    //         LaySheetLine5Rec.Init();
    //         LaySheetLine5Rec."LaySheetNo." := rec."LaySheetNo.";
    //         LaySheetLine5Rec.Type := 'Emp No4';
    //         LaySheetLine5Rec."Created Date" := Today;
    //         LaySheetLine5Rec."Created User" := UserId;
    //         LaySheetLine5Rec.Insert();

    //         LaySheetLine5Rec.Init();
    //         LaySheetLine5Rec."LaySheetNo." := rec."LaySheetNo.";
    //         LaySheetLine5Rec.Type := 'Emp No5';
    //         LaySheetLine5Rec."Created Date" := Today;
    //         LaySheetLine5Rec."Created User" := UserId;
    //         LaySheetLine5Rec.Insert();

    //         LaySheetLine5Rec.Init();
    //         LaySheetLine5Rec."LaySheetNo." := rec."LaySheetNo.";
    //         LaySheetLine5Rec.Type := 'Date';
    //         LaySheetLine5Rec."Created Date" := Today;
    //         LaySheetLine5Rec."Created User" := UserId;
    //         LaySheetLine5Rec.Insert();

    //         LaySheetLine5Rec.Init();
    //         LaySheetLine5Rec."LaySheetNo." := rec."LaySheetNo.";
    //         LaySheetLine5Rec.Type := 'Time';
    //         LaySheetLine5Rec."Created Date" := Today;
    //         LaySheetLine5Rec."Created User" := UserId;
    //         LaySheetLine5Rec.Insert();

    //     end;

    // end;

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
        PlyHieght: Decimal;
}