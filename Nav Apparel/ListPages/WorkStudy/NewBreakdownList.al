page 50458 "New Breakdown"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "New Breakdown";
    CardPageId = "New Breakdown Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Season Name"; "Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field(Description; Description)
                {
                    ApplicationArea = All;
                }

                field("Garment Type Name"; "Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                }

                field("Total SMV"; "Total SMV")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


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
}