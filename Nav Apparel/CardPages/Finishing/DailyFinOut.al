page 50364 "Daily Finishing Out Card"
{
    PageType = Card;
    SourceTable = ProductionOutHeader;
    Caption = 'Daily Finishing Out';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Prod Date"; rec."Prod Date")
                {
                    ApplicationArea = All;
                    Caption = 'Production Date';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                    begin
                        rec.Type := rec.Type::Fin;
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
                    begin

                        UserSetupRec.Get(UserId);
                        WorkCentrRec.Reset();
                        WorkCentrRec.SetFilter(WorkCentrRec."Planning Line", '=%1', true);
                        WorkCentrRec.SetRange("Factory No.", UserSetupRec."Factory Code");
                        WorkCentrRec.FindSet();


                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if Page.RunModal(51159, WorkCentrRec) = Action::LookupOK then begin
                            Rec."Resource No." := WorkCentrRec."No.";
                            rec."Resource Name" := WorkCentrRec.Name;
                            Rec."Factory Code" := WorkCentrRec."Factory No.";
                            Rec."Factory Name" := WorkCentrRec."Factory Name";
                        end;
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
                            Rec."Resource No." := WorkCenterRec."No.";
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
                        StyleMasterRec: Record "Style Master";
                        ProdOutHeaderRec: Record "ProductionOutHeader";
                        Users: Record "User Setup";
                        Factory: Code[20];
                    begin

                        Users.Reset();
                        Users.SetRange("User ID", UserId());
                        Users.FindSet();

                        ProdOutHeaderRec.Reset();
                        ProdOutHeaderRec.SetFilter(Type, '=%1', 2);
                        ProdOutHeaderRec.SetRange("Resource No.", rec."Resource No.");
                        ProdOutHeaderRec.SetFilter("Prod Date", '%1..%2', rec."Prod Date" - 3, rec."Prod Date");
                        ProdOutHeaderRec.FindSet();

                        if Page.RunModal(50758, ProdOutHeaderRec) = Action::LookupOK then begin
                            rec."Style No." := ProdOutHeaderRec."Style No.";
                            StyleMasterRec.Reset();
                            StyleMasterRec.get(rec."Style No.");
                            rec."Style Name" := StyleMasterRec."Style No.";
                        end;
                    end;
                }

                field("Lot No."; rec."Lot No.")
                {
                    Caption = 'Lot No';
                    ShowMandatory = true;
                    ApplicationArea = All;

                    trigger OnLookup(var text: Text): Boolean
                    var
                        StyleMasterRec: Record "Style Master PO";
                        NavAppProdPlansDetRec: Record "NavApp Prod Plans Details";
                    begin

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", rec."Style No.");

                        if Page.RunModal(51068, StyleMasterRec) = Action::LookupOK then begin
                            rec."PO No" := StyleMasterRec."PO No.";
                            rec."Lot No." := StyleMasterRec."Lot No.";
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

                    end;

                }

                field("PO No"; rec."PO No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Output Qty"; rec."Output Qty")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        StyleMasterPORec: Record "Style Master PO";
                    begin
                        //Check Input qty with sewing out qty
                        StyleMasterPORec.Reset();
                        StyleMasterPORec.SetRange("Style No.", rec."Style No.");
                        StyleMasterPORec.SetRange("Lot No.", rec."Lot No.");
                        StyleMasterPORec.FindSet();

                        if rec."Output Qty" > StyleMasterPORec."Wash Out Qty" then
                            Error('Output quantity is greater than total washing out quantity.');

                        CurrPage.Update();
                    end;
                }
            }

            group("Color/Size Output Detail")
            {
                part(Output; DailyCuttingOutListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = Type = field(Type), "No." = FIELD("No."), In_Out = const('OUT');
                }
            }

            group("PO Detail")
            {
                part(MyFactBox; "Style Master PO Prod ListPart")
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
    //             begin
    //                 CodeUnitNavapp.Update_Runtime(rec."Style Name", rec."Style No.", 'FINISHING');
    //                 Message('Finishing Runtime Updated');
    //             end;
    //         }
    //     }
    // }


    trigger OnInit()
    var
    begin
        rec.Type := rec.Type::Fin;
    end;


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ProductionOutLine: Record ProductionOutLine;
        StyleMasterPORec: Record "Style Master PO";
        LineTotal_In: BigInteger;
        LineTotal_Out: BigInteger;
    begin

        if (rec."Style No." <> '') and (rec."Lot No." <> '') then begin

            LineTotal_In := 0;
            LineTotal_Out := 0;

            //Check Input qty with Sawing out qty
            StyleMasterPORec.Reset();
            StyleMasterPORec.SetRange("Style No.", rec."Style No.");
            StyleMasterPORec.SetRange("Lot No.", rec."Lot No.");
            StyleMasterPORec.FindSet();

            if rec."Output Qty" > StyleMasterPORec."Wash Out Qty" then begin
                Error('Output quantity is greater than wash out quantity.');
                exit;
            end;


            //Line Out Qty
            ProductionOutLine.Reset();
            ProductionOutLine.SetRange("No.", rec."No.");
            ProductionOutLine.SetRange(In_Out, 'OUT');

            if ProductionOutLine.FindSet() then begin
                repeat
                    if ProductionOutLine."Colour No" <> '*' then
                        LineTotal_Out += ProductionOutLine.Total;
                until ProductionOutLine.Next() = 0;
            end;

            if LineTotal_Out <> rec."Output Qty" then begin
                Error('Output quantity should match color/size total quantity.');
                exit;
            end;
        end;

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

                        //Output
                        LineNo += 1;
                        ProductionOutLine.Init();
                        ProductionOutLine."No." := rec."No.";
                        ProductionOutLine."Line No." := LineNo;
                        ProductionOutLine."Colour No" := AssoRec."Colour No";
                        ProductionOutLine."Colour Name" := AssoRec."Colour Name";
                        ProductionOutLine.Type := rec.Type;
                        ProductionOutLine.In_Out := 'OUT';
                        ProductionOutLine.Total := 0;
                        ProductionOutLine."Style No." := AssoRec."Style No.";
                        ProductionOutLine."Style Name" := AssoRec."Style Name";
                        ProductionOutLine."PO No." := AssoRec."PO No.";
                        ProductionOutLine."lot No." := AssoRec."lot No.";

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

    trigger OnDeleteRecord(): Boolean
    var
        NavAppCodeUnit: Codeunit NavAppCodeUnit;
    begin
        NavAppCodeUnit.Delete_Prod_Records(rec."No.", rec."Style No.", rec."Lot No.", 'OUT', 'Fin', rec.Type::Fin);
    end;

}