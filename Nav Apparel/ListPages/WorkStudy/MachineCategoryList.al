page 50446 "Machine Category List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Machine Category";
    CardPageId = "Machine Category Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Category No';
                }

                field("Machine Category";"Machine Category")
                {
                    ApplicationArea = All;
                }
            }
        }
    }    
}