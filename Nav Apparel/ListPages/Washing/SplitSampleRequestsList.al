page 50819 "Split Sample Requests List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Washing Sample Requsition Line";
    SourceTableView = sorting("Split Status") order(ascending);
    CardPageId = "Job Creation Card";
    Caption = 'Split Sample Requests';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                }

                field("Req Date"; "Req Date")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Wash Plant Name"; "Wash Plant Name")
                {
                    ApplicationArea = All;
                    Caption = 'Washing Plant';
                }

                field(Buyer; Buyer)
                {
                    ApplicationArea = All;
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                }

                field("Fabric Description"; "Fabric Description")
                {
                    ApplicationArea = All;
                }

                field("Req Qty BW QC Pass"; "Req Qty BW QC Pass")
                {
                    ApplicationArea = All;
                    Caption = 'Qty';
                }

                field("BW QC Date"; "BW QC Date")
                {
                    ApplicationArea = All;
                    Caption = 'BW Quality Check Date';
                }

                field("Split Status"; "Split Status")
                {
                    ApplicationArea = All;
                }

                field("Washing Status"; "Washing Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}