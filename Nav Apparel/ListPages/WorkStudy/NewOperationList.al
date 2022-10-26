page 50455 "New Operation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "New Operation";
    CardPageId = "New Operation Card";
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

                field(Description; Description)
                {
                    ApplicationArea = All;
                }

                field("Item Type Name"; "Item Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item Type';
                }

                field("Garment Part Name"; "Garment Part Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Part';
                }
                field(Code; Code)
                {
                    ApplicationArea = All;
                }

                field(SMV; SMV)
                {
                    ApplicationArea = All;
                }

                field("Target Per Hour"; "Target Per Hour")
                {
                    ApplicationArea = All;
                }

                field("Seam Length"; "Seam Length")
                {
                    ApplicationArea = All;
                }

                field(Grade; Grade)
                {
                    ApplicationArea = All;
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }

                field("Machine Name"; "Machine Name")
                {
                    ApplicationArea = All;
                    Caption = 'Machine';
                }
            }
        }
    }
}