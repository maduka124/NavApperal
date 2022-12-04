page 51004 Shade
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Shade;
    CardPageId = "Shade Card";
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
                    Caption = 'Shade No';
                }

                field(Shade; Rec.Shade)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}