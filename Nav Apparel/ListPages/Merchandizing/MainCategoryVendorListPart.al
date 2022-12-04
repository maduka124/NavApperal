page 71012746 "Main Category Vendor List part"
{
    PageType = ListPart;
    SourceTable = "Main Category Vendor";

    layout
    {
        area(Content)
        {
            repeater(General)
            {               
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category No';
                }

                field("Main Category Name"; rec."Main Category Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}