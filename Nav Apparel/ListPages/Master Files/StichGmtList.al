page 71012646 "Stich Gmt"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Stich Gmt";
    CardPageId = "Stich Gmt Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Stich Gmt No';
                }

                field("Stich Gmt Name"; "Stich Gmt Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }   
}