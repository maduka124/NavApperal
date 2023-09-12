page 51377 "Hourly Finishing Card"
{
    PageType = Card;
    UsageCategory = Tasks;
    ApplicationArea = all;
    SourceTable = "Hourly Production Master";
    Caption = 'Hourly Finishing';

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
                        Rec.Type := Rec.Type::Finishing;

                        HourlyLinesRec.Reset();
                        HourlyLinesRec.SetRange("No.", Rec."No.");
                        HourlyLinesRec.SetRange(Type, HourlyLinesRec.Type::Finishing);
                        HourlyLinesRec.SetFilter(Item, '=%1', 'PASS PCS');
                        if HourlyLinesRec.FindSet() then begin
                            if Rec."Prod Date" <> HourlyLinesRec."Prod Date" then
                                Error('Please Check Production Date');
                        end;



                        //Validate Date

                        // if rec."Prod Date" < WorkDate() then
                        //     Error('Cannot enter production for previous dates.');

                        if Rec."Prod Date" <> WorkDate() then
                            Error('Cannot enter Finishing For Next dates or previous dates');


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
                            HourlyRec.SetRange(Type, HourlyRec.Type::Finishing);
                            if HourlyRec.FindFirst() then
                                Error('Record already Exist');
                        end;
                    end;

                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;

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
                part(HourlyFinishingListPart; HourlyFinishingListPart)
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
                    StyleRec: Record "Style Master";
                    CheckValue: Decimal;
                    TotNavaHours: Decimal;
                    TimeVariable: Time;
                    StyleLC1: Code[20];
                    LineLC1: Code[20];
                    StyleLC: Code[20];
                    LineLC: Code[20];
                    NavAppProdRec: Record "NavApp Prod Plans Details";
                    DayTarget: Decimal;
                    HourlyProdLinesRec3: Record "Hourly Production Lines";
                    HourlyProdLines2Rec: Record "Hourly Production Lines";
                    HourlyProdLinesRec: Record "Hourly Production Lines";
                    HourlyProdLines1Rec: Record "Hourly Production Lines";
                    NavAppProdPlanLinesRec: Record "NavApp Prod Plans Details";
                    WorkCenrterRec: Record "Work Center";
                    ProductionOutHeaderRec: Record ProductionOutHeader;
                    i: Integer;
                    LineNo: Integer;
                    StyleNo: code[20];
                    ResourceNo: code[20];
                begin
                    HourlyLineRec.Reset();
                    HourlyLineRec.SetRange("Factory No.", Rec."Factory No.");
                    HourlyLineRec.SetRange(Type, HourlyLineRec.Type::Finishing);
                    HourlyLineRec.SetFilter(Item, '=%1', 'PASS PCS');
                    HourlyLineRec.SetCurrentKey("Prod Date");
                    HourlyLineRec.Ascending(true);
                    if HourlyLineRec.FindLast() then begin
                        LatestDate := HourlyLineRec."Prod Date";
                    end;


                    // Validate Date
                    // if rec."Prod Date" < WorkDate() then
                    //     Error('Cannot enter production for previous dates.');

                    if (Dialog.CONFIRM('"Hourly Finishing" will erase old records. Do you want to continue?', true) = true) then begin
                        CurrPage.Update();

                        HourlyProdLinesRec.Reset();
                        HourlyProdLinesRec.SetRange("No.", Rec."No.");
                        // HourlyProdLinesRec.SetRange(Type, HourlyProdLinesRec.Type::Finishing);
                        if HourlyProdLinesRec.FindSet() then begin
                            HourlyProdLinesRec.DeleteAll();
                        end;



                        //Get max lineno
                        HourlyProdLines1Rec.Reset();
                        HourlyProdLines1Rec.SetRange("No.", rec."No.");

                        if HourlyProdLines1Rec.FindLast() then
                            LineNo := HourlyProdLines1Rec."Line No.";

                        HourlyProdLinesRec3.Reset();
                        HourlyProdLinesRec3.SetRange("Prod Date", LatestDate);
                        HourlyProdLinesRec3.SetRange("Factory No.", rec."Factory No.");
                        HourlyProdLinesRec3.SetRange(Type, rec.Type);
                        HourlyProdLinesRec3.SetFilter(Item, '=%1', 'PASS PCS');
                        HourlyProdLinesRec3.SetCurrentKey("Style No.", "Work Center No.");
                        HourlyProdLinesRec3.Ascending(true);

                        if HourlyProdLinesRec3.FindSet() then begin

                            repeat

                                StyleRec.Reset();
                                StyleRec.SetRange("No.", HourlyProdLinesRec3."Style No.");
                                StyleRec.FindSet();

                                WorkCenrterRec.Reset();
                                WorkCenrterRec.SetRange("No.", HourlyProdLinesRec3."Work Center No.");
                                if WorkCenrterRec.FindSet() then begin

                                    if (StyleNo <> HourlyProdLinesRec3."Style No.") or (ResourceNo <> HourlyProdLinesRec3."Work Center No.") then begin


                                        LineNo += 1;
                                        HourlyProdLinesRec.Init();
                                        HourlyProdLinesRec."No." := rec."No.";
                                        HourlyProdLinesRec."Line No." := LineNo;
                                        HourlyProdLinesRec."Style Name" := StyleRec."Style No.";
                                        HourlyProdLinesRec.Type := Rec.Type;
                                        HourlyProdLinesRec."Style No." := HourlyProdLinesRec3."Style No.";
                                        HourlyProdLinesRec."Work Center Seq No" := WorkCenrterRec."Work Center Seq No";
                                        HourlyProdLinesRec.Insert();
                                        StyleNo := HourlyProdLinesRec."Style No.";
                                        ResourceNo := HourlyProdLinesRec."Work Center No.";

                                        // end;
                                    end;
                                    //Mihiranga 2023/03/29
                                    HourlyProdLines1Rec.Reset();
                                    HourlyProdLines1Rec.SetRange("No.", rec."No.");
                                    HourlyProdLines1Rec.SetRange("Prod Date", rec."Prod Date");
                                    HourlyProdLines1Rec.SetRange("Factory No.", rec."Factory No.");
                                    HourlyProdLines1Rec.SetRange("Line No.", HourlyProdLinesRec3."Line No.");
                                    HourlyProdLines1Rec.SetFilter(Item, '=%1', 'PASS PCS');
                                    HourlyProdLines1Rec.SetRange("Style No.", HourlyProdLinesRec3."Style No.");
                                    HourlyProdLines1Rec.SetRange("Work Center Name", HourlyProdLinesRec3."Work Center No.");
                                    if HourlyProdLines1Rec.FindSet() then begin
                                        //Do nothing when record found
                                    end
                                    else begin

                                        LineNo += 1;

                                        HourlyProdLinesRec.Init();
                                        HourlyProdLinesRec."No." := rec."No.";
                                        HourlyProdLinesRec."Line No." := LineNo;
                                        HourlyProdLinesRec."Factory No." := rec."Factory No.";
                                        HourlyProdLinesRec."Prod Date" := Rec."Prod Date";
                                        HourlyProdLinesRec.Type := rec.Type;
                                        HourlyProdLinesRec."Work Center No." := HourlyProdLinesRec3."Work Center No.";
                                        HourlyProdLinesRec."Style No." := HourlyProdLinesRec3."Style No.";
                                        HourlyProdLinesRec."Work Center Name" := WorkCenrterRec.Name;
                                        HourlyProdLinesRec."Work Center Seq No" := WorkCenrterRec."Work Center Seq No";
                                        HourlyProdLinesRec.Item := 'PASS PCS';
                                        HourlyProdLinesRec.Insert();

                                    end;
                                end;
                            until HourlyProdLinesRec3.Next() = 0;

                            HourlyProdLines2Rec.Reset();
                            HourlyProdLines2Rec.SetRange("No.", HourlyProdLinesRec3."No.");
                            HourlyProdLines2Rec.SetRange("Prod Date", HourlyProdLinesRec3."Prod Date");
                            HourlyProdLines2Rec.SetRange("Factory No.", HourlyProdLinesRec3."Factory No.");
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

                                // LineNo += 1;
                                // HourlyProdLinesRec.Init();
                                // HourlyProdLinesRec."No." := rec."No.";
                                // HourlyProdLinesRec."Line No." := LineNo;
                                // HourlyProdLinesRec."Style Name" := 'DEFECT PCS (Total)';
                                // HourlyProdLinesRec."Work Center Seq No" := 101;
                                // HourlyProdLinesRec.Insert();

                                // LineNo += 1;
                                // HourlyProdLinesRec.Init();
                                // HourlyProdLinesRec."No." := rec."No.";
                                // HourlyProdLinesRec."Line No." := LineNo;
                                // HourlyProdLinesRec."Style Name" := 'DHU (Total)';
                                // HourlyProdLinesRec."Work Center Seq No" := 102;
                                // HourlyProdLinesRec.Insert();

                            end;
                        end;
                    end
                    else
                        Message('Another entry with same Date/Factory/Type exists.');
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

                    if rec.Type = rec.Type::Finishing then begin
                        ProdOutHeaderRec.Reset();
                        ProdOutHeaderRec.SetRange("Prod Date", rec."Prod Date");
                        ProdOutHeaderRec.SetRange("Factory Code", rec."Factory No.");
                        ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Fin);
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


        rec.Type := Rec.Type::Finishing;

        UserRec.Reset();
        UserRec.Get(UserId);

        if rec."Factory No." <> '' then begin
            if (UserRec."Factory Code" <> '') then begin
                if (UserRec."Factory Code" <> rec."Factory No.") then
                    EditableGB := false
                else begin
                    if rec.Type = rec.Type::Finishing then begin
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
        LatestDate: Date;
        HourlyLineRec: Record "Hourly Production Lines";
}