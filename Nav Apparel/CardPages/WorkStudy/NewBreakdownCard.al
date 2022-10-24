page 50459 "New Breakdown Card"
{
    PageType = Card;
    SourceTable = "New Breakdown";
    Caption = 'New Breakdown';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                    begin
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", "Style Name");
                        if StyleMasterRec.FindSet() then begin
                            "Style No." := StyleMasterRec."No.";
                            "Buyer No." := StyleMasterRec."Buyer No.";
                            "Season No." := StyleMasterRec."Season No.";
                            "Garment Type No." := StyleMasterRec."Garment Type No.";
                            "Buyer Name" := StyleMasterRec."Buyer Name";
                            "Season Name" := StyleMasterRec."Season Name";
                            "Garment Type Name" := StyleMasterRec."Garment Type Name";
                        end;
                        //Set_Status();
                        "Style Stage" := 'COSTING';
                    end;
                }

                field("Season Name"; "Season Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Season';
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field(Description; Description)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Item Type Name"; "Item Type Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Item Type';

                    trigger OnValidate()
                    var
                        ItemRec: Record "Item Type";
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange("Item Type Name", "Item Type Name");
                        if ItemRec.FindSet() then
                            "Item Type No." := ItemRec."No.";
                    end;
                }

                field("Garment Part Name"; "Garment Part Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Garment Part';

                    trigger OnValidate()
                    var
                        GarmentPartRec: Record GarmentPart;
                        NewBrOpLine: Record "New Breakdown Op Line1";
                        NewOpLine: Record "New Operation";
                        LineNo: Integer;
                    begin

                        GarmentPartRec.Reset();
                        GarmentPartRec.SetRange(Description, "Garment Part Name");
                        if GarmentPartRec.FindSet() then
                            "Garment Part No." := GarmentPartRec."No.";

                        //delete list table
                        NewBrOpLine.Reset();
                        NewBrOpLine.SetRange("NewBRNo.", "No.");
                        NewBrOpLine.DeleteAll();

                        NewOpLine.Reset();
                        NewOpLine.SetRange("Item Type No.", "Item Type No.");
                        NewOpLine.SetRange("Garment Part No.", GarmentPartRec."No.");

                        if NewOpLine.FindSet() then begin

                            repeat

                                //Get max line no
                                LineNo := 0;
                                NewBrOpLine.Reset();
                                NewBrOpLine.SetRange("NewBRNo.", "No.");

                                if NewBrOpLine.FindLast() then
                                    LineNo := NewBrOpLine."LineNo.";

                                NewBrOpLine.Init();
                                NewBrOpLine."NewBRNo." := "No.";
                                NewBrOpLine."LineNo." := LineNo + 1;
                                NewBrOpLine."Item Type No." := NewOpLine."Item Type No.";
                                NewBrOpLine."Item Type Name" := NewOpLine."Item Type Name";
                                NewBrOpLine."Garment Part No." := NewOpLine."Garment Part No.";
                                NewBrOpLine."Garment Part Name" := NewOpLine."Garment Part Name";
                                NewBrOpLine.Code := NewOpLine.Code;
                                NewBrOpLine.Description := NewOpLine.Description;
                                NewBrOpLine."Machine No." := NewOpLine."Machine No.";
                                NewBrOpLine."Machine Name" := NewOpLine."Machine Name";
                                NewBrOpLine.SMV := NewOpLine.SMV;
                                NewBrOpLine."Target Per Hour" := NewOpLine."Target Per Hour";
                                NewBrOpLine.Grade := NewOpLine.Grade;
                                NewBrOpLine."Department No." := NewOpLine."Department No.";
                                NewBrOpLine."Department Name" := NewOpLine."Department Name";
                                NewBrOpLine."Created User" := UserId;
                                NewBrOpLine.Insert();

                            until NewOpLine.Next = 0;

                        end;
                    end;

                }

                field("Style Stage"; "Style Stage")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total SMV"; "Total SMV")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Machine; Machine)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Machine SMV';
                }

                field(Manual; Manual)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Manual SMV';
                }
            }

            group("New Operations")
            {
                part("New Breakdown Op Listpart1"; "New Breakdown Op Listpart1")
                {
                    ApplicationArea = All;
                    SubPageLink = "NewBRNo." = FIELD("No.");
                    Caption = ' ';
                }
            }

            group("Breakdown")
            {
                part("New Breakdown Op Listpart2"; "New Breakdown Op Listpart2")
                {
                    ApplicationArea = All;
                    SubPageLink = "No." = FIELD("No.");
                    Caption = ' ';
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action("Insert Header")
            {
                ApplicationArea = All;
                Image = NewRow;

                trigger OnAction();
                var
                    NewBreakOpLine2Rec: Record "New Breakdown Op Line2";
                    LineNo: Integer;
                begin

                    NewBreakOpLine2Rec.Reset();
                    NewBreakOpLine2Rec.SetRange("No.", "No.");
                    NewBreakOpLine2Rec.SetRange(Description, "Garment Part Name");
                    NewBreakOpLine2Rec.SetFilter(LineType, '=%1', 'H');

                    if not NewBreakOpLine2Rec.FindSet() then begin

                        //Get max line no
                        LineNo := 0;
                        NewBreakOpLine2Rec.Reset();
                        NewBreakOpLine2Rec.SetRange("No.", "No.");

                        if NewBreakOpLine2Rec.FindLast() then
                            LineNo := NewBreakOpLine2Rec."Line No.";

                        NewBreakOpLine2Rec.Init();
                        NewBreakOpLine2Rec."No." := "No.";
                        NewBreakOpLine2Rec."Line No." := LineNo + 1;
                        NewBreakOpLine2Rec."Line Position" := LineNo + 1;
                        NewBreakOpLine2Rec.Description := "Garment Part Name";
                        NewBreakOpLine2Rec.LineType := 'H';
                        NewBreakOpLine2Rec.Barcode := NewBreakOpLine2Rec.Barcode::No;
                        NewBreakOpLine2Rec.Insert();

                    end;

                end;
            }

            action("Copy Breakdown")
            {
                ApplicationArea = All;
                Image = NewRow;

                trigger OnAction();
                var
                    CopyBreakRec: page "Copy Breakdown Card";
                begin

                    Clear(CopyBreakRec);
                    CopyBreakRec.LookupMode(true);
                    //CopyBreakRec.PassParameters("Buyer No.", "Dependency No.");
                    CopyBreakRec.RunModal();
                    //CurrPage.Update();

                end;
            }
        }
    }

    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."NEWBR Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnOpenPage()
    var
        StyleRec: Record "Style Master";
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        StyleMasterRec: Record "Style Master";
    begin

        if StyleNameGB <> '' then begin
            "No." := NoSeriesManagementCode.GetNextNo('NEWBR Nos', WorkDate(), true);

            StyleMasterRec.Reset();
            StyleMasterRec.SetRange("Style No.", StyleNameGB);

            if StyleMasterRec.FindSet() then begin
                "Style No." := StyleMasterRec."Style No.";
                "Style Name" := StyleNameGB;
                "Buyer No." := StyleMasterRec."Buyer No.";
                "Season No." := StyleMasterRec."Season No.";
                "Garment Type No." := StyleMasterRec."Garment Type No.";
                "Buyer Name" := StyleMasterRec."Buyer Name";
                "Season Name" := StyleMasterRec."Season Name";
                "Garment Type Name" := StyleMasterRec."Garment Type Name";
                "Style Stage" := 'COSTING';
            end;

            CurrPage.Update();

        end;

        //Set_Status();

        // StyleRec.Reset();
        // StyleRec.SetRange("Style No.", "Style No.");
        // if StyleRec.FindSet() then begin

        //     if "Style Stage" = 'COSTING' then
        //         StyleRec.CostingSMV := "Total SMV"
        //     else
        //         if "Style Stage" = 'PRODUCTION' then
        //             StyleRec.ProductionSMV := "Total SMV"
        //         else
        //             if "Style Stage" = 'PLANNING' then
        //                 StyleRec.PlanningSMV := "Total SMV";

        //     StyleRec.Modify();

        // end;
    end;


    procedure Set_Status()
    var
        ProductionOutLineRec: Record ProductionOutLine;
        NavAppPlanningLinesRec: Record "NavApp Prod Plans Details";
    begin
        //Style Stage 
        ProductionOutLineRec.Reset();
        ProductionOutLineRec.SetRange("Style No.", "Style No.");

        if ProductionOutLineRec.FindSet() then
            "Style Stage" := 'PRODUCTION'
        else begin

            NavAppPlanningLinesRec.Reset();
            NavAppPlanningLinesRec.SetRange("Style No.", "Style No.");

            if NavAppPlanningLinesRec.FindSet() then
                "Style Stage" := 'PLANNING'
            else
                "Style Stage" := 'COSTING';
        end;

        CurrPage.Update();
    end;


    procedure PassParameters(StyleNamePara: Text[100]);
    var
    begin
        StyleNameGB := StyleNamePara;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        NewBrOpLine1Rec: Record "New Breakdown Op Line1";
        NewBrOpLine2Rec: Record "New Breakdown Op Line2";
    begin
        NewBrOpLine1Rec.Reset();
        NewBrOpLine1Rec.SetRange("NewBRNo.", "No.");
        NewBrOpLine1Rec.DeleteAll();

        NewBrOpLine2Rec.Reset();
        NewBrOpLine2Rec.SetRange("No.", "No.");
        NewBrOpLine2Rec.DeleteAll();
    end;

    var
        StyleNameGB: Text[100];
}