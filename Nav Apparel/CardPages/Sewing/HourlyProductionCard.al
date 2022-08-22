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
                field("Prod Date"; "Prod Date")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ShowMandatory = true;
                }

                field("Factory Name"; "Factory Name")
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
                            "Factory No." := LocationRec.Code;
                            "Factory Name" := LocationRec.Name;
                        end;

                    end;
                }

                field(Type; Type)
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

                    CurrPage.Update();
                    //Get max lineno
                    HourlyProdLines1Rec.Reset();
                    HourlyProdLines1Rec.SetRange("No.", "No.");

                    if HourlyProdLines1Rec.FindLast() then
                        LineNo := HourlyProdLines1Rec."Line No.";

                    HourlyProdLinesRec.Reset();
                    HourlyProdLinesRec.SetRange("Prod Date", "Prod Date");
                    HourlyProdLinesRec.SetRange("Factory No.", "Factory No.");
                    HourlyProdLinesRec.SetRange(Type, Type);

                    if not HourlyProdLinesRec.FindSet() then begin

                        NavAppProdPlanLinesRec.Reset();
                        NavAppProdPlanLinesRec.SetRange("PlanDate", "Prod Date");
                        NavAppProdPlanLinesRec.SetRange("Factory No.", "Factory No.");
                        NavAppProdPlanLinesRec.SetCurrentKey("Style No.");
                        NavAppProdPlanLinesRec.Ascending(true);

                        if NavAppProdPlanLinesRec.FindSet() then begin

                            repeat

                                WorkCenrterRec.Reset();
                                WorkCenrterRec.SetRange("No.", NavAppProdPlanLinesRec."Resource No.");
                                WorkCenrterRec.FindSet();

                                if StyleNo <> NavAppProdPlanLinesRec."Style No." then begin

                                    LineNo += 1;
                                    HourlyProdLinesRec.Init();
                                    HourlyProdLinesRec."No." := "No.";
                                    HourlyProdLinesRec."Line No." := LineNo;
                                    HourlyProdLinesRec."Style Name" := NavAppProdPlanLinesRec."Style Name";
                                    HourlyProdLinesRec.Insert();
                                    StyleNo := NavAppProdPlanLinesRec."Style No.";

                                end;

                                LineNo += 1;

                                HourlyProdLinesRec.Init();
                                HourlyProdLinesRec."No." := "No.";
                                HourlyProdLinesRec."Line No." := LineNo;
                                HourlyProdLinesRec."Factory No." := "Factory No.";
                                HourlyProdLinesRec."Prod Date" := "Prod Date";
                                HourlyProdLinesRec.Type := Type;
                                HourlyProdLinesRec."Work Center No." := NavAppProdPlanLinesRec."Resource No.";
                                HourlyProdLinesRec."Work Center Name" := WorkCenrterRec.Name;
                                HourlyProdLinesRec.Item := 'PASS PCS';
                                HourlyProdLinesRec.Insert();

                                LineNo += 1;

                                HourlyProdLinesRec.Init();
                                HourlyProdLinesRec."No." := "No.";
                                HourlyProdLinesRec."Line No." := LineNo;
                                HourlyProdLinesRec."Factory No." := "Factory No.";
                                HourlyProdLinesRec."Prod Date" := "Prod Date";
                                HourlyProdLinesRec.Type := Type;
                                HourlyProdLinesRec."Work Center No." := NavAppProdPlanLinesRec."Resource No.";
                                HourlyProdLinesRec."Work Center Name" := WorkCenrterRec.Name;
                                HourlyProdLinesRec.Item := 'DEFECT PCS';
                                HourlyProdLinesRec.Insert();

                                LineNo += 1;

                                HourlyProdLinesRec.Init();
                                HourlyProdLinesRec."No." := "No.";
                                HourlyProdLinesRec."Line No." := LineNo;
                                HourlyProdLinesRec."Factory No." := "Factory No.";
                                HourlyProdLinesRec."Prod Date" := "Prod Date";
                                HourlyProdLinesRec.Type := Type;
                                HourlyProdLinesRec."Work Center No." := NavAppProdPlanLinesRec."Resource No.";
                                HourlyProdLinesRec."Work Center Name" := WorkCenrterRec.Name;
                                HourlyProdLinesRec.Item := 'DHU';
                                HourlyProdLinesRec.Insert();

                            until NavAppProdPlanLinesRec.Next() = 0;

                            //Add Sub totals
                            LineNo += 1;
                            HourlyProdLinesRec.Init();
                            HourlyProdLinesRec."No." := "No.";
                            HourlyProdLinesRec."Line No." := LineNo;
                            HourlyProdLinesRec."Style Name" := 'PASS PCS (Total)';
                            HourlyProdLinesRec.Insert();

                            LineNo += 1;
                            HourlyProdLinesRec.Init();
                            HourlyProdLinesRec."No." := "No.";
                            HourlyProdLinesRec."Line No." := LineNo;
                            HourlyProdLinesRec."Style Name" := 'DEFECT PCS (Total)';
                            HourlyProdLinesRec.Insert();

                            LineNo += 1;
                            HourlyProdLinesRec.Init();
                            HourlyProdLinesRec."No." := "No.";
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
        HourlyProdLinesRec.SetRange("No.", "No.");
        HourlyProdLinesRec.DeleteAll();
    end;
}