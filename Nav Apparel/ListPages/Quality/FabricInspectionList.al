page 50564 "Fabric Inspection List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FabricInspection;
    CardPageId = "Fabric Inspection Card";
    SourceTableView = sorting("InsNo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field(Color; rec.Color)
                {
                    ApplicationArea = All;
                }

                field(Scale; rec.Scale)
                {
                    ApplicationArea = All;
                }

                field("Inspection Stage"; rec."Inspection Stage")
                {
                    ApplicationArea = All;
                }

                field("Total Fab. Rec. YDS"; rec."Total Fab. Rec. YDS")
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
        FabricInspectionLineRec.SetRange("InsNo.", rec."InsNo.");
        FabricInspectionLineRec.DeleteAll();
    end;
}