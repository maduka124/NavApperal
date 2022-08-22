page 71012582 "AQL Card"
{
    PageType = Card;
    SourceTable = AQL;
    Caption = 'AQL';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("From Qty"; "From Qty")
                {
                    ApplicationArea = All;
                }

                field("To Qty"; "To Qty")
                {
                    ApplicationArea = All;
                }

                field("SMPL Qty"; "SMPL Qty")
                {
                    ApplicationArea = All;
                }

                field("Reject Qty"; "Reject Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}