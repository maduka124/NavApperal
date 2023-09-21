page 50351 "Daily Cutting Out Card"
{
    PageType = Card;
    SourceTable = ProductionOutHeader;
    Caption = 'Daily Cutting Out';

    layout
    {
        area(Content)
        {
            group("Input/Output Style Detail")
            {
                Editable = EditableGB;

                field("Prod Date"; rec."Prod Date")
                {
                    ApplicationArea = All;
                    Caption = 'Production Date';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        CodeUnitRec: Codeunit NavAppCodeUnit3;
                    begin
                        //Check for Holidays
                        if CodeUnitRec.CheckforHolidays(rec."Prod Date", rec."Resource No.") then
                            Error('In %1 , Line No : %2 is a holiday. You cannot put IN/OUT.', rec."Prod Date", rec."Resource Name");

                        rec.Type := rec.Type::Cut;
                    end;
                }

                field("Resource Name"; rec."Resource Name")
                {
                    ApplicationArea = All;
                    Caption = 'Section';
                    ShowMandatory = true;

                    // trigger OnValidate()
                    // var
                    //     WorkCenterRec: Record "Work Center";
                    //     LoginSessionsRec: Record LoginSessions;
                    //     LoginRec: Page "Login Card";
                    // begin
                    //     WorkCenterRec.Reset();
                    //     WorkCenterRec.SetRange(Name, rec."Resource Name");

                    //     if WorkCenterRec.FindSet() then
                    //         rec."Resource No." := WorkCenterRec."No.";


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
                    // end;

                    //Mihiranga 2022/12/15
                    trigger OnLookup(var texts: text): Boolean
                    var
                        UserSetupRec: Record "User Setup";
                        WorkCentrRec: Record "Work Center";
                        LoginRec: Page "Login Card";
                        LoginSessionsRec: Record LoginSessions;
                        CodeUnitRec: Codeunit NavAppCodeUnit3;
                    begin

                        UserSetupRec.Get(UserId);
                        WorkCentrRec.Reset();
                        WorkCentrRec.SetFilter(WorkCentrRec."Planning Line", '=%1', true);
                        WorkCentrRec.SetRange("Factory No.", UserSetupRec."Factory Code");
                        WorkCentrRec.FindSet();

                        if Page.RunModal(51159, WorkCentrRec) = Action::LookupOK then begin
                            //Check for Holidays
                            if CodeUnitRec.CheckforHolidays(rec."Prod Date", WorkCentrRec."No.") then
                                Error('In %1 , Line No : %2 is a holiday. You cannot put IN/OUT.', rec."Prod Date", WorkCentrRec.Name);

                            Rec."Resource No." := WorkCentrRec."No.";
                            Rec."Resource Name" := WorkCentrRec.Name;
                            Rec."Factory Code" := WorkCentrRec."Factory No.";
                            Rec."Factory Name" := WorkCentrRec."Factory Name";
                        end;

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


                    trigger OnValidate()
                    var
                        WorkCenterRec: Record "Work Center";
                    begin
                        WorkCenterRec.Reset();
                        WorkCenterRec.SetRange(Name, rec."Resource Name");
                        if WorkCenterRec.FindSet() then begin
                            rec."Resource No." := WorkCenterRec."No.";
                            Rec."Factory Code" := WorkCenterRec."Factory No.";
                            Rec."Factory Name" := WorkCenterRec."Factory Name";
                        end
                        else
                            Error('Invalid Section');
                    end;

                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    ShowMandatory = true;

                    trigger OnLookup(var text: Text): Boolean
                    var
                        NavAppPlanRec: Record "NavApp Planning Lines";
                        BundleGHeaderRec: Record BundleGuideHeader;
                        NavProdDetRec: Record "NavApp Prod Plans Details";//not navapplanning line
                        Users: Record "User Setup";
                        StyleMasterRec: Record "Style Master";
                        StyleName: text[50];
                    begin

                        Users.Reset();
                        Users.SetRange("User ID", UserId());
                        Users.FindSet();
                        if Users."Factory Code" = '' then
                            Error('Factory is not setup for the user : %1 in User Setup. Cannot proceed.', UserId);

                        // NavAppPlanRec.Reset();
                        // NavAppPlanRec.SetCurrentKey("Style Name");
                        // NavAppPlanRec.Ascending(true);
                        // NavAppPlanRec.SetRange("Factory", Users."Factory Code");
                        // NavAppPlanRec.SetRange("Resource No.", rec."Resource No.");
                        // NavAppPlanRec.SetFilter(PlanDate, '%1..%2', rec."Prod Date", rec."Prod Date" + 3);
                        // if NavAppPlanRec.Findset() then begin
                        //     repeat
                        //         if StyleName <> NavAppPlanRec."Style Name" then begin
                        //             BundleGHeaderRec.Reset();
                        //             // BundleGHeaderRec.SetRange("Style No.", NavAppPlanRec."Style No.");
                        //             // if BundleGHeaderRec.Findset() then
                        //             NavAppPlanRec.Mark(true);

                        //             StyleName := NavAppPlanRec."Style Name";
                        //         end
                        //         else
                        //             StyleName := NavAppPlanRec."Style Name";
                        //     until NavAppPlanRec.Next() = 0;

                        //     NavAppPlanRec.MARKEDONLY(TRUE);
                        // end;

                        NavProdDetRec.Reset();
                        NavProdDetRec.SetRange("Resource No.", rec."Resource No.");
                        NavProdDetRec.SetFilter(PlanDate, '%1..%2', rec."Prod Date", rec."Prod Date" + 3);
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
                            Error('Cannot find planning details');

                        // if Page.RunModal(51224, NavAppPlanRec) = Action::LookupOK then begin
                        //     rec."Style No." := NavAppPlanRec."Style No.";
                        //     rec."Style Name" := NavAppPlanRec."Style Name";
                        // end;

                        if Page.RunModal(50511, NavProdDetRec) = Action::LookupOK then begin
                            rec."Style No." := NavProdDetRec."Style No.";
                            StyleMasterRec.Reset();
                            StyleMasterRec.get(rec."Style No.");
                            rec."Style Name" := StyleMasterRec."Style No.";
                        end;

                    end;
                }

                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Lot No';

                    trigger OnLookup(var text: Text): Boolean
                    var
                        StyleMasterRec: Record "Style Master PO";
                        NavAppProdPlansDetRec: Record "NavApp Prod Plans Details";
                    begin

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", rec."Style No.");

                        if Page.RunModal(51068, StyleMasterRec) = Action::LookupOK then begin
                            rec."Lot No." := StyleMasterRec."Lot No.";
                            rec."PO No" := StyleMasterRec."PO No.";
                        end;

                        GridHeader_Insert();

                        //Get and Set Line No
                        NavAppProdPlansDetRec.Reset();
                        NavAppProdPlansDetRec.SetRange("Style No.", rec."Style No.");
                        NavAppProdPlansDetRec.SetRange("Lot No.", StyleMasterRec."Lot No.");
                        NavAppProdPlansDetRec.SetRange(PlanDate, rec."Prod Date");
                        NavAppProdPlansDetRec.SetRange("Resource No.", rec."Resource No.");

                        if NavAppProdPlansDetRec.FindSet() then
                            rec."Ref Line No." := NavAppProdPlansDetRec."Line No.";

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", rec."Style No.");
                        StyleMasterRec.SetRange("Lot No.", rec."Lot No.");

                        if StyleMasterRec.FindSet() then begin
                            rec."Input Qty" := StyleMasterRec."Cut In Qty";
                            CurrPage.Update();
                        end;

                    end;
                }

                field("PO No"; rec."PO No")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                    Editable = false;
                }

                //Mihiranga 2023/02/26
                field("Input Qty"; rec."Input Qty")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Caption = 'Bundle Guide Qty (Input Qty)';

                    trigger OnValidate()
                    var
                        ProdOutHeaderRec: Record ProductionOutHeader;
                        LineTotal: BigInteger;
                        StyleMasterPORec: Record "Style Master PO";
                        WastageRec: Record ExtraPercentageForCutting;
                        Waistage: Decimal;
                    begin
                        CurrPage.Update();

                        StyleMasterPORec.Reset();
                        StyleMasterPORec.SetRange("Style No.", Rec."Style No.");
                        StyleMasterPORec.SetRange("Lot No.", Rec."Lot No.");
                        if StyleMasterPORec.FindSet() then begin

                            //Get the wastage from wastage table
                            WastageRec.Reset();
                            WastageRec.SetFilter("Start Qty", '<=%1', StyleMasterPORec.Qty);
                            WastageRec.SetFilter("Finish Qty", '>=%1', StyleMasterPORec.Qty);
                            if WastageRec.FindSet() then
                                Waistage := WastageRec.Percentage;

                            if rec."Input Qty" > (StyleMasterPORec.Qty + (StyleMasterPORec.Qty * Waistage) / 100) then
                                Error('Input Qty is greater than the (Order Qty + Extra Qty)');
                        end
                        else
                            Error('Cannot find PO details.');


                        //Get Input Total for the style and lot for all days
                        LineTotal := 0;
                        ProdOutHeaderRec.Reset();
                        ProdOutHeaderRec.SetRange("Style No.", Rec."Style No.");
                        ProdOutHeaderRec.SetRange("Lot No.", Rec."Lot No.");
                        ProdOutHeaderRec.SetRange(Type, Rec.Type);

                        if ProdOutHeaderRec.FindSet() then begin
                            repeat
                                LineTotal += ProdOutHeaderRec."Input Qty";
                            until ProdOutHeaderRec.Next() = 0;
                        end;

                        StyleMasterPORec.Reset();
                        StyleMasterPORec.SetRange("Style No.", Rec."Style No.");
                        StyleMasterPORec.SetRange("Lot No.", Rec."Lot No.");
                        StyleMasterPORec.FindSet();

                        StyleMasterPORec.ModifyAll("Cut In Qty", LineTotal);
                    end;
                }

                field("Output Qty"; rec."Output Qty")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        StyleMasterPORec: Record "Style Master PO";
                        WastageRec: Record ExtraPercentageForCutting;
                        Waistage: Decimal;
                    begin
                        if rec."Input Qty" < rec."Output Qty" then
                            Error('Output quantity is greater than Input quantity.');

                        StyleMasterPORec.Reset();
                        StyleMasterPORec.SetRange("Style No.", Rec."Style No.");
                        StyleMasterPORec.SetRange("Lot No.", Rec."Lot No.");
                        if StyleMasterPORec.FindSet() then begin

                            //Get the wastage from wastage table
                            WastageRec.Reset();
                            WastageRec.SetFilter("Start Qty", '<=%1', StyleMasterPORec.Qty);
                            WastageRec.SetFilter("Finish Qty", '>=%1', StyleMasterPORec.Qty);
                            if WastageRec.FindSet() then
                                Waistage := WastageRec.Percentage;

                            if rec."Output Qty" > (StyleMasterPORec.Qty + (StyleMasterPORec.Qty * Waistage) / 100) then
                                Error('Output Qty is greater than the (Order Qty + Extra Qty)');
                        end
                        else
                            Error('Cannot find PO details.');
                    end;
                }
            }

            group("Color/Size Output Detail")
            {
                Editable = EditableGB;

                part(DailyCuttingOutListPart; DailyCuttingOutListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = Type = field(Type), "No." = field("No.");
                }
            }

            group("PO Detail")
            {
                part("Style Master PO Prod ListPart"; "Style Master PO Prod ListPart")
                {
                    ApplicationArea = All;
                    SubPageLink = "Style No." = FIELD("Style No."), "Lot No." = field("Lot No.");
                    Caption = ' ';
                    Editable = false;
                }
            }
        }
    }


    // actions
    // {
    //     area(Processing)
    //     {
    //         action("Update Runtime")
    //         {
    //             ApplicationArea = All;
    //             Image = UpdateDescription;

    //             trigger OnAction()
    //             var
    //                 CodeUnitNavapp: Codeunit NavAppCodeUnit;
    //                 UserRec: Record "User Setup";
    //             begin

    //                 //Done By sachith on 18/04/23
    //                 UserRec.Reset();
    //                 UserRec.Get(UserId);

    //                 if UserRec."Factory Code" <> '' then begin
    //                     if (UserRec."Factory Code" <> rec."Factory Code") then
    //                         Error('You are not authorized to Update Runtime.')
    //                 end
    //                 else
    //                     Error('Factory not assigned for the user.');

    //                 CodeUnitNavapp.Update_Runtime(rec."Style Name", rec."Style No.", 'CUTTING');
    //                 Message('Cutting Runtime Updated');
    //             end;
    //         }
    //     }
    // }


    trigger OnInit()
    var
    begin
        rec.Type := rec.Type::Cut;
    end;


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ProductionOutLine: Record ProductionOutLine;
        LineTotal: BigInteger;
    begin

        if (rec."Style No." <> '') and (rec."Lot No." <> '') then begin

            if rec."Input Qty" < rec."Output Qty" then begin
                Error('Output quantity is greater than Input quantity.');
                exit;
            end;

            LineTotal := 0;

            ProductionOutLine.Reset();
            ProductionOutLine.SetRange("No.", rec."No.");

            if ProductionOutLine.FindSet() then begin
                repeat
                    if ProductionOutLine."Colour No" <> '*' then
                        LineTotal += ProductionOutLine.Total;
                until ProductionOutLine.Next() = 0;

                if LineTotal <> rec."Output Qty" then begin
                    Error('Output quantity should match color/size total quantity.');
                    exit;
                end;

            end;
        end;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        ProdOutHeaderRec: Record ProductionOutHeader;
        NavAppCodeUnit: Codeunit NavAppCodeUnit;
        UserRec: Record "User Setup";
        SawOut: Integer;
        SawIn: Integer;
    begin
        if rec.Type = rec.Type::Cut then begin

            SawIn := 0;
            ProdOutHeaderRec.Reset();
            ProdOutHeaderRec.SetRange("Style No.", Rec."Style No.");
            ProdOutHeaderRec.SetRange("PO No", Rec."PO No");
            ProdOutHeaderRec.SetRange("Lot No.", Rec."Lot No.");
            ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
            if ProdOutHeaderRec.FindSet() then begin
                repeat
                    SawIn += ProdOutHeaderRec."Input Qty";
                until ProdOutHeaderRec.Next() = 0;
            end;
            SawOut := 0;
            ProdOutHeaderRec.Reset();
            ProdOutHeaderRec.SetRange("Out Style No.", Rec."Style No.");
            ProdOutHeaderRec.SetRange("PO No", Rec."PO No");
            ProdOutHeaderRec.SetRange("Lot No.", Rec."Lot No.");
            ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
            if ProdOutHeaderRec.FindSet() then begin
                repeat
                    SawOut += ProdOutHeaderRec."Output Qty";
                until ProdOutHeaderRec.Next() = 0;
            end;

            if SawOut > SawIn - Rec."Output Qty" then
                Error('This Record Cannot delete');

            ProdOutHeaderRec.Reset();
            ProdOutHeaderRec.SetRange("Prod Date", rec."Prod Date");
            ProdOutHeaderRec.SetRange("Factory Code", rec."Factory Code");
            ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Saw);
            ProdOutHeaderRec.SetFilter("Prod Updated", '=%1', 1);
            if ProdOutHeaderRec.FindSet() then
                Error('Production updated against Date : %1 , Factory : %2 has been updates. You cannot delete this entry.', rec."Prod Date", rec."Factory Name");
        end;

        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.');
        end
        else
            Error('You are not authorized to delete records.');

        NavAppCodeUnit.Delete_Prod_Records(rec."No.", rec."Style No.", rec."Lot No.", 'OUT', 'Cut', rec.Type::Cut);
    end;


    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        UserRec.Reset();
        UserRec.Get(UserId);

        if rec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> '') then begin
                if (UserRec."Factory Code" <> rec."Factory Code") then
                    EditableGB := false
                else
                    EditableGB := true;
            end
            else
                EditableGB := false;
        end
        else  //New Mode
            if (UserRec."Factory Code" = '') then begin
                EditableGB := false;
                Error('Factory not assigned for the user.');
            end
            else
                EditableGB := true;
    end;


    trigger OnAfterGetCurrRecord()
    var
        UserRec: Record "User Setup";
        ProdOutHeaderRec: Record ProductionOutHeader;
    begin
        UserRec.Reset();
        UserRec.Get(UserId);

        if rec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> '') then begin
                if (UserRec."Factory Code" <> rec."Factory Code") then
                    EditableGB := false
                // else begin
                //     if rec.Type = rec.Type::Cut then begin
                //         ProdOutHeaderRec.Reset();
                //         ProdOutHeaderRec.SetRange("Prod Date", rec."Prod Date");
                //         ProdOutHeaderRec.SetRange("Factory Code", rec."Factory Code");
                //         ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Saw);
                //         ProdOutHeaderRec.SetFilter("Prod Updated", '=%1', 1);
                //         if ProdOutHeaderRec.FindSet() then
                //             EditableGB := false
                //         else
                //             EditableGB := true;
                //     end;
                // end;
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


    procedure GridHeader_Insert()
    var
        AssoRec: Record AssorColorSizeRatio;
        ProductionOutLine: Record ProductionOutLine;
        LineNo: BigInteger;
    begin
        if (rec."Style No." <> '') and (rec."Lot No." <> '') then begin

            ProductionOutLine.Reset();
            ProductionOutLine.SetRange("No.", rec."No.");

            if ProductionOutLine.FindLast() then
                LineNo := ProductionOutLine."Line No.";

            AssoRec.Reset();
            AssoRec.SetRange("Style No.", rec."Style No.");
            AssoRec.SetRange("Lot No.", rec."Lot No.");

            if AssoRec.FindSet() then begin
                repeat
                    //Check duplicates beforen inserting
                    ProductionOutLine.Reset();
                    ProductionOutLine.SetRange("No.", rec."No.");
                    ProductionOutLine.SetRange("Colour No", AssoRec."Colour No");

                    if not ProductionOutLine.FindSet() then begin

                        LineNo += 1;
                        ProductionOutLine.Init();
                        ProductionOutLine."No." := rec."No.";
                        ProductionOutLine."Line No." := LineNo;
                        ProductionOutLine."Colour No" := AssoRec."Colour No";
                        ProductionOutLine."Colour Name" := AssoRec."Colour Name";
                        ProductionOutLine."Style No." := AssoRec."Style No.";
                        ProductionOutLine."Style Name" := AssoRec."Style Name";
                        ProductionOutLine."PO No." := AssoRec."PO No.";
                        ProductionOutLine."Lot No." := AssoRec."Lot No.";
                        ProductionOutLine.In_Out := 'OUT';
                        ProductionOutLine.Type := rec.Type;
                        ProductionOutLine.Total := 0;

                        if AssoRec."Colour No" = '*' then begin

                            ProductionOutLine."1" := AssoRec."1";
                            ProductionOutLine."2" := AssoRec."2";
                            ProductionOutLine."3" := AssoRec."3";
                            ProductionOutLine."4" := AssoRec."4";
                            ProductionOutLine."5" := AssoRec."5";
                            ProductionOutLine."6" := AssoRec."6";
                            ProductionOutLine."7" := AssoRec."7";
                            ProductionOutLine."8" := AssoRec."8";
                            ProductionOutLine."9" := AssoRec."9";
                            ProductionOutLine."10" := AssoRec."10";
                            ProductionOutLine."11" := AssoRec."11";
                            ProductionOutLine."12" := AssoRec."12";
                            ProductionOutLine."13" := AssoRec."13";
                            ProductionOutLine."14" := AssoRec."14";
                            ProductionOutLine."15" := AssoRec."15";
                            ProductionOutLine."16" := AssoRec."16";
                            ProductionOutLine."17" := AssoRec."17";
                            ProductionOutLine."18" := AssoRec."18";
                            ProductionOutLine."19" := AssoRec."19";
                            ProductionOutLine."20" := AssoRec."20";
                            ProductionOutLine."21" := AssoRec."21";
                            ProductionOutLine."22" := AssoRec."22";
                            ProductionOutLine."23" := AssoRec."23";
                            ProductionOutLine."24" := AssoRec."24";
                            ProductionOutLine."25" := AssoRec."25";
                            ProductionOutLine."26" := AssoRec."26";
                            ProductionOutLine."27" := AssoRec."27";
                            ProductionOutLine."28" := AssoRec."28";
                            ProductionOutLine."29" := AssoRec."29";
                            ProductionOutLine."30" := AssoRec."30";
                            ProductionOutLine."31" := AssoRec."31";
                            ProductionOutLine."32" := AssoRec."32";
                            ProductionOutLine."33" := AssoRec."33";
                            ProductionOutLine."34" := AssoRec."34";
                            ProductionOutLine."35" := AssoRec."35";
                            ProductionOutLine."36" := AssoRec."36";
                            ProductionOutLine."37" := AssoRec."37";
                            ProductionOutLine."38" := AssoRec."38";
                            ProductionOutLine."39" := AssoRec."39";
                            ProductionOutLine."40" := AssoRec."40";
                            ProductionOutLine."41" := AssoRec."41";
                            ProductionOutLine."42" := AssoRec."42";
                            ProductionOutLine."43" := AssoRec."43";
                            ProductionOutLine."44" := AssoRec."44";
                            ProductionOutLine."45" := AssoRec."45";
                            ProductionOutLine."46" := AssoRec."46";
                            ProductionOutLine."47" := AssoRec."47";
                            ProductionOutLine."48" := AssoRec."48";
                            ProductionOutLine."49" := AssoRec."49";
                            ProductionOutLine."50" := AssoRec."50";
                            ProductionOutLine."51" := AssoRec."51";
                            ProductionOutLine."52" := AssoRec."52";
                            ProductionOutLine."53" := AssoRec."53";
                            ProductionOutLine."54" := AssoRec."54";
                            ProductionOutLine."55" := AssoRec."55";
                            ProductionOutLine."56" := AssoRec."56";
                            ProductionOutLine."57" := AssoRec."57";
                            ProductionOutLine."58" := AssoRec."58";
                            ProductionOutLine."59" := AssoRec."59";
                            ProductionOutLine."60" := AssoRec."60";
                            ProductionOutLine."61" := AssoRec."61";
                            ProductionOutLine."62" := AssoRec."62";
                            ProductionOutLine."63" := AssoRec."63";
                            ProductionOutLine."64" := AssoRec."64";

                        end
                        else begin

                            ProductionOutLine."1" := '0';
                            ProductionOutLine."2" := '0';
                            ProductionOutLine."3" := '0';
                            ProductionOutLine."4" := '0';
                            ProductionOutLine."5" := '0';
                            ProductionOutLine."6" := '0';
                            ProductionOutLine."7" := '0';
                            ProductionOutLine."8" := '0';
                            ProductionOutLine."9" := '0';
                            ProductionOutLine."10" := '0';
                            ProductionOutLine."11" := '0';
                            ProductionOutLine."12" := '0';
                            ProductionOutLine."13" := '0';
                            ProductionOutLine."14" := '0';
                            ProductionOutLine."15" := '0';
                            ProductionOutLine."16" := '0';
                            ProductionOutLine."17" := '0';
                            ProductionOutLine."18" := '0';
                            ProductionOutLine."19" := '0';
                            ProductionOutLine."20" := '0';
                            ProductionOutLine."21" := '0';
                            ProductionOutLine."22" := '0';
                            ProductionOutLine."23" := '0';
                            ProductionOutLine."24" := '0';
                            ProductionOutLine."25" := '0';
                            ProductionOutLine."26" := '0';
                            ProductionOutLine."27" := '0';
                            ProductionOutLine."28" := '0';
                            ProductionOutLine."29" := '0';
                            ProductionOutLine."30" := '0';
                            ProductionOutLine."31" := '0';
                            ProductionOutLine."32" := '0';
                            ProductionOutLine."33" := '0';
                            ProductionOutLine."34" := '0';
                            ProductionOutLine."35" := '0';
                            ProductionOutLine."36" := '0';
                            ProductionOutLine."37" := '0';
                            ProductionOutLine."38" := '0';
                            ProductionOutLine."39" := '0';
                            ProductionOutLine."40" := '0';
                            ProductionOutLine."41" := '0';
                            ProductionOutLine."42" := '0';
                            ProductionOutLine."43" := '0';
                            ProductionOutLine."44" := '0';
                            ProductionOutLine."45" := '0';
                            ProductionOutLine."46" := '0';
                            ProductionOutLine."47" := '0';
                            ProductionOutLine."48" := '0';
                            ProductionOutLine."49" := '0';
                            ProductionOutLine."50" := '0';
                            ProductionOutLine."51" := '0';
                            ProductionOutLine."52" := '0';
                            ProductionOutLine."53" := '0';
                            ProductionOutLine."54" := '0';
                            ProductionOutLine."55" := '0';
                            ProductionOutLine."56" := '0';
                            ProductionOutLine."57" := '0';
                            ProductionOutLine."58" := '0';
                            ProductionOutLine."59" := '0';
                            ProductionOutLine."60" := '0';
                            ProductionOutLine."61" := '0';
                            ProductionOutLine."62" := '0';
                            ProductionOutLine."63" := '0';
                            ProductionOutLine."64" := '0';

                        end;

                        ProductionOutLine."Created User" := UserId;
                        ProductionOutLine."Created Date" := WorkDate();
                        ProductionOutLine.Insert();

                    end;
                until AssoRec.Next() = 0;
            end;
        end;
    end;


    var
        EditableGB: Boolean;
}