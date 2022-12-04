page 50943 "AQL Card"
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
                field("From Qty"; rec."From Qty")
                {
                    ApplicationArea = All;
                }

                field("To Qty";rec. "To Qty")
                {
                    ApplicationArea = All;
                }

                field("SMPL Qty";rec. "SMPL Qty")
                {
                    ApplicationArea = All;
                }

                field("Reject Qty"; rec."Reject Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}