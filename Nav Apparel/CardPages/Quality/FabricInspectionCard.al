page 50561 "Fabric Inspection Card"
{
    PageType = Card;
    SourceTable = FabricInspection;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("InsNo."; "InsNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Fab. Ins. No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange(Name, "Buyer Name");
                        if BuyerRec.FindSet() then
                            "Buyer No." := BuyerRec."No.";
                    end;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasRec: Record "Style Master";
                        AssoRec: Record AssorColorSizeRatio;
                        StyleColorRec: Record StyleColor;
                        Color: Code[20];
                    begin

                        StyleMasRec.Reset();
                        StyleMasRec.SetRange("Style No.", "Style Name");
                        if StyleMasRec.FindSet() then
                            "Style No" := StyleMasRec."No.";

                        CurrPage.Update();

                        //Deleet old recorsd
                        StyleColorRec.Reset();
                        StyleColorRec.DeleteAll();

                        //Get Colors for the style
                        AssoRec.Reset();
                        AssoRec.SetCurrentKey("Style No.", "Colour Name");
                        AssoRec.SetRange("Style No.", "Style No");
                        AssoRec.SetFilter("Colour Name", '<>%1', '*');

                        if AssoRec.FindSet() then begin
                            repeat
                                if Color <> AssoRec."Colour No" then begin
                                    StyleColorRec.Init();
                                    StyleColorRec."Color No." := AssoRec."Colour No";
                                    StyleColorRec.Color := AssoRec."Colour Name";
                                    StyleColorRec.Insert();
                                    Color := AssoRec."Colour No";
                                end;
                            until AssoRec.Next() = 0;
                        end;

                    end;
                }

                field(Scale; Scale)
                {
                    ApplicationArea = All;
                }

                field("Inspection Stage"; "Inspection Stage")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        InsStageRec: Record InspectionStage;
                    begin
                        InsStageRec.Reset();
                        InsStageRec.SetRange("Inspection Stage", "Inspection Stage");
                        if InsStageRec.FindSet() then
                            "Inspection Stage No." := InsStageRec."No.";
                    end;
                }

                field(Color; Color)
                {
                    ApplicationArea = All;
                    Caption = 'GMT Color ';

                    trigger OnValidate()
                    var
                        ColourRec: Record StyleColor;
                    begin
                        ColourRec.Reset();
                        ColourRec.SetRange(Color, Color);
                        if ColourRec.FindSet() then
                            "Color No." := ColourRec."Color No.";
                    end;
                }

                field("Total Fab. Rec. YDS"; "Total Fab. Rec. YDS")
                {
                    ApplicationArea = All;
                }

                field("Roll No"; "Roll No")
                {
                    ApplicationArea = All;
                }

                field("Batch No"; "Batch No")
                {
                    ApplicationArea = All;
                }

                field("TKT Length"; "TKT Length")
                {
                    ApplicationArea = All;
                }

                field("TKT Width"; "TKT Width")
                {
                    ApplicationArea = All;
                }

                field("Actual Length"; "Actual Length")
                {
                    ApplicationArea = All;
                }

                field("Actual Width"; "Actual Width")
                {
                    ApplicationArea = All;
                }

                field("Face Seal Start"; "Face Seal Start")
                {
                    ApplicationArea = All;
                }
                field("Face Seal End"; "Face Seal End")
                {
                    ApplicationArea = All;
                }

                field("Length Wise Colour Shading"; "Length Wise Colour Shading")
                {
                    ApplicationArea = All;
                }

                field("Width Wise Colour Shading"; "Width Wise Colour Shading")
                {
                    ApplicationArea = All;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
            }

            group("Calculate Defects")
            {
                part("Fabric Inspection ListPart"; "Fabric Inspection ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "InsNo." = FIELD("InsNo.");
                }
            }


            group("4 Point Details")
            {
                field("1 Point (Up to 3 inches)"; "1 Point (Up to 3 inches)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("2 Point (Up to 3-6 inches)"; "2 Point (Up to 3-6 inches)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("3 Point (Up to 6-9 inches)"; "3 Point (Up to 6-9 inches)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("4 Point (Above 9 inches) "; "4 Point (Above 9 inches) ")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("1 Point"; "1 Point")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("2 Point"; "2 Point")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("3 Point "; "3 Point ")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("4 Point"; "4 Point")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Points per 100 SQ Yds 1"; "Points per 100 SQ Yds 1")
                {
                    ApplicationArea = All;
                    Caption = '1 Point (Up to 3 Inches)';
                    Editable = false;
                }

                field("Points per 100 SQ Yds 2"; "Points per 100 SQ Yds 2")
                {
                    ApplicationArea = All;
                    Caption = '2 Point (Between 3 -6 Inches)';
                    Editable = false;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'StrongAccent';
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        FabricInspectionLineRec: Record FabricInspectionLine;
    begin
        FabricInspectionLineRec.reset();
        FabricInspectionLineRec.SetRange("InsNo.", "InsNo.");
        FabricInspectionLineRec.DeleteAll();
    end;


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Ins Nos.", xRec."InsNo.", "InsNo.") THEN BEGIN
            NoSeriesMngment.SetSeries("InsNo.");
            EXIT(TRUE);
        END;
    end;

}