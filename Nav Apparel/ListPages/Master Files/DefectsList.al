page 71012594 "Defects List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Defects;
    CardPageId = "Defects Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Defects No';
                }

                field(Defects; Defects)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}