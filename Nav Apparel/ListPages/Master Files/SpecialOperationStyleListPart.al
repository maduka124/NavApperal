page 71012724 "SpecialOperationStyle Listpart"
{
    PageType = ListPart;
    SourceTable = "Special Operation Style";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Special Operation No';
                }

                field("Special Operation Name"; "Special Operation Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}