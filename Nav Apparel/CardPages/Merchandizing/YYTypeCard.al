page 50610 "YY Type Card"
{
    PageType = Card;
    SourceTable = "YY Type";
    Caption = 'YY Type';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'YY Type No';
                }

                field("YY Type Desc"; rec."YY Type Desc")
                {
                    ApplicationArea = All;
                    Caption = '';
                }
            }
        }
    }
}