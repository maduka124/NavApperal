page 51305 "Hourly Production Plan Card"
{
    PageType = Card;
    UsageCategory = Tasks;
    ApplicationArea = all;
    SourceTable = "Hourly Production Master";
    Caption = 'Hourly Production';
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

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

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(Filter)
    //         {
    //             ApplicationArea = All;

    //             trigger OnAction()
    //             var
    //                 HourlyProdLinesRec: Record "Hourly Production Lines";
    //                 HourlyProdLines1Rec: Record "Hourly Production Lines";
    //                 NavAppProdPlanLinesRec: Record "NavApp Prod Plans Details";
    //                 WorkCenrterRec: Record "Work Center";
    //                 ProductionOutHeaderRec: Record ProductionOutHeader;
    //                 i: Integer;
    //                 LineNo: Integer;
    //                 StyleNo: code[20];
    //                 ResourceNo: code[20];
    //             begin

    //                 //Validate Date
    //                 if rec."Prod Date" < WorkDate() then
    //                     Error('Cannot enter production for previous dates.');

    //                 CurrPage.Update();

    //                 //Done By sachith on 20/03/23
    //                 // ProductionOutHeaderRec.Reset();
    //                 // ProductionOutHeaderRec.SetRange("Prod Date", Rec."Prod Date");
    //                 // ProductionOutHeaderRec.SetRange("Factory Code", Rec."Factory No.");
    //                 // ProductionOutHeaderRec.SetFilter(Type, '=%1', ProductionOutHeaderRec.Type::Saw);

    //                 // if not ProductionOutHeaderRec.FindSet() then
    //                 //     Error('Daily swing-out is not entered for this factory and date.');

    //                 //Get max lineno
    //                 HourlyProdLines1Rec.Reset();
    //                 HourlyProdLines1Rec.SetRange("No.", rec."No.");

    //                 if HourlyProdLines1Rec.FindLast() then
    //                     LineNo := HourlyProdLines1Rec."Line No.";

    //                 HourlyProdLinesRec.Reset();
    //                 HourlyProdLinesRec.SetRange("Prod Date", rec."Prod Date");
    //                 HourlyProdLinesRec.SetRange("Factory No.", rec."Factory No.");
    //                 HourlyProdLinesRec.SetRange(Type, rec.Type);
    //                 HourlyProdLinesRec.SetFilter("No.", '<>%1', rec."No.");

    //                 if not HourlyProdLinesRec.FindSet() then begin

    //                     NavAppProdPlanLinesRec.Reset();
    //                     NavAppProdPlanLinesRec.SetRange("PlanDate", rec."Prod Date");
    //                     NavAppProdPlanLinesRec.SetRange("Factory No.", rec."Factory No.");
    //                     NavAppProdPlanLinesRec.SetCurrentKey("Style No.", "Resource No.");
    //                     NavAppProdPlanLinesRec.Ascending(true);

    //                     if NavAppProdPlanLinesRec.FindSet() then begin

    //                         repeat
    //                             WorkCenrterRec.Reset();
    //                             WorkCenrterRec.SetRange("No.", NavAppProdPlanLinesRec."Resource No.");
    //                             WorkCenrterRec.FindSet();

    //                             if (StyleNo <> NavAppProdPlanLinesRec."Style No.") or (ResourceNo <> NavAppProdPlanLinesRec."Resource No.") then begin

    //                                 LineNo += 1;
    //                                 HourlyProdLinesRec.Init();
    //                                 HourlyProdLinesRec."No." := rec."No.";
    //                                 HourlyProdLinesRec."Line No." := LineNo;
    //                                 HourlyProdLinesRec."Style Name" := NavAppProdPlanLinesRec."Style Name";
    //                                 HourlyProdLinesRec."Style No." := NavAppProdPlanLinesRec."Style No.";
    //                                 HourlyProdLinesRec."Work Center Seq No" := WorkCenrterRec."Work Center Seq No";
    //                                 HourlyProdLinesRec.Insert();
    //                                 StyleNo := NavAppProdPlanLinesRec."Style No.";
    //                                 ResourceNo := NavAppProdPlanLinesRec."Resource No.";

    //                             end;

    //                             //Mihiranga 2023/03/29
    //                             HourlyProdLines1Rec.Reset();
    //                             HourlyProdLines1Rec.SetRange("No.", rec."No.");
    //                             HourlyProdLines1Rec.SetRange("Prod Date", rec."Prod Date");
    //                             HourlyProdLines1Rec.SetRange("Factory No.", rec."Factory No.");
    //                             HourlyProdLines1Rec.SetFilter(Item, '=%1', 'PASS PCS');
    //                             HourlyProdLines1Rec.SetRange("Style No.", NavAppProdPlanLinesRec."Style No.");
    //                             HourlyProdLines1Rec.SetRange("Work Center Name", NavAppProdPlanLinesRec."Resource No.");
    //                             if HourlyProdLines1Rec.FindFirst() then begin
    //                                 //Do nothing when record found
    //                             end
    //                             else begin
    //                                 LineNo += 1;

    //                                 HourlyProdLinesRec.Init();
    //                                 HourlyProdLinesRec."No." := rec."No.";
    //                                 HourlyProdLinesRec."Line No." := LineNo;
    //                                 HourlyProdLinesRec."Factory No." := rec."Factory No.";
    //                                 HourlyProdLinesRec."Prod Date" := rec."Prod Date";
    //                                 HourlyProdLinesRec.Type := rec.Type;
    //                                 HourlyProdLinesRec."Work Center No." := NavAppProdPlanLinesRec."Resource No.";
    //                                 HourlyProdLinesRec."Style No." := NavAppProdPlanLinesRec."Style No.";
    //                                 HourlyProdLinesRec."Work Center Name" := WorkCenrterRec.Name;
    //                                 HourlyProdLinesRec."Work Center Seq No" := WorkCenrterRec."Work Center Seq No";
    //                                 HourlyProdLinesRec.Item := 'PASS PCS';
    //                                 HourlyProdLinesRec.Insert();

    //                                 LineNo += 1;

    //                                 HourlyProdLinesRec.Init();
    //                                 HourlyProdLinesRec."No." := rec."No.";
    //                                 HourlyProdLinesRec."Line No." := LineNo;
    //                                 HourlyProdLinesRec."Factory No." := rec."Factory No.";
    //                                 HourlyProdLinesRec."Prod Date" := rec."Prod Date";
    //                                 HourlyProdLinesRec.Type := rec.Type;
    //                                 HourlyProdLinesRec."Work Center No." := NavAppProdPlanLinesRec."Resource No.";
    //                                 HourlyProdLinesRec."Style No." := NavAppProdPlanLinesRec."Style No.";
    //                                 HourlyProdLinesRec."Work Center Name" := WorkCenrterRec.Name;
    //                                 HourlyProdLinesRec."Work Center Seq No" := WorkCenrterRec."Work Center Seq No";
    //                                 HourlyProdLinesRec.Item := 'DEFECT PCS';
    //                                 HourlyProdLinesRec.Insert();

    //                                 LineNo += 1;

    //                                 HourlyProdLinesRec.Init();
    //                                 HourlyProdLinesRec."No." := rec."No.";
    //                                 HourlyProdLinesRec."Line No." := LineNo;
    //                                 HourlyProdLinesRec."Factory No." := rec."Factory No.";
    //                                 HourlyProdLinesRec."Prod Date" := rec."Prod Date";
    //                                 HourlyProdLinesRec.Type := rec.Type;
    //                                 HourlyProdLinesRec."Style No." := NavAppProdPlanLinesRec."Style No.";
    //                                 HourlyProdLinesRec."Work Center No." := NavAppProdPlanLinesRec."Resource No.";
    //                                 HourlyProdLinesRec."Work Center Name" := WorkCenrterRec.Name;
    //                                 HourlyProdLinesRec."Work Center Seq No" := WorkCenrterRec."Work Center Seq No";
    //                                 HourlyProdLinesRec.Item := 'DHU';
    //                                 HourlyProdLinesRec.Insert();
    //                             end;
    //                         until NavAppProdPlanLinesRec.Next() = 0;

    //                         //Add Sub totals
    //                         LineNo += 1;
    //                         HourlyProdLinesRec.Init();
    //                         HourlyProdLinesRec."No." := rec."No.";
    //                         HourlyProdLinesRec."Line No." := LineNo;
    //                         HourlyProdLinesRec."Style Name" := 'PASS PCS (Total)';
    //                         HourlyProdLinesRec."Work Center Seq No" := 100;
    //                         HourlyProdLinesRec.Insert();

    //                         LineNo += 1;
    //                         HourlyProdLinesRec.Init();
    //                         HourlyProdLinesRec."No." := rec."No.";
    //                         HourlyProdLinesRec."Line No." := LineNo;
    //                         HourlyProdLinesRec."Style Name" := 'DEFECT PCS (Total)';
    //                         HourlyProdLinesRec."Work Center Seq No" := 101;
    //                         HourlyProdLinesRec.Insert();

    //                         LineNo += 1;
    //                         HourlyProdLinesRec.Init();
    //                         HourlyProdLinesRec."No." := rec."No.";
    //                         HourlyProdLinesRec."Line No." := LineNo;
    //                         HourlyProdLinesRec."Style Name" := 'DHU (Total)';
    //                         HourlyProdLinesRec."Work Center Seq No" := 102;
    //                         HourlyProdLinesRec.Insert();


    //                     end;
    //                 end
    //                 else
    //                     Message('Another entry with same Date/Factory/Type exists.');

    //             end;
    //         }

    //         // action(Delete)
    //         // {
    //         //     trigger OnAction()
    //         //     var
    //         //         HourlyLineRec: Record "Hourly Production Lines";
    //         //         NavRec: Record "NavApp Prod Plans Details";

    //         //     begin
    //         //         // HourlyLineRec.Reset();
    //         //         // HourlyLineRec.SetRange("No.", DocumentNo);
    //         //         // HourlyLineRec.SetRange("Line No.", LineNO);
    //         //         // if HourlyLineRec.FindFirst() then begin
    //         //         //     HourlyLineRec.Delete();

    //         //         NavRec.Reset();
    //         //         NavRec.SetRange("No.", DocumentNo);
    //         //         NavRec.SetRange("Style No.", LineNO);
    //         //         if NavRec.FindFirst() then
    //         //             NavRec.Delete();
    //         //     end;

    //         // }


    //     }
    // }


    trigger OnDeleteRecord(): Boolean
    var
        HourlyProdLinesRec: Record "Hourly Production Lines";
        UserRec: Record "User Setup";
        ProdOutHeaderRec: Record ProductionOutHeader;
    begin
        Error('You are not authorized to delete this record.');

        // //Check whether production updated or not
        // if rec.Type = rec.Type::Sewing then begin
        //     ProdOutHeaderRec.Reset();
        //     ProdOutHeaderRec.SetRange("Prod Date", rec."Prod Date");
        //     ProdOutHeaderRec.SetRange("Factory Code", rec."Factory No.");
        //     ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Saw);
        //     ProdOutHeaderRec.SetFilter("Prod Updated", '=%1', 1);
        //     if ProdOutHeaderRec.FindSet() then
        //         Error('Production updated against Date : %1 , Factory : %2 has been updates. You cannot delete this entry.', rec."Prod Date", rec."Factory Name");
        // end;

        // UserRec.Reset();
        // UserRec.Get(UserId);
        // if UserRec."Factory Code" <> '' then begin
        //     if (UserRec."Factory Code" <> rec."Factory No.") then
        //         Error('You are not authorized to delete this record.');
        // end
        // else
        //     Error('You are not authorized to delete records.');

        // HourlyProdLinesRec.Reset();
        // HourlyProdLinesRec.SetRange("No.", rec."No.");
        // if HourlyProdLinesRec.FindSet() then
        //     HourlyProdLinesRec.DeleteAll();
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
        else begin
            if (UserRec."Factory Code" = '') then begin
                Error('Factory not assigned for the user.');
                EditableGB := false;
            end
            else
                EditableGB := true;
        end;

        EditableGB := false;
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
        else begin
            if (UserRec."Factory Code" = '') then begin
                Error('Factory not assigned for the user.');
                EditableGB := false;
            end
            else
                EditableGB := true;
        end;

        EditableGB := false;
    end;


    var
        EditableGB: Boolean;
}