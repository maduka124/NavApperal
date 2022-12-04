page 51008 "Stich Gmt"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Stich Gmt";
    CardPageId = "Stich Gmt Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Stich Gmt No';
                }

                field("Stich Gmt Name"; Rec."Stich Gmt Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}