page 50512 "StyleMaster PO Prod ListPart 1"
{
    PageType = ListPart;
    SourceTable = "Style Master PO";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Order Qty';
                }

                field("Cut Out Qty"; rec."Cut Out Qty")
                {
                    ApplicationArea = All;
                }

                field("Emb In Qty"; rec."Emb In Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Embroidary In Qty';
                }

                field("Emb Out Qty"; rec."Emb Out Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Embroidary Out Qty';
                }

                field("Print In Qty"; rec."Print In Qty")
                {
                    ApplicationArea = All;
                }

                field("Print Out Qty"; rec."Print Out Qty")
                {
                    ApplicationArea = All;
                }

                field("Sawing In Qty"; rec."Sawing In Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Sewing In Qty';
                }

                field("Sawing Out Qty"; rec."Sawing Out Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Sewing Out Qty';
                }

                field("Wash In Qty"; rec."Wash In Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Send Qty';
                }

                field("Wash Out Qty"; rec."Wash Out Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Received Qty';
                }

                field("Finish Qty"; rec."Finish Qty")
                {
                    ApplicationArea = All;
                }
                field("Shipped Qty"; rec."Shipped Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}