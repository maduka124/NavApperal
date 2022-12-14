page 50429 "Sample Room List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sample Room";
    CardPageId = "Sample Room Card";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Sample Room No.";"Sample Room No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Room No';
                }

                field("Sample Room Name";"Sample Room Name")
                {
                    ApplicationArea = All;
                }
            }
        } 
    } 
}