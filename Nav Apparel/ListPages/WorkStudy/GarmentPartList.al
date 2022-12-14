page 50443 "Garment Part List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = GarmentPart;
    CardPageId = "Garment Part Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Part No';
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

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }

            }
        }
    }
}