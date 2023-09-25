page 50515 "Hourly Production Card"
{
    PageType = Card;
    UsageCategory = Tasks;
    ApplicationArea = all;
    SourceTable = "Hourly Production Master";
    Caption = 'Hourly Production';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = EditableGB;
                field("Prod Date"; rec."Prod Date")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";

                        HourlyRec: Record "Hourly Production Master";
                        HourlyLinesRec: Record "Hourly Production Lines";
                    begin
                        //Validate Production Line date and Header date
                        HourlyRec.Reset();
                        HourlyLinesRec.Reset();
                        HourlyRec.SetRange("No.", Rec."No.");
                        if HourlyRec.FindSet() then begin
                            HourlyLinesRec.SetRange("No.", HourlyRec."No.");
                            HourlyLinesRec.SetFilter(Item, '=%1', 'PASS PCS');
                            if HourlyLinesRec.FindSet() then begin
                                if Rec."Prod Date" <> HourlyLinesRec."Prod Date" then
                                    Error('Please Check Production Date');
                            end;
                        end;

                        //Validate Date

                        if rec."Prod Date" < WorkDate() then
                            Error('Cannot enter production for previous dates.');


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

                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Factory';

                    trigger OnLookup(var text: Text): Boolean
                    var
                        LocationRec: Record "Location";
                        Users: Record "User Setup";
                        HourlyRec: Record "Hourly Production Master";
                    begin
                        HourlyRec.Reset();
                        HourlyRec.FindSet();
                        Rec.Type := HourlyRec.Type::Sewing;

                        Users.Reset();
                        Users.SetRange("User ID", UserId());
                        Users.FindSet();

                        LocationRec.Reset();
                        LocationRec.SetRange("code", Users."Factory Code");

                        if Page.RunModal(50517, LocationRec) = Action::LookupOK then begin
                            rec."Factory No." := LocationRec.Code;
                            rec."Factory Name" := LocationRec.Name;

                            HourlyRec.Reset();
                            HourlyRec.SetRange("Prod Date", Rec."Prod Date");
                            HourlyRec.SetRange("Factory Name", Rec."Factory Name");
                            HourlyRec.SetRange(Type, Rec.Type);
                            if HourlyRec.FindFirst() then
                                Error('Record already Exist');
                        end;
                    end;

                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                //Mihiranga 2023/03/24
                // field(LineNO; LineNO)
                // { }
                // field(DocumentNo; DocumentNo)
                // { }

            }

            group(" ")
            {
                Editable = EditableGB;
                part(HourlyProductionListPart; HourlyProductionListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = field("No.");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Filter)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    StartTime: Time;
                    LCH: Decimal;
                    Time: Time;
                    WorkingHrs: Decimal;
                    ResCapacityEntryRec: Record "Calendar Entry";
                    CheckValue: Decimal;
                    TotNavaHours: Decimal;
                    TimeVariable: Time;
                    StyleLC1: Code[20];
                    LineLC1: Code[20];
                    StyleLC: Code[20];
                    LineLC: Code[20];
                    NavAppProdRec: Record "NavApp Prod Plans Details";
                    DayTarget: Decimal;
                    HourlyProdLines3Rec: Record "Hourly Production Lines";
                    HourlyProdLines2Rec: Record "Hourly Production Lines";
                    HourlyProdLinesRec: Record "Hourly Production Lines";
                    HourlyProdLines1Rec: Record "Hourly Production Lines";
                    NavAppProdPlanLinesRec: Record "NavApp Prod Plans Details";
                    WorkCenrterRec: Record "Work Center";
                    ProductionOutHeaderRec: Record ProductionOutHeader;
                    HourlyLineTempRec: Record "Hourly Production Lines Temp";
                    i: Integer;
                    LineNo: Integer;
                    StyleNo: code[20];
                    ResourceNo: code[20];
                begin

                    if (Dialog.CONFIRM('"Hourly Production" will erase old records. Do you want to continue?', true) = true) then begin

                        //Delete Temp table Records
                        HourlyLineTempRec.Reset();
                        HourlyLineTempRec.SetRange("No.", Rec."No.");
                        HourlyLineTempRec.SetRange(Type, HourlyLineTempRec.Type::Sewing);
                        if HourlyLineTempRec.FindSet() then
                            HourlyLineTempRec.DeleteAll();

                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", Rec."No.");
                        HourlyProdLinesRec.SetRange(Type, HourlyProdLinesRec.Type::Sewing);
                        if HourlyProdLinesRec.FindSet() then begin
                            repeat
                                HourlyLineTempRec.Init();
                                HourlyLineTempRec."No." := HourlyProdLinesRec."No.";
                                HourlyLineTempRec."Prod Date" := HourlyProdLinesRec."Prod Date";
                                HourlyProdLinesRec."Factory No." := HourlyProdLinesRec."Factory No.";
                                HourlyProdLinesRec.Type := HourlyProdLinesRec.Type;
                                HourlyLineTempRec."Work Center No." := HourlyProdLinesRec."Work Center No.";
                                HourlyLineTempRec."Work Center Name" := HourlyProdLinesRec."Work Center Name";
                                HourlyLineTempRec.Item := HourlyProdLinesRec.Item;
                                HourlyLineTempRec."Hour 01" := HourlyProdLinesRec."Hour 01";
                                HourlyLineTempRec."Hour 02" := HourlyProdLinesRec."Hour 02";
                                HourlyLineTempRec."Hour 03" := HourlyProdLinesRec."Hour 03";
                                HourlyLineTempRec."Hour 04" := HourlyProdLinesRec."Hour 04";
                                HourlyLineTempRec."Hour 05" := HourlyProdLinesRec."Hour 05";
                                HourlyLineTempRec."Hour 06" := HourlyProdLinesRec."Hour 06";
                                HourlyLineTempRec."Hour 07" := HourlyProdLinesRec."Hour 07";
                                HourlyLineTempRec."Hour 08" := HourlyProdLinesRec."Hour 08";
                                HourlyLineTempRec."Hour 09" := HourlyProdLinesRec."Hour 09";
                                HourlyLineTempRec."Hour 10" := HourlyProdLinesRec."Hour 10";
                                HourlyLineTempRec."Hour 11" := HourlyProdLinesRec."Hour 11";
                                HourlyLineTempRec."Hour 12" := HourlyProdLinesRec."Hour 12";
                                HourlyLineTempRec."Hour 13" := HourlyProdLinesRec."Hour 13";
                                HourlyLineTempRec.Total := HourlyProdLinesRec.Total;
                                HourlyLineTempRec."Style No." := HourlyProdLinesRec."Style No.";
                                HourlyLineTempRec."Style Name" := HourlyProdLinesRec."Style Name";
                                HourlyLineTempRec."Line No." := HourlyProdLinesRec."Line No.";
                                HourlyLineTempRec.Insert();
                            until HourlyProdLinesRec.Next() = 0;
                            CurrPage.Update();
                        end;



                        //Delete old records
                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", Rec."No.");
                        HourlyProdLinesRec.SetRange(Type, HourlyProdLinesRec.Type::Sewing);
                        if HourlyProdLinesRec.FindSet() then
                            HourlyProdLinesRec.DeleteAll();

                        CurrPage.Update();

                        //Get max lineno
                        HourlyProdLines1Rec.Reset();
                        HourlyProdLines1Rec.SetRange("No.", rec."No.");

                        if HourlyProdLines1Rec.FindLast() then
                            LineNo := HourlyProdLines1Rec."Line No.";

                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("Prod Date", rec."Prod Date");
                        HourlyProdLinesRec.SetRange("Factory No.", rec."Factory No.");
                        HourlyProdLinesRec.SetRange(Type, rec.Type);
                        HourlyProdLinesRec.SetFilter("No.", '<>%1', rec."No.");

                        if not HourlyProdLinesRec.FindSet() then begin

                            NavAppProdPlanLinesRec.Reset();
                            NavAppProdPlanLinesRec.SetRange("PlanDate", rec."Prod Date");
                            NavAppProdPlanLinesRec.SetRange("Factory No.", rec."Factory No.");
                            NavAppProdPlanLinesRec.SetCurrentKey("Style No.", "Resource No.");
                            NavAppProdPlanLinesRec.Ascending(true);

                            if NavAppProdPlanLinesRec.FindSet() then begin

                                repeat
                                    WorkCenrterRec.Reset();
                                    WorkCenrterRec.SetRange("No.", NavAppProdPlanLinesRec."Resource No.");
                                    if WorkCenrterRec.FindSet() then begin

                                        if (StyleNo <> NavAppProdPlanLinesRec."Style No.") or (ResourceNo <> NavAppProdPlanLinesRec."Resource No.") then begin

                                            // HourlyProdLines3Rec.Reset();
                                            // HourlyProdLines3Rec.SetRange("No.", HourlyProdLinesRec."No.");
                                            // HourlyProdLines3Rec.SetRange("Style No.", HourlyProdLinesRec."Style No.");
                                            // HourlyProdLines3Rec.SetRange("Factory No.", HourlyProdLinesRec."Factory No.");
                                            // if not HourlyProdLines3Rec.FindSet() then begin
                                            LineNo += 1;
                                            HourlyProdLinesRec.Init();
                                            HourlyProdLinesRec."No." := rec."No.";
                                            HourlyProdLinesRec."Line No." := LineNo;
                                            HourlyProdLinesRec."Style Name" := NavAppProdPlanLinesRec."Style Name";
                                            HourlyProdLinesRec."Style No." := NavAppProdPlanLinesRec."Style No.";
                                            HourlyProdLinesRec."Work Center Seq No" := WorkCenrterRec."Work Center Seq No";
                                            HourlyProdLinesRec.Insert();
                                            StyleNo := NavAppProdPlanLinesRec."Style No.";
                                            ResourceNo := NavAppProdPlanLinesRec."Resource No.";

                                            // end;
                                        end;
                                        //Mihiranga 2023/03/29
                                        HourlyProdLines1Rec.Reset();
                                        HourlyProdLines1Rec.SetRange("No.", rec."No.");
                                        HourlyProdLines1Rec.SetRange("Prod Date", rec."Prod Date");
                                        HourlyProdLines1Rec.SetRange("Factory No.", rec."Factory No.");
                                        HourlyProdLines1Rec.SetFilter(Item, '=%1', 'PASS PCS');
                                        HourlyProdLines1Rec.SetRange("Style No.", NavAppProdPlanLinesRec."Style No.");
                                        HourlyProdLines1Rec.SetRange("Work Center Name", NavAppProdPlanLinesRec."Resource No.");
                                        if HourlyProdLines1Rec.FindSet() then begin
                                            //Do nothing when record found
                                        end
                                        else begin

                                            LineNo += 1;

                                            HourlyProdLinesRec.Init();
                                            HourlyProdLinesRec."No." := rec."No.";
                                            HourlyProdLinesRec."Line No." := LineNo;
                                            HourlyProdLinesRec."Factory No." := rec."Factory No.";
                                            HourlyProdLinesRec."Prod Date" := rec."Prod Date";
                                            HourlyProdLinesRec.Type := rec.Type;
                                            HourlyProdLinesRec."Work Center No." := NavAppProdPlanLinesRec."Resource No.";
                                            HourlyProdLinesRec."Style No." := NavAppProdPlanLinesRec."Style No.";
                                            HourlyProdLinesRec."Work Center Name" := WorkCenrterRec.Name;
                                            HourlyProdLinesRec."Work Center Seq No" := WorkCenrterRec."Work Center Seq No";
                                            HourlyProdLinesRec.Item := 'PASS PCS';
                                            HourlyProdLinesRec.Insert();

                                            LineNo += 1;

                                            HourlyProdLinesRec.Init();
                                            HourlyProdLinesRec."No." := rec."No.";
                                            HourlyProdLinesRec."Line No." := LineNo;
                                            HourlyProdLinesRec."Factory No." := rec."Factory No.";
                                            HourlyProdLinesRec."Prod Date" := rec."Prod Date";
                                            HourlyProdLinesRec.Type := rec.Type;
                                            HourlyProdLinesRec."Work Center No." := NavAppProdPlanLinesRec."Resource No.";
                                            HourlyProdLinesRec."Style No." := NavAppProdPlanLinesRec."Style No.";
                                            HourlyProdLinesRec."Work Center Name" := WorkCenrterRec.Name;
                                            HourlyProdLinesRec."Work Center Seq No" := WorkCenrterRec."Work Center Seq No";
                                            HourlyProdLinesRec.Item := 'DEFECT PCS';
                                            HourlyProdLinesRec.Insert();

                                            LineNo += 1;

                                            HourlyProdLinesRec.Init();
                                            HourlyProdLinesRec."No." := rec."No.";
                                            HourlyProdLinesRec."Line No." := LineNo;
                                            HourlyProdLinesRec."Factory No." := rec."Factory No.";
                                            HourlyProdLinesRec."Prod Date" := rec."Prod Date";
                                            HourlyProdLinesRec.Type := rec.Type;
                                            HourlyProdLinesRec."Style No." := NavAppProdPlanLinesRec."Style No.";
                                            HourlyProdLinesRec."Work Center No." := NavAppProdPlanLinesRec."Resource No.";
                                            HourlyProdLinesRec."Work Center Name" := WorkCenrterRec.Name;
                                            HourlyProdLinesRec."Work Center Seq No" := WorkCenrterRec."Work Center Seq No";
                                            HourlyProdLinesRec.Item := 'DHU';
                                            HourlyProdLinesRec.Insert();
                                        end;
                                    end;
                                until NavAppProdPlanLinesRec.Next() = 0;

                                HourlyProdLines2Rec.Reset();
                                HourlyProdLines2Rec.SetRange("No.", HourlyProdLinesRec."No.");
                                HourlyProdLines2Rec.SetRange("Prod Date", HourlyProdLinesRec."Prod Date");
                                HourlyProdLines2Rec.SetRange("Factory No.", HourlyProdLinesRec."Factory No.");
                                HourlyProdLines2Rec.SetFilter("Style Name", '=%1', 'PASS PCS (Total)');
                                if not HourlyProdLines2Rec.FindSet() then begin

                                    //Add Sub totals
                                    LineNo += 1;
                                    HourlyProdLinesRec.Init();
                                    HourlyProdLinesRec."No." := rec."No.";
                                    HourlyProdLinesRec."Line No." := LineNo;
                                    HourlyProdLinesRec."Style Name" := 'PASS PCS (Total)';
                                    HourlyProdLinesRec."Work Center Seq No" := 100;
                                    HourlyProdLinesRec.Insert();

                                    LineNo += 1;
                                    HourlyProdLinesRec.Init();
                                    HourlyProdLinesRec."No." := rec."No.";
                                    HourlyProdLinesRec."Line No." := LineNo;
                                    HourlyProdLinesRec."Style Name" := 'DEFECT PCS (Total)';
                                    HourlyProdLinesRec."Work Center Seq No" := 101;
                                    HourlyProdLinesRec.Insert();

                                    LineNo += 1;
                                    HourlyProdLinesRec.Init();
                                    HourlyProdLinesRec."No." := rec."No.";
                                    HourlyProdLinesRec."Line No." := LineNo;
                                    HourlyProdLinesRec."Style Name" := 'DHU (Total)';
                                    HourlyProdLinesRec."Work Center Seq No" := 102;
                                    HourlyProdLinesRec.Insert();

                                end;
                            end;
                        end
                        else
                            Message('Another entry with same Date/Factory/Type exists.');

                        // NavAppProdRec.Reset();
                        // NavAppProdRec.SetRange(PlanDate, Rec."Prod Date");
                        // NavAppProdRec.SetRange("Factory No.", Rec."Factory No.");
                        // if NavAppProdRec.FindSet() then begin
                        //     repeat

                        //     until NavAppProdRec.Next() = 0;
                        // end;



                        HourlyProdLines1Rec.Reset();
                        HourlyProdLines1Rec.SetRange("No.", Rec."No.");
                        HourlyProdLines1Rec.SetRange(Type, HourlyProdLines1Rec.Type::Sewing);
                        if HourlyProdLines1Rec.FindSet() then begin
                            repeat
                                HourlyProdLinesRec.Reset();
                                HourlyProdLinesRec.SetRange("No.", HourlyProdLines1Rec."No.");
                                HourlyProdLinesRec.SetRange(Type, HourlyProdLinesRec.Type::Sewing);
                                HourlyProdLinesRec.SetFilter(Item, '=%1', 'PASS PCS');
                                if HourlyProdLinesRec.FindSet() then begin
                                    repeat
                                        HourlyLineTempRec.Reset();
                                        HourlyLineTempRec.SetRange("No.", HourlyProdLinesRec."No.");
                                        HourlyLineTempRec.SetRange("Style No.", HourlyProdLinesRec."Style No.");
                                        HourlyLineTempRec.SetRange("Work Center No.", HourlyProdLinesRec."Work Center No.");
                                        HourlyLineTempRec.SetFilter(Item, '=%1', 'PASS PCS');
                                        HourlyLineTempRec.SetRange(Type, HourlyLineTempRec.Type::Sewing);
                                        if HourlyLineTempRec.FindSet() then begin
                                            HourlyProdLinesRec."Hour 01" := HourlyLineTempRec."Hour 01";
                                            HourlyProdLinesRec."Hour 02" := HourlyLineTempRec."Hour 02";
                                            HourlyProdLinesRec."Hour 03" := HourlyLineTempRec."Hour 03";
                                            HourlyProdLinesRec."Hour 04" := HourlyLineTempRec."Hour 04";
                                            HourlyProdLinesRec."Hour 05" := HourlyLineTempRec."Hour 05";
                                            HourlyProdLinesRec."Hour 06" := HourlyLineTempRec."Hour 06";
                                            HourlyProdLinesRec."Hour 07" := HourlyLineTempRec."Hour 07";
                                            HourlyProdLinesRec."Hour 08" := HourlyLineTempRec."Hour 08";
                                            HourlyProdLinesRec."Hour 09" := HourlyLineTempRec."Hour 09";
                                            HourlyProdLinesRec."Hour 10" := HourlyLineTempRec."Hour 10";
                                            HourlyProdLinesRec."Hour 11" := HourlyLineTempRec."Hour 11";
                                            HourlyProdLinesRec."Hour 12" := HourlyLineTempRec."Hour 12";
                                            HourlyProdLinesRec."Hour 13" := HourlyLineTempRec."Hour 13";
                                            HourlyProdLinesRec.Total := HourlyLineTempRec.Total;
                                            HourlyProdLinesRec.Modify();
                                        end;
                                    until HourlyProdLinesRec.Next() = 0;
                                end;
                                HourlyProdLinesRec.Reset();
                                HourlyProdLinesRec.SetRange("No.", HourlyProdLines1Rec."No.");
                                HourlyProdLinesRec.SetRange(Type, HourlyProdLinesRec.Type::Sewing);
                                HourlyProdLinesRec.SetFilter(Item, '=%1', 'DEFECT PCS');
                                if HourlyProdLinesRec.FindSet() then begin
                                    repeat
                                        HourlyLineTempRec.Reset();
                                        HourlyLineTempRec.SetRange("No.", HourlyProdLinesRec."No.");
                                        HourlyLineTempRec.SetRange("Style No.", HourlyProdLinesRec."Style No.");
                                        HourlyLineTempRec.SetRange("Work Center No.", HourlyProdLinesRec."Work Center No.");
                                        HourlyLineTempRec.SetFilter(Item, '=%1', 'DEFECT PCS');
                                        HourlyLineTempRec.SetRange(Type, HourlyLineTempRec.Type::Sewing);
                                        if HourlyLineTempRec.FindSet() then begin
                                            HourlyProdLinesRec."Hour 01" := HourlyLineTempRec."Hour 01";
                                            HourlyProdLinesRec."Hour 02" := HourlyLineTempRec."Hour 02";
                                            HourlyProdLinesRec."Hour 03" := HourlyLineTempRec."Hour 03";
                                            HourlyProdLinesRec."Hour 04" := HourlyLineTempRec."Hour 04";
                                            HourlyProdLinesRec."Hour 05" := HourlyLineTempRec."Hour 05";
                                            HourlyProdLinesRec."Hour 06" := HourlyLineTempRec."Hour 06";
                                            HourlyProdLinesRec."Hour 07" := HourlyLineTempRec."Hour 07";
                                            HourlyProdLinesRec."Hour 08" := HourlyLineTempRec."Hour 08";
                                            HourlyProdLinesRec."Hour 09" := HourlyLineTempRec."Hour 09";
                                            HourlyProdLinesRec."Hour 10" := HourlyLineTempRec."Hour 10";
                                            HourlyProdLinesRec."Hour 11" := HourlyLineTempRec."Hour 11";
                                            HourlyProdLinesRec."Hour 12" := HourlyLineTempRec."Hour 12";
                                            HourlyProdLinesRec."Hour 13" := HourlyLineTempRec."Hour 13";
                                            HourlyProdLinesRec.Total := HourlyLineTempRec.Total;
                                            HourlyProdLinesRec.Modify();
                                        end;
                                    until HourlyProdLinesRec.Next() = 0;
                                end;

                                HourlyProdLinesRec.Reset();
                                HourlyProdLinesRec.SetRange("No.", HourlyProdLines1Rec."No.");
                                HourlyProdLinesRec.SetRange(Type, HourlyProdLinesRec.Type::Sewing);
                                HourlyProdLinesRec.SetFilter(Item, '=%1', 'DHU');
                                if HourlyProdLinesRec.FindSet() then begin
                                    repeat
                                        HourlyLineTempRec.Reset();
                                        HourlyLineTempRec.SetRange("No.", HourlyProdLinesRec."No.");
                                        HourlyLineTempRec.SetRange("Style No.", HourlyProdLinesRec."Style No.");
                                        HourlyLineTempRec.SetRange("Work Center No.", HourlyProdLinesRec."Work Center No.");
                                        HourlyLineTempRec.SetFilter(Item, '=%1', 'DHU');
                                        HourlyLineTempRec.SetRange(Type, HourlyLineTempRec.Type::Sewing);
                                        if HourlyLineTempRec.FindSet() then begin
                                            HourlyProdLinesRec."Hour 01" := HourlyLineTempRec."Hour 01";
                                            HourlyProdLinesRec."Hour 02" := HourlyLineTempRec."Hour 02";
                                            HourlyProdLinesRec."Hour 03" := HourlyLineTempRec."Hour 03";
                                            HourlyProdLinesRec."Hour 04" := HourlyLineTempRec."Hour 04";
                                            HourlyProdLinesRec."Hour 05" := HourlyLineTempRec."Hour 05";
                                            HourlyProdLinesRec."Hour 06" := HourlyLineTempRec."Hour 06";
                                            HourlyProdLinesRec."Hour 07" := HourlyLineTempRec."Hour 07";
                                            HourlyProdLinesRec."Hour 08" := HourlyLineTempRec."Hour 08";
                                            HourlyProdLinesRec."Hour 09" := HourlyLineTempRec."Hour 09";
                                            HourlyProdLinesRec."Hour 10" := HourlyLineTempRec."Hour 10";
                                            HourlyProdLinesRec."Hour 11" := HourlyLineTempRec."Hour 11";
                                            HourlyProdLinesRec."Hour 12" := HourlyLineTempRec."Hour 12";
                                            HourlyProdLinesRec."Hour 13" := HourlyLineTempRec."Hour 13";
                                            HourlyProdLinesRec.Total := HourlyLineTempRec.Total;
                                            HourlyProdLinesRec.Modify();
                                        end;
                                    until HourlyProdLinesRec.Next() = 0;
                                end;

                            until HourlyProdLines1Rec.Next() = 0;
                        end;
                    end;
                    CurrPage.Update();



                    HourlyProdLinesRec.Reset();
                    HourlyProdLinesRec.SetRange("No.", Rec."No.");
                    HourlyProdLinesRec.SetRange("Factory No.", Rec."Factory No.");
                    HourlyProdLinesRec.SetRange("Prod Date", Rec."Prod Date");
                    HourlyProdLinesRec.SetRange(Type, Rec.Type);
                    // HourlyProdLinesRec.SetFilter("Style Name",'=%1','PASS PCS');
                    HourlyProdLinesRec.SetCurrentKey("Work Center Seq No");
                    HourlyProdLinesRec.Ascending(true);
                    if HourlyProdLinesRec.FindSet() then begin
                        repeat
                            DayTarget := 0;
                            NavAppProdRec.Reset();
                            NavAppProdRec.SetRange(PlanDate, Rec."Prod Date");
                            NavAppProdRec.SetRange("Style No.", HourlyProdLinesRec."Style No.");
                            NavAppProdRec.SetRange("Factory No.", Rec."Factory No.");
                            NavAppProdRec.SetRange("Resource No.", HourlyProdLinesRec."Work Center No.");
                            if NavAppProdRec.FindSet() then begin
                                repeat
                                    DayTarget += NavAppProdRec.Qty;
                                until NavAppProdRec.Next() = 0;

                                if (NavAppProdRec."Style No." = StyleLC) and (NavAppProdRec."Resource No." = LineLC) then begin
                                    DayTarget := 0;
                                end;
                                StyleLC := NavAppProdRec."Style No.";
                                LineLC := NavAppProdRec."Resource No.";
                            end;
                            HourlyProdLinesRec.Target := DayTarget;
                            HourlyProdLinesRec.Modify();

                            WorkingHrs := 0;
                            ResCapacityEntryRec.Reset();
                            ResCapacityEntryRec.SETRANGE("No.", HourlyProdLinesRec."Work Center No.");
                            ResCapacityEntryRec.SETRANGE(Date, Rec."Prod Date");
                            if ResCapacityEntryRec.FindSet() then begin
                                repeat
                                    WorkingHrs += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                until ResCapacityEntryRec.Next() = 0;
                            end;

                            TotNavaHours := 0;
                            NavAppProdRec.Reset();
                            NavAppProdRec.SetRange("Resource No.", HourlyProdLinesRec."Work Center No.");
                            NavAppProdRec.SetRange("Factory No.", Rec."Factory No.");
                            NavAppProdRec.SetRange("Style No.", HourlyProdLinesRec."Style No.");
                            NavAppProdRec.SetRange(PlanDate, Rec."Prod Date");
                            if NavAppProdRec.FindSet() then begin
                                // TotNavaHours := WorkingHrs;

                                if (NavAppProdRec."Style No." = StyleLC1) and (NavAppProdRec."Resource No." = LineLC1) then begin
                                    TotNavaHours := 0;
                                end;
                                StyleLC1 := NavAppProdRec."Style No.";
                                LineLC1 := NavAppProdRec."Resource No.";

                                HourlyProdLinesRec."Target_Hour 09" := 0;
                                HourlyProdLinesRec."Target_Hour 10" := 0;

                                TimeVariable := 0T;
                                Time := 0T;
                                if NavAppProdRec."LCurve Start Time" <> 0T then
                                    Time := NavAppProdRec."LCurve Start Time" + (60 * 60 * 1000 * NavAppProdRec."LCurve Hours Per Day");

                                // if "Resource No." = 'VDL-06' then begin
                                //     Message('VDL7');
                                // end;

                                LCH := 0;
                                if NavAppProdRec."LCurve Hours Per Day" = 0 then
                                    LCH := 0;
                                if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) then
                                    LCH := 1;
                                if (NavAppProdRec."LCurve Hours Per Day" >= 1) and (NavAppProdRec."LCurve Hours Per Day" < 2) then
                                    LCH := 1;
                                if (NavAppProdRec."LCurve Hours Per Day" >= 2) and (NavAppProdRec."LCurve Hours Per Day" < 3) then
                                    LCH := 2;
                                if (NavAppProdRec."LCurve Hours Per Day" >= 3) and (NavAppProdRec."LCurve Hours Per Day" < 4) then
                                    LCH := 3;
                                if (NavAppProdRec."LCurve Hours Per Day" >= 4) and (NavAppProdRec."LCurve Hours Per Day" < 5) then
                                    LCH := 4;
                                if (NavAppProdRec."LCurve Hours Per Day" >= 5) and (NavAppProdRec."LCurve Hours Per Day" < 6) then
                                    LCH := 5;
                                if (NavAppProdRec."LCurve Hours Per Day" >= 6) and (NavAppProdRec."LCurve Hours Per Day" < 7) then
                                    LCH := 6;
                                if (NavAppProdRec."LCurve Hours Per Day" >= 7) and (NavAppProdRec."LCurve Hours Per Day" < 8) then
                                    LCH := 7;
                                if (NavAppProdRec."LCurve Hours Per Day" >= 8) and (NavAppProdRec."LCurve Hours Per Day" < 9) then
                                    LCH := 8;
                                if (NavAppProdRec."LCurve Hours Per Day" >= 9) and (NavAppProdRec."LCurve Hours Per Day" < 10) then
                                    LCH := 9;
                                if (NavAppProdRec."LCurve Hours Per Day" >= 10) and (NavAppProdRec."LCurve Hours Per Day" < 11) then
                                    LCH := 10;

                                if (NavAppProdRec."Learning Curve No." = 0) and (NavAppProdRec."LCurve Hours Per Day" <> 0) then begin
                                    LCH := 0;
                                end;

                                TotNavaHours := WorkingHrs - LCH;

                                if Time = 000000T then
                                    TimeVariable := Time;

                                if (Time >= 000000T) and (Time < 080000T) then begin
                                    TimeVariable := 080000T
                                end else
                                    if (Time >= 080000T) and (Time < 090000T) then begin
                                        TimeVariable := 090000T;
                                    end else
                                        if (Time >= 090000T) and (Time < 100000T) then begin
                                            TimeVariable := 090000T;
                                        end else
                                            if (Time >= 100000T) and (Time < 110000T) then begin
                                                TimeVariable := 100000T;
                                            end else
                                                if (Time >= 110000T) and (Time < 120000T) then begin
                                                    TimeVariable := 110000T;
                                                end else
                                                    if (Time >= 120000T) and (Time < 130000T) then begin
                                                        TimeVariable := 120000T;
                                                    end else
                                                        if (Time >= 130000T) and (Time < 140000T) then begin
                                                            TimeVariable := 130000T;
                                                        end else
                                                            if (Time >= 140000T) and (Time < 150000T) then begin
                                                                TimeVariable := 140000T;
                                                            end else
                                                                if (Time >= 150000T) and (Time < 160000T) then begin
                                                                    TimeVariable := 150000T;
                                                                end else
                                                                    if (Time >= 160000T) and (Time < 170000T) then begin
                                                                        TimeVariable := 160000T;
                                                                    end else
                                                                        if (Time >= 170000T) and (Time < 180000T) then begin
                                                                            TimeVariable := 170000T;
                                                                        end;

                                StartTime := 000000T;
                                if NavAppProdRec."LCurve Start Time" = 000000T then
                                    StartTime := NavAppProdRec."LCurve Start Time";


                                if (NavAppProdRec."LCurve Start Time" >= 080000T) and (NavAppProdRec."LCurve Start Time" < 090000T) then begin
                                    StartTime := 080000T;
                                end else
                                    if (NavAppProdRec."LCurve Start Time" >= 090000T) and (NavAppProdRec."LCurve Start Time" < 100000T) then begin
                                        StartTime := 090000T;
                                    end else
                                        if (NavAppProdRec."LCurve Start Time" >= 100000T) and (NavAppProdRec."LCurve Start Time" < 110000T) then begin
                                            StartTime := 100000T;
                                        end else
                                            if (NavAppProdRec."LCurve Start Time" >= 110000T) and (NavAppProdRec."LCurve Start Time" < 120000T) then begin
                                                StartTime := 110000T;
                                            end else
                                                if (NavAppProdRec."LCurve Start Time" >= 120000T) and (NavAppProdRec."LCurve Start Time" < 130000T) then begin
                                                    StartTime := 120000T;
                                                end else
                                                    if (NavAppProdRec."LCurve Start Time" >= 130000T) and (NavAppProdRec."LCurve Start Time" < 140000T) then begin
                                                        StartTime := 130000T;
                                                    end else
                                                        if (NavAppProdRec."LCurve Start Time" >= 140000T) and (NavAppProdRec."LCurve Start Time" < 150000T) then begin
                                                            StartTime := 140000T;
                                                        end else
                                                            if (NavAppProdRec."LCurve Start Time" >= 150000T) and (NavAppProdRec."LCurve Start Time" < 160000T) then begin
                                                                StartTime := 150000T;
                                                            end else
                                                                if (NavAppProdRec."LCurve Start Time" >= 160000T) and (NavAppProdRec."LCurve Start Time" < 170000T) then begin
                                                                    StartTime := 160000T;
                                                                end else
                                                                    if (NavAppProdRec."LCurve Start Time" >= 170000T) and (NavAppProdRec."LCurve Start Time" < 180000T) then begin
                                                                        StartTime := 170000T;
                                                                    end;


                                if StartTime = 080000T then begin
                                    if NavAppProdRec."Learning Curve No." > 1 then begin
                                        if TimeVariable = 090000T then begin

                                            HourlyProdLinesRec."Target_Hour 01" := 0;
                                            HourlyProdLinesRec.Modify();
                                            CurrPage.Update();
                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 2;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 03" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 02" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 02" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 3;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 03" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 03" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();



                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 4;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 04" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 5;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 05" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();

                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 6;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();

                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 7;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 8;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();

                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                    CheckValue := 0;
                                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;


                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                    if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                            end;
                                        end;

                                        if TimeVariable = 100000T then begin
                                            HourlyProdLinesRec."Target_Hour 01" := 0;
                                            HourlyProdLinesRec."Target_Hour 02" := 0;
                                            HourlyProdLinesRec.Modify();
                                            CurrPage.Update();
                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 3;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 03" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 03" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 4;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 04" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 5;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 05" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 6;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 7;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();



                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 8;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                    CheckValue := 0;
                                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;


                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                    if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                            end;
                                        end;
                                        if TimeVariable = 110000T then begin
                                            HourlyProdLinesRec."Target_Hour 01" := 0;
                                            HourlyProdLinesRec."Target_Hour 02" := 0;
                                            HourlyProdLinesRec."Target_Hour 03" := 0;
                                            HourlyProdLinesRec.Modify();
                                            CurrPage.Update();
                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 4;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 04" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 5;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 05" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 6;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();



                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 7;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();



                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 8;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                    CheckValue := 0;
                                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;


                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                    if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                            end;
                                        end;
                                        if TimeVariable = 120000T then begin
                                            HourlyProdLinesRec."Target_Hour 01" := 0;
                                            HourlyProdLinesRec."Target_Hour 02" := 0;
                                            HourlyProdLinesRec."Target_Hour 03" := 0;
                                            HourlyProdLinesRec."Target_Hour 04" := 0;
                                            HourlyProdLinesRec.Modify();
                                            CurrPage.Update();
                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 5;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 05" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 6;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();

                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 7;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();



                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 8;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                    CheckValue := 0;
                                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;


                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                    if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                            end;
                                        end;
                                        if TimeVariable = 130000T then begin
                                            HourlyProdLinesRec."Target_Hour 01" := 0;
                                            HourlyProdLinesRec."Target_Hour 02" := 0;
                                            HourlyProdLinesRec."Target_Hour 03" := 0;
                                            HourlyProdLinesRec."Target_Hour 04" := 0;
                                            HourlyProdLinesRec."Target_Hour 05" := 0;
                                            HourlyProdLinesRec.Modify();
                                            CurrPage.Update();
                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 6;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 7;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();



                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 8;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                    CheckValue := 0;
                                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;


                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                    if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                            end;
                                        end;
                                        if TimeVariable = 140000T then begin
                                            HourlyProdLinesRec."Target_Hour 01" := 0;
                                            HourlyProdLinesRec."Target_Hour 02" := 0;
                                            HourlyProdLinesRec."Target_Hour 03" := 0;
                                            HourlyProdLinesRec."Target_Hour 04" := 0;
                                            HourlyProdLinesRec."Target_Hour 05" := 0;
                                            HourlyProdLinesRec."Target_Hour 06" := 0;
                                            HourlyProdLinesRec.Modify();
                                            CurrPage.Update();
                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 7;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();



                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 8;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                    CheckValue := 0;
                                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;


                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                    if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                            end;
                                        end;
                                        if TimeVariable = 150000T then begin
                                            HourlyProdLinesRec."Target_Hour 01" := 0;
                                            HourlyProdLinesRec."Target_Hour 02" := 0;
                                            HourlyProdLinesRec."Target_Hour 03" := 0;
                                            HourlyProdLinesRec."Target_Hour 04" := 0;
                                            HourlyProdLinesRec."Target_Hour 05" := 0;
                                            HourlyProdLinesRec."Target_Hour 06" := 0;
                                            HourlyProdLinesRec."Target_Hour 07" := 0;
                                            HourlyProdLinesRec.Modify();
                                            CurrPage.Update();
                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                CheckValue := 0;
                                                CheckValue := TotNavaHours - 8;
                                                if CheckValue < 1 then begin
                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                    HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end else
                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();


                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                    CheckValue := 0;
                                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                end;


                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                    if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                            end;
                                        end;
                                        if TimeVariable = 160000T then begin
                                            HourlyProdLinesRec."Target_Hour 01" := 0;
                                            HourlyProdLinesRec."Target_Hour 02" := 0;
                                            HourlyProdLinesRec."Target_Hour 03" := 0;
                                            HourlyProdLinesRec."Target_Hour 04" := 0;
                                            HourlyProdLinesRec."Target_Hour 05" := 0;
                                            HourlyProdLinesRec."Target_Hour 06" := 0;
                                            HourlyProdLinesRec."Target_Hour 07" := 0;
                                            HourlyProdLinesRec."Target_Hour 08" := 0;
                                            HourlyProdLinesRec.Modify();
                                            CurrPage.Update();
                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                    CheckValue := 0;
                                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;


                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                    if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                            end;
                                        end;
                                        if TimeVariable = 170000T then begin
                                            HourlyProdLinesRec."Target_Hour 01" := 0;
                                            HourlyProdLinesRec."Target_Hour 02" := 0;
                                            HourlyProdLinesRec."Target_Hour 03" := 0;
                                            HourlyProdLinesRec."Target_Hour 04" := 0;
                                            HourlyProdLinesRec."Target_Hour 05" := 0;
                                            HourlyProdLinesRec."Target_Hour 06" := 0;
                                            HourlyProdLinesRec."Target_Hour 07" := 0;
                                            HourlyProdLinesRec."Target_Hour 08" := 0;
                                            HourlyProdLinesRec."Target_Hour 09" := 0;
                                            HourlyProdLinesRec.Modify();
                                            CurrPage.Update();
                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end
                                                else begin
                                                    // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                    if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                end;
                                            end;
                                        end;
                                    end;
                                end
                                else begin
                                    //coorect
                                    if StartTime = 090000T then begin
                                        HourlyProdLinesRec."Target_Hour 01" := (DayTarget / TotNavaHours);
                                        rec.Modify();
                                        if NavAppProdRec."Learning Curve No." > 1 then begin
                                            if TimeVariable = 100000T then begin
                                                HourlyProdLinesRec."Target_Hour 02" := 0;
                                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();

                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 3;
                                                    if CheckValue < 0 then
                                                        CheckValue := CheckValue * -1;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 03" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 03" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();



                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 4;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 04" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();


                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 5;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 05" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();


                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 6;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();


                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 7;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();



                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 8;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();


                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                        CheckValue := 0;
                                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end
                                                    else begin
                                                        // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;


                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end
                                                    else begin
                                                        // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                        if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();

                                                    end;
                                                end;
                                            end;
                                            if TimeVariable = 110000T then begin
                                                HourlyProdLinesRec."Target_Hour 02" := 0;
                                                HourlyProdLinesRec."Target_Hour 03" := 0;
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();
                                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 4;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 04" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();

                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 5;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 05" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();

                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 6;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();


                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 7;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();



                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 8;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();


                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                        CheckValue := 0;
                                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end
                                                    else begin
                                                        // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;


                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end
                                                    else begin
                                                        HourlyProdLinesRec."Target_Hour 10" := 0;
                                                        if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                end;
                                            end;
                                            if TimeVariable = 120000T then begin
                                                HourlyProdLinesRec."Target_Hour 02" := 0;
                                                HourlyProdLinesRec."Target_Hour 03" := 0;
                                                HourlyProdLinesRec."Target_Hour 04" := 0;
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();
                                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 5;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 05" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();


                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 6;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();

                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 7;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();



                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 8;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();


                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                        CheckValue := 0;
                                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end
                                                    else begin
                                                        // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;


                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end
                                                    else begin
                                                        // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                        if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                end;
                                            end;
                                            if TimeVariable = 130000T then begin
                                                HourlyProdLinesRec."Target_Hour 02" := 0;
                                                HourlyProdLinesRec."Target_Hour 03" := 0;
                                                HourlyProdLinesRec."Target_Hour 04" := 0;
                                                HourlyProdLinesRec."Target_Hour 05" := 0;
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();
                                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 6;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();


                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 7;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();



                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 8;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();


                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                        CheckValue := 0;
                                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end
                                                    else begin
                                                        // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;


                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end
                                                    else begin
                                                        // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                        if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                end;
                                            end;
                                            if TimeVariable = 140000T then begin
                                                HourlyProdLinesRec."Target_Hour 02" := 0;
                                                HourlyProdLinesRec."Target_Hour 03" := 0;
                                                HourlyProdLinesRec."Target_Hour 04" := 0;
                                                HourlyProdLinesRec."Target_Hour 05" := 0;
                                                HourlyProdLinesRec."Target_Hour 06" := 0;
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();
                                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 7;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();



                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 8;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();


                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                        CheckValue := 0;
                                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end
                                                    else begin
                                                        // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;


                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end
                                                    else begin
                                                        // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                        if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                end;
                                            end;
                                            if TimeVariable = 150000T then begin
                                                HourlyProdLinesRec."Target_Hour 02" := 0;
                                                HourlyProdLinesRec."Target_Hour 03" := 0;
                                                HourlyProdLinesRec."Target_Hour 04" := 0;
                                                HourlyProdLinesRec."Target_Hour 05" := 0;
                                                HourlyProdLinesRec."Target_Hour 06" := 0;
                                                HourlyProdLinesRec."Target_Hour 07" := 0;
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();
                                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                    CheckValue := 0;
                                                    CheckValue := TotNavaHours - 8;
                                                    if CheckValue < 1 then begin
                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                        HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end else
                                                        HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();


                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                        CheckValue := 0;
                                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end
                                                    else begin
                                                        // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;


                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end
                                                    else begin
                                                        // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                        if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                end;

                                            end;
                                            if TimeVariable = 160000T then begin
                                                HourlyProdLinesRec."Target_Hour 02" := 0;
                                                HourlyProdLinesRec."Target_Hour 03" := 0;
                                                HourlyProdLinesRec."Target_Hour 04" := 0;
                                                HourlyProdLinesRec."Target_Hour 05" := 0;
                                                HourlyProdLinesRec."Target_Hour 06" := 0;
                                                HourlyProdLinesRec."Target_Hour 07" := 0;
                                                HourlyProdLinesRec."Target_Hour 08" := 0;
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();
                                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                        CheckValue := 0;
                                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end
                                                    else begin
                                                        // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;


                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end
                                                    else begin
                                                        // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                        if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                end;
                                            end;
                                            if TimeVariable = 170000T then begin
                                                HourlyProdLinesRec."Target_Hour 02" := 0;
                                                HourlyProdLinesRec."Target_Hour 03" := 0;
                                                HourlyProdLinesRec."Target_Hour 04" := 0;
                                                HourlyProdLinesRec."Target_Hour 05" := 0;
                                                HourlyProdLinesRec."Target_Hour 06" := 0;
                                                HourlyProdLinesRec."Target_Hour 07" := 0;
                                                HourlyProdLinesRec."Target_Hour 08" := 0;
                                                HourlyProdLinesRec."Target_Hour 09" := 0;
                                                HourlyProdLinesRec.Modify();
                                                CurrPage.Update();
                                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end
                                                    else begin
                                                        // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                        if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end
                                    else begin

                                        //Correct

                                        if StartTime = 100000T then begin
                                            if (DayTarget <> 0) and (TotNavaHours <> 0) then begin
                                                HourlyProdLinesRec."Target_Hour 01" := (DayTarget / TotNavaHours);
                                                HourlyProdLinesRec."Target_Hour 02" := (DayTarget / TotNavaHours);
                                                rec.Modify();
                                            end;

                                            if NavAppProdRec."Learning Curve No." > 1 then begin
                                                if TimeVariable = 110000T then begin
                                                    HourlyProdLinesRec."Target_Hour 03" := 0;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                        CheckValue := 0;
                                                        CheckValue := TotNavaHours - 4;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 04" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();

                                                        CheckValue := 0;
                                                        CheckValue := TotNavaHours - 5;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 05" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();

                                                        CheckValue := 0;
                                                        CheckValue := TotNavaHours - 6;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();

                                                        CheckValue := 0;
                                                        CheckValue := TotNavaHours - 7;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();



                                                        CheckValue := 0;
                                                        CheckValue := TotNavaHours - 8;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();


                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                            CheckValue := 0;
                                                            CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                            if CheckValue < 1 then begin
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end
                                                        else begin
                                                            // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;


                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end
                                                        else begin
                                                            // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                            if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                    end;
                                                end;
                                                if TimeVariable = 120000T then begin
                                                    HourlyProdLinesRec."Target_Hour 03" := 0;
                                                    HourlyProdLinesRec."Target_Hour 04" := 0;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                        CheckValue := 0;
                                                        CheckValue := TotNavaHours - 5;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 05" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();


                                                        CheckValue := 0;
                                                        CheckValue := TotNavaHours - 6;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();

                                                        CheckValue := 0;
                                                        CheckValue := TotNavaHours - 7;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();



                                                        CheckValue := 0;
                                                        CheckValue := TotNavaHours - 8;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();


                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                            CheckValue := 0;
                                                            CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                            if CheckValue < 1 then begin
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end
                                                        else begin
                                                            // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;


                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end
                                                        else begin
                                                            // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                            if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                    end;
                                                end;
                                                if TimeVariable = 130000T then begin
                                                    HourlyProdLinesRec."Target_Hour 03" := 0;
                                                    HourlyProdLinesRec."Target_Hour 04" := 0;
                                                    HourlyProdLinesRec."Target_Hour 05" := 0;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                        CheckValue := 0;
                                                        CheckValue := TotNavaHours - 6;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();


                                                        CheckValue := 0;
                                                        CheckValue := TotNavaHours - 7;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();


                                                        CheckValue := 0;
                                                        CheckValue := TotNavaHours - 8;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();


                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                            CheckValue := 0;
                                                            CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                            if CheckValue < 1 then begin
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end
                                                        else begin
                                                            // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;


                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end
                                                        else begin
                                                            // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                            if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                    end;
                                                end;
                                                if TimeVariable = 140000T then begin
                                                    HourlyProdLinesRec."Target_Hour 03" := 0;
                                                    HourlyProdLinesRec."Target_Hour 04" := 0;
                                                    HourlyProdLinesRec."Target_Hour 05" := 0;
                                                    HourlyProdLinesRec."Target_Hour 06" := 0;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                        CheckValue := 0;
                                                        CheckValue := TotNavaHours - 7;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();


                                                        CheckValue := 0;
                                                        CheckValue := TotNavaHours - 8;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();


                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                            CheckValue := 0;
                                                            CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                            if CheckValue < 1 then begin
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end
                                                        else begin
                                                            // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;


                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end
                                                        else begin
                                                            // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                            if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                    end;
                                                end;
                                                if TimeVariable = 150000T then begin
                                                    HourlyProdLinesRec."Target_Hour 03" := 0;
                                                    HourlyProdLinesRec."Target_Hour 04" := 0;
                                                    HourlyProdLinesRec."Target_Hour 05" := 0;
                                                    HourlyProdLinesRec."Target_Hour 06" := 0;
                                                    HourlyProdLinesRec."Target_Hour 07" := 0;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                        CheckValue := 0;
                                                        CheckValue := TotNavaHours - 8;
                                                        if CheckValue < 1 then begin
                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                            HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end else
                                                            HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();


                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                            CheckValue := 0;
                                                            CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                            if CheckValue < 1 then begin
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end
                                                        else begin
                                                            // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;


                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end
                                                        else begin
                                                            // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                            if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                    end;
                                                end;
                                                if TimeVariable = 160000T then begin
                                                    HourlyProdLinesRec."Target_Hour 03" := 0;
                                                    HourlyProdLinesRec."Target_Hour 04" := 0;
                                                    HourlyProdLinesRec."Target_Hour 05" := 0;
                                                    HourlyProdLinesRec."Target_Hour 06" := 0;
                                                    HourlyProdLinesRec."Target_Hour 07" := 0;
                                                    HourlyProdLinesRec."Target_Hour 08" := 0;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                            CheckValue := 0;
                                                            CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                            if CheckValue < 1 then begin
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end
                                                        else begin
                                                            // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;


                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end
                                                        else begin
                                                            // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                            if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                    end;
                                                end;
                                                if TimeVariable = 170000T then begin
                                                    HourlyProdLinesRec."Target_Hour 03" := 0;
                                                    HourlyProdLinesRec."Target_Hour 04" := 0;
                                                    HourlyProdLinesRec."Target_Hour 05" := 0;
                                                    HourlyProdLinesRec."Target_Hour 06" := 0;
                                                    HourlyProdLinesRec."Target_Hour 07" := 0;
                                                    HourlyProdLinesRec."Target_Hour 08" := 0;
                                                    HourlyProdLinesRec."Target_Hour 09" := 0;
                                                    HourlyProdLinesRec.Modify();
                                                    CurrPage.Update();
                                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end
                                                        else begin
                                                            // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                            if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end
                                        else begin

                                            //Correct
                                            if StartTime = 110000T then begin
                                                if (DayTarget <> 0) and (TotNavaHours <> 0) then begin
                                                    HourlyProdLinesRec."Target_Hour 01" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec."Target_Hour 02" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec."Target_Hour 03" := (DayTarget / TotNavaHours);
                                                    HourlyProdLinesRec.Modify();
                                                end;
                                                if NavAppProdRec."Learning Curve No." > 1 then begin
                                                    if TimeVariable = 120000T then begin
                                                        HourlyProdLinesRec."Target_Hour 04" := 0;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 5;
                                                            if CheckValue < 1 then begin
                                                                HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 05" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();


                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 6;
                                                            if CheckValue < 1 then begin
                                                                HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();


                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 7;
                                                            if CheckValue < 1 then begin
                                                                HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();



                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 8;
                                                            if CheckValue < 1 then begin
                                                                HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();


                                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                                CheckValue := 0;
                                                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                                if CheckValue < 1 then begin
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end
                                                            else begin
                                                                // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;


                                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end
                                                            else begin
                                                                // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                        end;
                                                    end;
                                                    if TimeVariable = 130000T then begin
                                                        HourlyProdLinesRec."Target_Hour 04" := 0;
                                                        HourlyProdLinesRec."Target_Hour 05" := 0;
                                                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 6;
                                                            if CheckValue < 1 then begin
                                                                HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();


                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 7;
                                                            if CheckValue < 1 then begin
                                                                HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();



                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 8;
                                                            if CheckValue < 1 then begin
                                                                HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();


                                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                                CheckValue := 0;
                                                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                                if CheckValue < 1 then begin
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end
                                                            else begin
                                                                // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;


                                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end
                                                            else begin
                                                                // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                        end;
                                                    end;
                                                    if TimeVariable = 140000T then begin
                                                        HourlyProdLinesRec."Target_Hour 04" := 0;
                                                        HourlyProdLinesRec."Target_Hour 05" := 0;
                                                        HourlyProdLinesRec."Target_Hour 06" := 0;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 7;
                                                            if CheckValue < 1 then begin
                                                                HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();


                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 8;
                                                            if CheckValue < 1 then begin
                                                                HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();


                                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                                CheckValue := 0;
                                                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                                if CheckValue < 1 then begin
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end
                                                            else begin
                                                                // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;


                                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end
                                                            else begin
                                                                // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                        end;
                                                    end;
                                                    if TimeVariable = 150000T then begin
                                                        HourlyProdLinesRec."Target_Hour 04" := 0;
                                                        HourlyProdLinesRec."Target_Hour 05" := 0;
                                                        HourlyProdLinesRec."Target_Hour 06" := 0;
                                                        HourlyProdLinesRec."Target_Hour 07" := 0;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                            CheckValue := 0;
                                                            CheckValue := TotNavaHours - 8;
                                                            if CheckValue < 1 then begin
                                                                HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end else
                                                                HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();


                                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                                CheckValue := 0;
                                                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                                if CheckValue < 1 then begin
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end
                                                            else begin
                                                                // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;


                                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end
                                                            else begin
                                                                // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                        end;
                                                    end;
                                                    if TimeVariable = 160000T then begin
                                                        HourlyProdLinesRec."Target_Hour 04" := 0;
                                                        HourlyProdLinesRec."Target_Hour 05" := 0;
                                                        HourlyProdLinesRec."Target_Hour 06" := 0;
                                                        HourlyProdLinesRec."Target_Hour 07" := 0;
                                                        HourlyProdLinesRec."Target_Hour 08" := 0;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                                CheckValue := 0;
                                                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                                if CheckValue < 1 then begin
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end
                                                            else begin
                                                                // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;


                                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end
                                                            else begin
                                                                // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                        end;
                                                    end;
                                                    if TimeVariable = 170000T then begin
                                                        HourlyProdLinesRec."Target_Hour 04" := 0;
                                                        HourlyProdLinesRec."Target_Hour 05" := 0;
                                                        HourlyProdLinesRec."Target_Hour 06" := 0;
                                                        HourlyProdLinesRec."Target_Hour 07" := 0;
                                                        HourlyProdLinesRec."Target_Hour 08" := 0;
                                                        HourlyProdLinesRec."Target_Hour 09" := 0;
                                                        HourlyProdLinesRec.Modify();
                                                        CurrPage.Update();
                                                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end
                                                            else begin
                                                                // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            end
                                            else begin



                                                //Correct
                                                if StartTime = 120000T then begin
                                                    if (DayTarget <> 0) and (TotNavaHours <> 0) then begin
                                                        HourlyProdLinesRec."Target_Hour 01" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec."Target_Hour 02" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec."Target_Hour 03" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                                        HourlyProdLinesRec.Modify();
                                                    end;

                                                    if NavAppProdRec."Learning Curve No." > 1 then begin
                                                        if TimeVariable = 130000T then begin
                                                            HourlyProdLinesRec."Target_Hour 05" := 0;
                                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();

                                                                CheckValue := 0;
                                                                CheckValue := TotNavaHours - 6;
                                                                if CheckValue < 1 then begin
                                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();


                                                                CheckValue := 0;
                                                                CheckValue := TotNavaHours - 7;
                                                                if CheckValue < 1 then begin
                                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();



                                                                CheckValue := 0;
                                                                CheckValue := TotNavaHours - 8;
                                                                if CheckValue < 1 then begin
                                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();


                                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                                    CheckValue := 0;
                                                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                                    if CheckValue < 1 then begin
                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end;
                                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                        HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end else
                                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end
                                                                else begin
                                                                    // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;


                                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                        HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end else
                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end
                                                                else begin
                                                                    // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                    if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;
                                                            end;
                                                        end;
                                                        if TimeVariable = 140000T then begin
                                                            HourlyProdLinesRec."Target_Hour 05" := 0;
                                                            HourlyProdLinesRec."Target_Hour 06" := 0;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                                CheckValue := 0;
                                                                CheckValue := TotNavaHours - 7;
                                                                if CheckValue < 1 then begin
                                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();



                                                                CheckValue := 0;
                                                                CheckValue := TotNavaHours - 8;
                                                                if CheckValue < 1 then begin
                                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();


                                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                                    CheckValue := 0;
                                                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                                    if CheckValue < 1 then begin
                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end;
                                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                        HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end else
                                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end
                                                                else begin
                                                                    // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;


                                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                        HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end else
                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end
                                                                else begin
                                                                    // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                    if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;
                                                            end;
                                                        end;
                                                        if TimeVariable = 150000T then begin
                                                            HourlyProdLinesRec."Target_Hour 05" := 0;
                                                            HourlyProdLinesRec."Target_Hour 06" := 0;
                                                            HourlyProdLinesRec."Target_Hour 07" := 0;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                                CheckValue := 0;
                                                                CheckValue := TotNavaHours - 8;
                                                                if CheckValue < 1 then begin
                                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;
                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                    HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end else
                                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();


                                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                                    CheckValue := 0;
                                                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                                    if CheckValue < 1 then begin
                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end;
                                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                        HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end else
                                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end
                                                                else begin
                                                                    // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;

                                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                        HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end else
                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end
                                                                else begin
                                                                    // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                    if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;
                                                            end;
                                                        end;
                                                        //
                                                        if TimeVariable = 160000T then begin
                                                            HourlyProdLinesRec."Target_Hour 05" := 0;
                                                            HourlyProdLinesRec."Target_Hour 06" := 0;
                                                            HourlyProdLinesRec."Target_Hour 07" := 0;
                                                            HourlyProdLinesRec."Target_Hour 08" := 0;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                                    CheckValue := 0;
                                                                    CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                                    if CheckValue < 1 then begin
                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end;
                                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                        HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end else
                                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end
                                                                else begin
                                                                    // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;

                                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                        HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end else
                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end
                                                                else begin
                                                                    // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                    if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;
                                                            end;
                                                        end;
                                                        if TimeVariable = 170000T then begin
                                                            HourlyProdLinesRec."Target_Hour 05" := 0;
                                                            HourlyProdLinesRec."Target_Hour 06" := 0;
                                                            HourlyProdLinesRec."Target_Hour 07" := 0;
                                                            HourlyProdLinesRec."Target_Hour 08" := 0;
                                                            HourlyProdLinesRec."Target_Hour 09" := 0;
                                                            HourlyProdLinesRec.Modify();
                                                            CurrPage.Update();
                                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                        HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end else
                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end
                                                                else begin
                                                                    // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                    if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end
                                                else begin


                                                    //Correct
                                                    if StartTime = 130000T then begin
                                                        if (DayTarget <> 0) and (TotNavaHours <> 0) then begin
                                                            HourlyProdLinesRec."Target_Hour 01" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec."Target_Hour 02" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec."Target_Hour 03" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                            HourlyProdLinesRec.Modify();
                                                        end;

                                                        if NavAppProdRec."Learning Curve No." > 1 then begin
                                                            if TimeVariable = 140000T then begin
                                                                HourlyProdLinesRec."Target_Hour 06" := 0;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                                    CheckValue := 0;
                                                                    CheckValue := TotNavaHours - 7;
                                                                    if CheckValue < 1 then begin
                                                                        HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end;
                                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                        HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end else
                                                                        HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();


                                                                    CheckValue := 0;
                                                                    CheckValue := TotNavaHours - 8;
                                                                    if CheckValue < 1 then begin
                                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end;
                                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                        HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end else
                                                                        HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();


                                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                                        CheckValue := 0;
                                                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                                        if CheckValue < 1 then begin
                                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end;
                                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                            HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end else
                                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end
                                                                    else begin
                                                                        // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end;


                                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                            HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end else
                                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end
                                                                    else begin
                                                                        // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                        if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end;
                                                                end;
                                                            end;
                                                            if TimeVariable = 150000T then begin
                                                                HourlyProdLinesRec."Target_Hour 06" := 0;
                                                                HourlyProdLinesRec."Target_Hour 07" := 0;
                                                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                                    CheckValue := 0;
                                                                    CheckValue := TotNavaHours - 8;
                                                                    if CheckValue < 1 then begin
                                                                        HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end;
                                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                        HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end else
                                                                        HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();


                                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                                        CheckValue := 0;
                                                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                                        if CheckValue < 1 then begin
                                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end;
                                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                            HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end else
                                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end
                                                                    else begin
                                                                        // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end;


                                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                            HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end else
                                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end
                                                                    else begin
                                                                        // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                        if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end;
                                                                end;
                                                            end;
                                                            if TimeVariable = 160000T then begin
                                                                HourlyProdLinesRec."Target_Hour 06" := 0;
                                                                HourlyProdLinesRec."Target_Hour 07" := 0;
                                                                HourlyProdLinesRec."Target_Hour 08" := 0;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                                        CheckValue := 0;
                                                                        CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                                        if CheckValue < 1 then begin
                                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end;
                                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                            HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end else
                                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end;


                                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                            HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end else
                                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                        if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end;
                                                                end;

                                                            end;
                                                            if TimeVariable = 170000T then begin
                                                                HourlyProdLinesRec."Target_Hour 06" := 0;
                                                                HourlyProdLinesRec."Target_Hour 07" := 0;
                                                                HourlyProdLinesRec."Target_Hour 08" := 0;
                                                                HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                HourlyProdLinesRec.Modify();
                                                                CurrPage.Update();
                                                                if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                                    if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                            HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end else
                                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end
                                                                    else begin
                                                                        // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                        if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                            HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end;
                                                                end;
                                                            end;
                                                        end;
                                                    end
                                                    else begin


                                                        //correct
                                                        if StartTime = 140000T then begin
                                                            if (DayTarget <> 0) and (TotNavaHours <> 0) then begin
                                                                HourlyProdLinesRec."Target_Hour 01" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec."Target_Hour 02" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec."Target_Hour 03" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                                HourlyProdLinesRec.Modify();
                                                            end;

                                                            if NavAppProdRec."Learning Curve No." > 1 then begin
                                                                if TimeVariable = 150000T then begin
                                                                    HourlyProdLinesRec."Target_Hour 07" := 0;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                                        CheckValue := 0;
                                                                        CheckValue := TotNavaHours - 8;
                                                                        if CheckValue < 1 then begin
                                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end;
                                                                        if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                            HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end else
                                                                            HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();


                                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                                            CheckValue := 0;
                                                                            CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                                            if CheckValue < 1 then begin
                                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end;
                                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end else
                                                                                HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end;


                                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end else
                                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end
                                                                        else begin
                                                                            // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                            // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                            if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end;
                                                                    end;
                                                                end;
                                                                if TimeVariable = 160000T then begin
                                                                    HourlyProdLinesRec."Target_Hour 07" := 0;
                                                                    HourlyProdLinesRec."Target_Hour 08" := 0;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                                            CheckValue := 0;
                                                                            CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                                            if CheckValue < 1 then begin
                                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end;
                                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end else
                                                                                HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end;


                                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end else
                                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end
                                                                        else begin
                                                                            // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                            // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                            if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end;
                                                                    end;
                                                                end;
                                                                if TimeVariable = 170000T then begin
                                                                    HourlyProdLinesRec."Target_Hour 07" := 0;
                                                                    HourlyProdLinesRec."Target_Hour 08" := 0;
                                                                    HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end else
                                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end
                                                                        else begin
                                                                            // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                            if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end;
                                                                    end;
                                                                end;
                                                            end;
                                                        end
                                                        else begin


                                                            //correct
                                                            if StartTime = 150000T then begin
                                                                if (DayTarget <> 0) and (TotNavaHours <> 0) then begin
                                                                    HourlyProdLinesRec."Target_Hour 01" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec."Target_Hour 02" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec."Target_Hour 03" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                                    HourlyProdLinesRec.Modify();
                                                                end;
                                                                if NavAppProdRec."Learning Curve No." > 1 then
                                                                    if TimeVariable = 160000T then begin
                                                                        HourlyProdLinesRec."Target_Hour 08" := 0;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                                                CheckValue := 0;
                                                                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                                                if CheckValue < 1 then begin
                                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end;
                                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                    HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end else
                                                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();


                                                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                        HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                                        HourlyProdLinesRec.Modify();
                                                                                        CurrPage.Update();
                                                                                    end else
                                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end;
                                                                            end
                                                                            else begin
                                                                                // HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                                // HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                                if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end;
                                                                        end;
                                                                    end;
                                                                if TimeVariable = 170000T then begin
                                                                    HourlyProdLinesRec."Target_Hour 08" := 0;
                                                                    HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                    HourlyProdLinesRec.Modify();
                                                                    CurrPage.Update();
                                                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end else
                                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                            if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                        end;
                                                                    end;
                                                                end;
                                                            end
                                                            else begin

                                                                //correct
                                                                if StartTime = 160000T then begin
                                                                    if (DayTarget <> 0) and (TotNavaHours <> 0) then begin
                                                                        HourlyProdLinesRec."Target_Hour 01" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec."Target_Hour 02" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec."Target_Hour 03" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                                        HourlyProdLinesRec.Modify();
                                                                    end;

                                                                    if NavAppProdRec."Learning Curve No." > 1 then
                                                                        if TimeVariable = 170000T then begin
                                                                            HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                            HourlyProdLinesRec.Modify();
                                                                            CurrPage.Update();
                                                                            if (TotNavaHours <> 0) and (DayTarget <> 0) then begin

                                                                                if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                                    if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                        HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                                        HourlyProdLinesRec.Modify();
                                                                                        CurrPage.Update();
                                                                                    end else
                                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                                    if (NavAppProdRec."LCurve Hours Per Day" > 0) and (NavAppProdRec."LCurve Hours Per Day" < 1) and (WorkingHrs = 10) then
                                                                                        HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end;
                                                                            end;

                                                                        end;
                                                                end
                                                                else begin

                                                                    if StartTime = 170000T then begin
                                                                        if (DayTarget <> 0) and (TotNavaHours <> 0) then begin
                                                                            HourlyProdLinesRec."Target_Hour 01" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec."Target_Hour 02" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec."Target_Hour 03" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                            HourlyProdLinesRec.Modify();
                                                                        end;

                                                                        if NavAppProdRec."Learning Curve No." > 1 then
                                                                            HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                        HourlyProdLinesRec.Modify();
                                                                        CurrPage.Update();
                                                                    end
                                                                    else begin

                                                                        // if NavAppProdRec."Resource No." = 'PAL-10' then begin
                                                                        //     Message('Pal10');
                                                                        // end;
                                                                        //correct
                                                                        HourlyProdLinesRec."Target_Hour 01" := 0;
                                                                        HourlyProdLinesRec."Target_Hour 02" := 0;
                                                                        HourlyProdLinesRec."Target_Hour 03" := 0;
                                                                        HourlyProdLinesRec."Target_Hour 04" := 0;
                                                                        HourlyProdLinesRec."Target_Hour 05" := 0;
                                                                        HourlyProdLinesRec."Target_Hour 06" := 0;
                                                                        HourlyProdLinesRec."Target_Hour 07" := 0;
                                                                        HourlyProdLinesRec."Target_Hour 08" := 0;
                                                                        HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                        HourlyProdLinesRec."Target_Hour 10" := 0;


                                                                        if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                                                            if TotNavaHours >= 0 then begin
                                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                    HourlyProdLinesRec."Target_Hour 01" := DayTarget;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end else begin
                                                                                    HourlyProdLinesRec."Target_Hour 01" := (DayTarget / TotNavaHours);
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end;
                                                                            end;
                                                                            if TotNavaHours >= 1 then begin
                                                                                CheckValue := 0;
                                                                                CheckValue := TotNavaHours - 1;
                                                                                if CheckValue < 1 then begin
                                                                                    HourlyProdLinesRec."Target_Hour 02" := (DayTarget / TotNavaHours) * CheckValue;
                                                                                    HourlyProdLinesRec."Target_Hour 03" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 04" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 05" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 06" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 07" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 08" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end;
                                                                            end;

                                                                            if TotNavaHours >= 2 then begin
                                                                                CheckValue := 0;
                                                                                CheckValue := TotNavaHours - 2;
                                                                                if CheckValue < 1 then begin
                                                                                    HourlyProdLinesRec."Target_Hour 03" := (DayTarget / TotNavaHours) * CheckValue;

                                                                                    HourlyProdLinesRec."Target_Hour 04" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 05" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 06" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 07" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 08" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end;
                                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                    HourlyProdLinesRec."Target_Hour 02" := DayTarget;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end else
                                                                                    HourlyProdLinesRec."Target_Hour 02" := (DayTarget / TotNavaHours);
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end;

                                                                            if TotNavaHours >= 3 then begin
                                                                                CheckValue := 0;
                                                                                CheckValue := TotNavaHours - 3;
                                                                                if CheckValue < 1 then begin
                                                                                    HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours) * CheckValue;

                                                                                    HourlyProdLinesRec."Target_Hour 05" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 06" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 07" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 08" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end;
                                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                    HourlyProdLinesRec."Target_Hour 03" := DayTarget;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end else
                                                                                    HourlyProdLinesRec."Target_Hour 03" := (DayTarget / TotNavaHours);
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end;

                                                                            if TotNavaHours >= 4 then begin
                                                                                CheckValue := 0;
                                                                                CheckValue := TotNavaHours - 4;
                                                                                if CheckValue < 1 then begin
                                                                                    HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours) * CheckValue;

                                                                                    HourlyProdLinesRec."Target_Hour 06" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 07" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 08" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end;
                                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                    HourlyProdLinesRec."Target_Hour 04" := DayTarget;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end else
                                                                                    HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end;

                                                                            if TotNavaHours >= 5 then begin
                                                                                CheckValue := 0;
                                                                                CheckValue := TotNavaHours - 5;
                                                                                if CheckValue < 1 then begin
                                                                                    HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;

                                                                                    HourlyProdLinesRec."Target_Hour 07" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 08" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end;
                                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                    HourlyProdLinesRec."Target_Hour 05" := DayTarget;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end else
                                                                                    HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end;

                                                                            if TotNavaHours >= 6 then begin
                                                                                CheckValue := 0;
                                                                                CheckValue := TotNavaHours - 6;
                                                                                if CheckValue < 1 then begin
                                                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;

                                                                                    HourlyProdLinesRec."Target_Hour 08" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end;
                                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                    HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end else
                                                                                    HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end;

                                                                            if TotNavaHours >= 7 then begin
                                                                                CheckValue := 0;
                                                                                CheckValue := TotNavaHours - 7;
                                                                                if CheckValue < 1 then begin
                                                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;

                                                                                    HourlyProdLinesRec."Target_Hour 09" := 0;
                                                                                    HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end;
                                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                    HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end else
                                                                                    HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end;

                                                                            if TotNavaHours >= 8 then begin
                                                                                CheckValue := 0;
                                                                                CheckValue := TotNavaHours - 8;
                                                                                if CheckValue < 1 then begin
                                                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;

                                                                                    HourlyProdLinesRec."Target_Hour 10" := 0;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end;
                                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                    HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end else
                                                                                    HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end;


                                                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                                                                CheckValue := 0;
                                                                                CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                                                                if CheckValue < 1 then begin
                                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end;
                                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                    HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end else
                                                                                    HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end;


                                                                            if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                                                                if (DayTarget / TotNavaHours) > DayTarget then begin
                                                                                    HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                                                    HourlyProdLinesRec.Modify();
                                                                                    CurrPage.Update();
                                                                                end else
                                                                                    HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                                                                HourlyProdLinesRec.Modify();
                                                                                CurrPage.Update();
                                                                            end;
                                                                        end;
                                                                    end;
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                                if (NavAppProdRec."Learning Curve No." = 0) and (NavAppProdRec."LCurve Hours Per Day" <> 0) then begin
                                    if (TotNavaHours <> 0) and (DayTarget <> 0) then begin
                                        if TotNavaHours >= 0 then begin
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                HourlyProdLinesRec."Target_Hour 01" := DayTarget;
                                                HourlyProdLinesRec.Modify();
                                            end else
                                                HourlyProdLinesRec."Target_Hour 01" := (DayTarget / TotNavaHours);
                                            HourlyProdLinesRec.Modify();
                                        end;
                                        if TotNavaHours >= 1 then begin
                                            CheckValue := 0;
                                            CheckValue := TotNavaHours - 1;
                                            if CheckValue < 1 then begin
                                                HourlyProdLinesRec."Target_Hour 02" := (DayTarget / TotNavaHours) * CheckValue;
                                                HourlyProdLinesRec."Target_Hour 03" := 0;
                                                HourlyProdLinesRec."Target_Hour 04" := 0;
                                                HourlyProdLinesRec."Target_Hour 05" := 0;
                                                HourlyProdLinesRec."Target_Hour 06" := 0;
                                                HourlyProdLinesRec."Target_Hour 07" := 0;
                                                HourlyProdLinesRec."Target_Hour 08" := 0;
                                                HourlyProdLinesRec."Target_Hour 09" := 0;
                                                HourlyProdLinesRec."Target_Hour 10" := 0;

                                                HourlyProdLinesRec.Modify();
                                            end;
                                        end;

                                        if TotNavaHours >= 2 then begin
                                            CheckValue := 0;
                                            CheckValue := TotNavaHours - 2;
                                            if CheckValue < 1 then begin
                                                HourlyProdLinesRec."Target_Hour 03" := (DayTarget / TotNavaHours) * CheckValue;
                                                HourlyProdLinesRec."Target_Hour 04" := 0;
                                                HourlyProdLinesRec."Target_Hour 05" := 0;
                                                HourlyProdLinesRec."Target_Hour 06" := 0;
                                                HourlyProdLinesRec."Target_Hour 07" := 0;
                                                HourlyProdLinesRec."Target_Hour 08" := 0;
                                                HourlyProdLinesRec."Target_Hour 09" := 0;
                                                HourlyProdLinesRec."Target_Hour 10" := 0;
                                                HourlyProdLinesRec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                HourlyProdLinesRec."Target_Hour 02" := DayTarget;
                                                HourlyProdLinesRec.Modify();
                                            end else
                                                HourlyProdLinesRec."Target_Hour 02" := (DayTarget / TotNavaHours);
                                            HourlyProdLinesRec.Modify();
                                        end;

                                        if TotNavaHours >= 3 then begin
                                            CheckValue := 0;
                                            CheckValue := TotNavaHours - 3;
                                            if CheckValue < 1 then begin
                                                HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours) * CheckValue;
                                                HourlyProdLinesRec."Target_Hour 05" := 0;
                                                HourlyProdLinesRec."Target_Hour 06" := 0;
                                                HourlyProdLinesRec."Target_Hour 07" := 0;
                                                HourlyProdLinesRec."Target_Hour 08" := 0;
                                                HourlyProdLinesRec."Target_Hour 09" := 0;
                                                HourlyProdLinesRec."Target_Hour 10" := 0;
                                                HourlyProdLinesRec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                HourlyProdLinesRec."Target_Hour 03" := DayTarget;
                                                rec.Modify();
                                            end else
                                                HourlyProdLinesRec."Target_Hour 03" := (DayTarget / TotNavaHours);
                                            HourlyProdLinesRec.Modify();
                                        end;

                                        if TotNavaHours >= 4 then begin
                                            CheckValue := 0;
                                            CheckValue := TotNavaHours - 4;
                                            if CheckValue < 1 then begin
                                                HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours) * CheckValue;
                                                HourlyProdLinesRec."Target_Hour 06" := 0;
                                                HourlyProdLinesRec."Target_Hour 07" := 0;
                                                HourlyProdLinesRec."Target_Hour 08" := 0;
                                                HourlyProdLinesRec."Target_Hour 09" := 0;
                                                HourlyProdLinesRec."Target_Hour 10" := 0;
                                                HourlyProdLinesRec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                HourlyProdLinesRec."Target_Hour 04" := DayTarget;
                                                HourlyProdLinesRec.Modify();
                                            end else
                                                HourlyProdLinesRec."Target_Hour 04" := (DayTarget / TotNavaHours);
                                            HourlyProdLinesRec.Modify();
                                        end;

                                        if TotNavaHours >= 5 then begin
                                            CheckValue := 0;
                                            CheckValue := TotNavaHours - 5;
                                            if CheckValue < 1 then begin
                                                HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours) * CheckValue;
                                                HourlyProdLinesRec."Target_Hour 07" := 0;
                                                HourlyProdLinesRec."Target_Hour 08" := 0;
                                                HourlyProdLinesRec."Target_Hour 09" := 0;
                                                HourlyProdLinesRec."Target_Hour 10" := 0;
                                                HourlyProdLinesRec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                HourlyProdLinesRec."Target_Hour 05" := DayTarget;
                                                HourlyProdLinesRec.Modify();
                                            end else
                                                HourlyProdLinesRec."Target_Hour 05" := (DayTarget / TotNavaHours);
                                            HourlyProdLinesRec.Modify();
                                        end;

                                        if TotNavaHours >= 6 then begin
                                            CheckValue := 0;
                                            CheckValue := TotNavaHours - 6;
                                            if CheckValue < 1 then begin
                                                HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours) * CheckValue;
                                                HourlyProdLinesRec."Target_Hour 08" := 0;
                                                HourlyProdLinesRec."Target_Hour 09" := 0;
                                                HourlyProdLinesRec."Target_Hour 10" := 0;
                                                HourlyProdLinesRec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                HourlyProdLinesRec."Target_Hour 06" := DayTarget;
                                                HourlyProdLinesRec.Modify();
                                            end else
                                                HourlyProdLinesRec."Target_Hour 06" := (DayTarget / TotNavaHours);
                                            HourlyProdLinesRec.Modify();
                                        end;

                                        if TotNavaHours >= 7 then begin
                                            CheckValue := 0;
                                            CheckValue := TotNavaHours - 7;
                                            if CheckValue < 1 then begin
                                                HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours) * CheckValue;
                                                HourlyProdLinesRec."Target_Hour 09" := 0;
                                                HourlyProdLinesRec."Target_Hour 10" := 0;
                                                HourlyProdLinesRec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                HourlyProdLinesRec."Target_Hour 07" := DayTarget;
                                                HourlyProdLinesRec.Modify();
                                            end else
                                                HourlyProdLinesRec."Target_Hour 07" := (DayTarget / TotNavaHours);
                                            HourlyProdLinesRec.Modify();
                                        end;

                                        if TotNavaHours >= 8 then begin
                                            CheckValue := 0;
                                            CheckValue := TotNavaHours - 8;
                                            if CheckValue < 1 then begin
                                                HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours) * CheckValue;
                                                HourlyProdLinesRec."Target_Hour 10" := 0;
                                                HourlyProdLinesRec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                HourlyProdLinesRec."Target_Hour 08" := DayTarget;
                                                HourlyProdLinesRec.Modify();
                                            end else
                                                HourlyProdLinesRec."Target_Hour 08" := (DayTarget / TotNavaHours);
                                            HourlyProdLinesRec.Modify();
                                        end;

                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 9 then begin
                                            CheckValue := 0;
                                            CheckValue := (TotNavaHours + NavAppProdRec."LCurve Hours Per Day") - 9;
                                            if CheckValue < 1 then begin
                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours) * CheckValue;
                                                HourlyProdLinesRec.Modify();
                                            end;
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                HourlyProdLinesRec."Target_Hour 09" := DayTarget;
                                                HourlyProdLinesRec.Modify();
                                            end else
                                                HourlyProdLinesRec."Target_Hour 09" := (DayTarget / TotNavaHours);
                                            HourlyProdLinesRec.Modify();
                                        end;

                                        if TotNavaHours + NavAppProdRec."LCurve Hours Per Day" >= 10 then begin
                                            if (DayTarget / TotNavaHours) > DayTarget then begin
                                                HourlyProdLinesRec."Target_Hour 10" := DayTarget;
                                                HourlyProdLinesRec.Modify();
                                            end else
                                                HourlyProdLinesRec."Target_Hour 10" := (DayTarget / TotNavaHours);
                                            HourlyProdLinesRec.Modify();
                                        end;
                                    end;
                                end;

                                CurrPage.Update();
                                //     end;
                                // end;
                            end;

                        until HourlyProdLinesRec.Next() = 0;

                    end;
                end;

            }

            // action(Delete)
            // {
            //     trigger OnAction()
            //     var
            //         HourlyLineRec: Record "Hourly Production Lines";
            //         NavRec: Record "NavApp Prod Plans Details";

            //     begin
            //         // HourlyLineRec.Reset();
            //         // HourlyLineRec.SetRange("No.", DocumentNo);
            //         // HourlyLineRec.SetRange("Line No.", LineNO);
            //         // if HourlyLineRec.FindFirst() then begin
            //         //     HourlyLineRec.Delete();

            //         NavRec.Reset();
            //         NavRec.SetRange("No.", DocumentNo);
            //         NavRec.SetRange("Style No.", LineNO);
            //         if NavRec.FindFirst() then
            //             NavRec.Delete();
            //     end;

            // }


        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        HourlyProdLinesRec: Record "Hourly Production Lines";
        UserRec: Record "User Setup";
        ProdOutHeaderRec: Record ProductionOutHeader;
    begin
        //Check whether production updated or not
        if rec.Type = rec.Type::Sewing then begin
            ProdOutHeaderRec.Reset();
            ProdOutHeaderRec.SetRange("Prod Date", rec."Prod Date");
            ProdOutHeaderRec.SetRange("Factory Code", rec."Factory No.");
            ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Saw);
            ProdOutHeaderRec.SetFilter("Prod Updated", '=%1', 1);
            if ProdOutHeaderRec.FindSet() then
                Error('Production updated against Date : %1 , Factory : %2 has been updates. You cannot delete this entry.', rec."Prod Date", rec."Factory Name");
        end;

        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory No.") then
                Error('You are not authorized to delete this record.');
        end
        else
            Error('You are not authorized to delete records.');


        if Today <> Rec."Prod Date" then
            Error('You Cannot delete previous Date records');

        HourlyProdLinesRec.Reset();
        HourlyProdLinesRec.SetRange("No.", rec."No.");
        if HourlyProdLinesRec.FindSet() then
            HourlyProdLinesRec.DeleteAll();
    end;


    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
        ProdOutHeaderRec: Record ProductionOutHeader;
    begin
        UserRec.Reset();
        UserRec.Get(UserId);

        if rec."Factory No." <> '' then begin
            if (UserRec."Factory Code" <> '') then begin
                if (UserRec."Factory Code" <> rec."Factory No.") then
                    EditableGB := false
                else begin

                    if rec.Type = rec.Type::Sewing then begin
                        ProdOutHeaderRec.Reset();
                        ProdOutHeaderRec.SetRange("Prod Date", rec."Prod Date");
                        ProdOutHeaderRec.SetRange("Factory Code", rec."Factory No.");
                        ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Saw);
                        ProdOutHeaderRec.SetFilter("Prod Updated", '=%1', 1);
                        if ProdOutHeaderRec.FindSet() then
                            EditableGB := false
                        else
                            EditableGB := true;
                    end;

                end;
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

    // trigger OnClosePage()
    // var
    //     HourlyRec: Record "Hourly Production Master";
    //     HourlyLinesRec: Record "Hourly Production Lines";
    // begin
    //     HourlyRec.Reset();
    //     HourlyLinesRec.Reset();
    //     HourlyRec.SetRange("No.", Rec."No.");
    //     if HourlyRec.FindSet() then begin
    //         HourlyLinesRec.SetRange("No.", HourlyRec."No.");
    //         HourlyLinesRec.SetFilter(Item, '=%1', 'PASS PCS');
    //         if HourlyLinesRec.FindSet() then begin
    //             if Rec."Prod Date" <> HourlyLinesRec."Prod Date" then
    //                 Error('Please Check Production Date');
    //         end;

    //     end;
    // end;


    trigger OnAfterGetCurrRecord()
    var
        UserRec: Record "User Setup";
        ProdOutHeaderRec: Record ProductionOutHeader;
    begin
        UserRec.Reset();
        UserRec.Get(UserId);

        if rec."Factory No." <> '' then begin
            if (UserRec."Factory Code" <> '') then begin
                if (UserRec."Factory Code" <> rec."Factory No.") then
                    EditableGB := false
                else begin
                    if rec.Type = rec.Type::Sewing then begin
                        ProdOutHeaderRec.Reset();
                        ProdOutHeaderRec.SetRange("Prod Date", rec."Prod Date");
                        ProdOutHeaderRec.SetRange("Factory Code", rec."Factory No.");
                        ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Saw);
                        ProdOutHeaderRec.SetFilter("Prod Updated", '=%1', 1);
                        if ProdOutHeaderRec.FindSet() then
                            EditableGB := false
                        else
                            EditableGB := true;
                    end;
                end;
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