page 50799 "Workers Card"
{
    PageType = Card;
    SourceTable = Workers;
    Caption = 'Workers';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Worker Name"; rec."Worker Name")
                {
                    ApplicationArea = All;
                }

                field("Worker Type"; rec."Worker Type")
                {
                    ApplicationArea = All;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}