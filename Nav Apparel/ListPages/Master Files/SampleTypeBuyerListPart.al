page 71012734 "Sample Type Buyer List part"
{
    PageType = ListPart;
    SourceTable = "Sample Type Buyer";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Type No';
                }

                field("Sample Type Name"; "Sample Type Name")
                {
                    ApplicationArea = All;
                }

                field("Lead Time"; "Lead Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}