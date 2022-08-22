page 50564 "Fabric Inspection List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FabricInspection;
    CardPageId = "Fabric Inspection Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field(Color; Color)
                {
                    ApplicationArea = All;
                }

                field(Scale; Scale)
                {
                    ApplicationArea = All;
                }

                field("Inspection Stage"; "Inspection Stage")
                {
                    ApplicationArea = All;
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
}