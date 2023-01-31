page 50355 "Daily Sewing In/Out Card"
{
    PageType = Card;
    SourceTable = ProductionOutHeader;
    Caption = 'Daily Sewing In/Out';

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
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        rec.Type := rec.Type::Saw;

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

                field("Resource Name"; rec."Resource Name")
                {
                    ApplicationArea = All;
                    Caption = 'Section';
                    ShowMandatory = true;

                    trigger OnLookup(var texts: text): Boolean
                    var
                        UserSetupRec: Record "User Setup";
                        WorkCentrRec: Record "Work Center";
                    begin
                        //Mihiranga 2022/12/14
                        UserSetupRec.Get(UserId);
                        WorkCentrRec.Reset();
                        WorkCentrRec.SetFilter(WorkCentrRec."Planning Line", '=%1', true);
                        WorkCentrRec.SetRange("Factory No.", UserSetupRec."Factory Code");
                        WorkCentrRec.FindSet();

                        if Page.RunModal(51159, WorkCentrRec) = Action::LookupOK then begin
                            Rec."Resource No." := WorkCentrRec."No.";
                            Rec."Resource Name" := WorkCentrRec.Name;
                            Rec."Factory Code" := WorkCentrRec."Factory No.";
                            Rec."Factory Name" := WorkCentrRec."Factory Name";
                        end;
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
            }

            group("Input Style Detail")
            {
                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Input Style';

                    trigger OnLookup(var text: Text): Boolean
                    var
                        StyleMasterRec: Record "Style Master";
                        NavProdDetRec: Record "NavApp Prod Plans Details";//not navapplanning line
                        Users: Record "User Setup";
                        Factory: Code[20];
                    begin

                        Users.Reset();
                        Users.SetRange("User ID", UserId());
                        Users.FindSet();
                        if Users."Factory Code" = '' then
                            Error('Factory is not setup for the user : %1 in User Setup. Cannot proceed.', UserId);

                        NavProdDetRec.Reset();
                        //NavProdDetRec.SetRange("Factory No.", Users."Factory Code");
                        NavProdDetRec.SetRange("Resource No.", rec."Resource No.");
                        NavProdDetRec.SetFilter(PlanDate, '%1..%2', rec."Prod Date", rec."Prod Date" + 3);
                        if not NavProdDetRec.FindSet() then
                            Error('Cannot find planning details');

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
                    Caption = 'Input Lot No';

                    trigger OnLookup(var text: Text): Boolean
                    var
                        StyleMasterRec: Record "Style Master PO";
                        NavAppProdPlansDetRec: Record "NavApp Prod Plans Details";
                        Users: Record "User Setup";
                    begin

                        // StyleMasterRec.Reset();
                        // StyleMasterRec.SetRange("Style No.", "Style No.");

                        Users.Reset();
                        Users.SetRange("User ID", UserId());
                        Users.FindSet();

                        NavAppProdPlansDetRec.Reset();
                        //NavAppProdPlansDetRec.SetRange("Factory No.", Users."Factory Code");
                        NavAppProdPlansDetRec.SetRange("Resource No.", rec."Resource No.");
                        NavAppProdPlansDetRec.SetRange("Style No.", rec."Style No.");
                        NavAppProdPlansDetRec.SetFilter(PlanDate, '%1', rec."Prod Date");
                        if not NavAppProdPlansDetRec.FindSet() then
                            Error('Cannot find planning details');

                        if Page.RunModal(50519, NavAppProdPlansDetRec) = Action::LookupOK then begin
                            rec."PO No" := NavAppProdPlansDetRec."PO No.";
                            rec."Lot No." := NavAppProdPlansDetRec."lot No.";
                        end;

                        GridHeader_Insert();

                        //Get and Set Line No
                        NavAppProdPlansDetRec.Reset();
                        NavAppProdPlansDetRec.SetRange("Style No.", rec."Style No.");
                        NavAppProdPlansDetRec.SetRange("Lot No.", rec."Lot No.");
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
                    Caption = 'Input PO No';
                }

                field("Input Qty"; rec."Input Qty")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        StyleMasterPORec: Record "Style Master PO";
                    begin

                        //Check Input qty with cutting qty
                        StyleMasterPORec.Reset();
                        StyleMasterPORec.SetRange("Style No.", rec."Style No.");
                        StyleMasterPORec.SetRange("Lot No.", rec."Lot No.");
                        StyleMasterPORec.FindSet();

                        if rec."Input Qty" > StyleMasterPORec."Cut Out Qty" then
                            Error('Input quantity is greater than total cut quantity.');

                        CurrPage.Update();
                    end;
                }
            }

            group("Color/Size Input Detail")
            {
                part(Input; DailyCuttingOutListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No."), Type = field(Type), In_Out = filter('IN');
                }
            }

            group("Input PO Detail")
            {
                part(MyFactBoxInput; "Style Master PO Prod ListPart")
                {
                    ApplicationArea = All;
                    SubPageLink = "Style No." = FIELD("Style No."), "Lot No." = field("Lot No.");
                    Caption = ' ';
                    Editable = false;
                }
            }

            group("Output Style Detail")
            {
                field("Out Style Name"; rec."Out Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Output Style Name';

                    trigger OnLookup(var text: Text): Boolean
                    var
                        StyleMasterRec: Record "Style Master";
                        NavProdDetRec: Record "NavApp Prod Plans Details";
                        Users: Record "User Setup";
                        Factory: Code[20];
                    begin

                        Users.Reset();
                        Users.SetRange("User ID", UserId());
                        Users.FindSet();
                        if Users."Factory Code" = '' then
                            Error('Factory is not setup for the user : %1 in User Setup. Cannot proceed.', UserId);

                        NavProdDetRec.Reset();
                        //NavProdDetRec.SetRange("Factory No.", Users."Factory Code");
                        NavProdDetRec.SetRange("Resource No.", rec."Resource No.");
                        NavProdDetRec.SetFilter(PlanDate, '=%1', rec."Prod Date");
                        if not NavProdDetRec.FindSet() then
                            Error('Cannot find planning details');

                        if Page.RunModal(50511, NavProdDetRec) = Action::LookupOK then begin
                            rec."Out Style No." := NavProdDetRec."Style No.";

                            StyleMasterRec.Reset();
                            StyleMasterRec.get(rec."Out Style No.");
                            rec."Out Style Name" := StyleMasterRec."Style No.";
                        end;
                    end;
                }

                field("Out Style No."; rec."Out Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'Output Style No';
                    Editable = false;
                }

                field("Out Lot No."; rec."Out Lot No.")
                {
                    ApplicationArea = All;

                    Caption = 'Output Lot No';

                    trigger OnLookup(var text: Text): Boolean
                    var
                        StyleMasterRec: Record "Style Master PO";
                        NavAppProdPlansDetRec: Record "NavApp Prod Plans Details";
                        Users: Record "User Setup";
                    begin

                        Users.Reset();
                        Users.SetRange("User ID", UserId());
                        Users.FindSet();

                        NavAppProdPlansDetRec.Reset();
                        //NavAppProdPlansDetRec.SetRange("Factory No.", Users."Factory Code");
                        NavAppProdPlansDetRec.SetRange("Resource No.", rec."Resource No.");
                        NavAppProdPlansDetRec.SetRange("Style No.", rec."Style No.");
                        NavAppProdPlansDetRec.SetFilter(PlanDate, '%1', rec."Prod Date");
                        if not NavAppProdPlansDetRec.FindSet() then
                            Error('Cannot find planning details');

                        if Page.RunModal(50519, NavAppProdPlansDetRec) = Action::LookupOK then begin
                            rec."OUT PO No" := NavAppProdPlansDetRec."PO No.";
                            rec."Out Lot No." := NavAppProdPlansDetRec."lot No.";
                        end;

                        GridHeader_Insert();

                        //Get and Set Line No
                        NavAppProdPlansDetRec.Reset();
                        NavAppProdPlansDetRec.SetRange("Style No.", rec."Out Style No.");
                        NavAppProdPlansDetRec.SetRange("Lot No.", rec."Out Lot No.");
                        NavAppProdPlansDetRec.SetRange(PlanDate, rec."Prod Date");
                        NavAppProdPlansDetRec.SetRange("Resource No.", rec."Resource No.");

                        if NavAppProdPlansDetRec.FindSet() then
                            rec."Ref Line No." := NavAppProdPlansDetRec."Line No.";

                    end;
                }

                field("OUT PO No"; rec."OUT PO No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Output PO No';
                }

                field("Output Qty"; rec."Output Qty")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        //Check Input qty with cutting qty
                        if rec."Output Qty" > rec."Input Qty" then
                            Error('Output quantity is greater than the input quantity.');
                        CurrPage.Update();
                    end;
                }
            }

            group("Color/Size Output Detail")
            {
                part(Output; DailyCuttingOutListPart_SawOut)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = Type = field(Type), "No." = FIELD("No."), In_Out = const('OUT');
                }
            }

            group("Output PO Detail")
            {
                part(MyFactBoxOutput; "StyleMaster PO Prod ListPart 1")
                {
                    ApplicationArea = All;
                    SubPageLink = "Style No." = FIELD("Out Style No."), "Lot No." = field("Out Lot No.");
                    Caption = ' ';
                    Editable = false;
                }
            }

        }
    }


    actions
    {
        area(Processing)
        {
            action("Update Runtime")
            {
                ApplicationArea = All;
                Image = UpdateDescription;

                trigger OnAction()
                var
                    CodeUnitNavapp: Codeunit NavAppCodeUnit;
                begin
                    CodeUnitNavapp.Update_Runtime(rec."Out Style Name", rec."Out Style No.", 'SEWING');
                    Message('Sewing Runtime Updated');
                end;
            }
        }
    }



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

            //Check Input qty with cutting qty
            StyleMasterPORec.Reset();
            StyleMasterPORec.SetRange("Style No.", rec."Style No.");
            StyleMasterPORec.SetRange("Lot No.", rec."Lot No.");
            if StyleMasterPORec.FindSet() then begin

                if rec."Input Qty" > StyleMasterPORec."Cut Out Qty" then begin
                    Error('Input quantity is greater than total cut quantity.');
                    exit;
                end;

                //Check Input qty with output qty
                if StyleMasterPORec."Sawing In Qty" < rec."Output Qty" then begin
                    Error('Sewing output total quantity is greater than sewing input total quantity.');
                    exit;
                end;
            end
            else
                Error('Cannot find Style : %1', rec."Style Name");


            //Line In Qty
            ProductionOutLine.Reset();
            ProductionOutLine.SetRange("No.", rec."No.");
            ProductionOutLine.SetRange(In_Out, 'IN');

            if ProductionOutLine.FindSet() then begin
                repeat
                    if ProductionOutLine."Colour No" <> '*' then
                        LineTotal_In += ProductionOutLine.Total;
                until ProductionOutLine.Next() = 0;
            end;

            if LineTotal_In <> rec."Input Qty" then begin
                Error('Input quantity should match color/size total quantity.');
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

                        //Input
                        LineNo += 1;
                        ProductionOutLine.Init();
                        ProductionOutLine."No." := rec."No.";
                        ProductionOutLine."Line No." := LineNo;
                        ProductionOutLine."Colour No" := AssoRec."Colour No";
                        ProductionOutLine."Colour Name" := AssoRec."Colour Name";
                        ProductionOutLine.Type := rec.Type;
                        ProductionOutLine.In_Out := 'IN';
                        ProductionOutLine.Total := 0;
                        ProductionOutLine."Style Name" := AssoRec."Style Name";
                        ProductionOutLine."Style No." := AssoRec."Style No.";
                        ProductionOutLine."PO No." := AssoRec."PO No.";
                        ProductionOutLine."Lot No." := AssoRec."Lot No.";

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
                        ProductionOutLine."Lot No." := AssoRec."Lot No.";

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
        NavAppCodeUnit.Delete_Prod_Records(rec."No.", rec."Style No.", rec."Lot No.", 'IN', 'Saw', rec.Type::Saw);
        NavAppCodeUnit.Delete_Prod_Records(rec."No.", rec."Style No.", rec."Lot No.", 'OUT', 'Saw', rec.Type::Saw);
    end;

    var
        UserSetupRec: Record "User Setup";

}