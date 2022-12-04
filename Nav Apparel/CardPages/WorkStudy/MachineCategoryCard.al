page 50447 "Machine Category Card"
{
    PageType = Card;
    SourceTable = "Machine Category";
    Caption = 'Machine Category';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Category No';
                }

                field("Machine Category"; rec."Machine Category")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}