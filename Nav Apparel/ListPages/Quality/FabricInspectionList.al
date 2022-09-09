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
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        FabricInspectionLineRec: Record FabricInspectionLine1;
    begin
        FabricInspectionLineRec.reset();
        FabricInspectionLineRec.SetRange("InsNo.", "InsNo.");
        FabricInspectionLineRec.DeleteAll();
    end;
}