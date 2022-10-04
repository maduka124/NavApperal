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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Worker Name"; "Worker Name")
                {
                    ApplicationArea = All;
                }

                field("Worker Type"; "Worker Type")
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}