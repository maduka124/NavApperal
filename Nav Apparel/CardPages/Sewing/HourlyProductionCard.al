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
                field("Prod Date"; rec."Prod Date")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin

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
                    begin

                        Users.Reset();
                        Users.SetRange("User ID", UserId());
                        Users.FindSet();

                        LocationRec.Reset();
                        LocationRec.SetRange("code", Users."Factory Code");

                        if Page.RunModal(50517, LocationRec) = Action::LookupOK then begin
                            rec."Factory No." := LocationRec.Code;
                            rec."Factory Name" := LocationRec.Name;
                        end;

                    end;
                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }
            }

            group(" ")
            {
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
                    HourlyProdLinesRec: Record "Hourly Production Lines";
                    HourlyProdLines1Rec: Record "Hourly Production Lines";
                    NavAppProdPlanLinesRec: Record "NavApp Prod Plans Details";
                    WorkCenrterRec: Record "Work Center";
                    i: Integer;
                    LineNo: Integer;
                    StyleNo: code[20];
                begin

                    //Validate Date
                    if rec."Prod Date" < WorkDate() then
                        Error('Cannot enter production for previous dates.');

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
                                WorkCenrterRec.FindSet();

                                if StyleNo <> NavAppProdPlanLinesRec."Style No." then begin

                                    LineNo += 1;
                                    HourlyProdLinesRec.Init();
                                    HourlyProdLinesRec."No." := rec."No.";
                                    HourlyProdLinesRec."Line No." := LineNo;
                                    HourlyProdLinesRec."Style Name" := NavAppProdPlanLinesRec."Style Name";
                                    HourlyProdLinesRec."Style No." := NavAppProdPlanLinesRec."Style No.";
                                    HourlyProdLinesRec.Insert();
                                    StyleNo := NavAppProdPlanLinesRec."Style No.";

                                end;

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
                                HourlyProdLinesRec.Item := 'DHU';
                                HourlyProdLinesRec.Insert();

                            until NavAppProdPlanLinesRec.Next() = 0;

                            //Add Sub totals
                            LineNo += 1;
                            HourlyProdLinesRec.Init();
                            HourlyProdLinesRec."No." := rec."No.";
                            HourlyProdLinesRec."Line No." := LineNo;
                            HourlyProdLinesRec."Style Name" := 'PASS PCS (Total)';
                            HourlyProdLinesRec.Insert();

                            LineNo += 1;
                            HourlyProdLinesRec.Init();
                            HourlyProdLinesRec."No." := rec."No.";
                            HourlyProdLinesRec."Line No." := LineNo;
                            HourlyProdLinesRec."Style Name" := 'DEFECT PCS (Total)';
                            HourlyProdLinesRec.Insert();

                            LineNo += 1;
                            HourlyProdLinesRec.Init();
                            HourlyProdLinesRec."No." := rec."No.";
                            HourlyProdLinesRec."Line No." := LineNo;
                            HourlyProdLinesRec."Style Name" := 'DHU (Total)';
                            HourlyProdLinesRec.Insert();


                        end;

                    end
                    else
                        Message('Another entry with same Date/Factory/Type exists.');

                end;
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        HourlyProdLinesRec: Record "Hourly Production Lines";
    begin
        HourlyProdLinesRec.SetRange("No.", rec."No.");
        HourlyProdLinesRec.DeleteAll();
    end;
}