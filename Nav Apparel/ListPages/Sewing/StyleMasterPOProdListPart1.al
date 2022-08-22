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
                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Order Qty';
                }

                field("Cut Out Qty"; "Cut Out Qty")
                {
                    ApplicationArea = All;
                }

                field("Emb In Qty"; "Emb In Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Embroidary In Qty';
                }

                field("Emb Out Qty"; "Emb Out Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Embroidary Out Qty';
                }

                field("Print In Qty"; "Print In Qty")
                {
                    ApplicationArea = All;
                }

                field("Print Out Qty"; "Print Out Qty")
                {
                    ApplicationArea = All;
                }

                field("Sawing In Qty"; "Sawing In Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Sewing In Qty';
                }

                field("Sawing Out Qty"; "Sawing Out Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Sewing Out Qty';
                }

                field("Wash In Qty"; "Wash In Qty")
                {
                    ApplicationArea = All;
                }

                field("Wash Out Qty"; "Wash Out Qty")
                {
                    ApplicationArea = All;
                }

                field("Finish Qty"; "Finish Qty")
                {
                    ApplicationArea = All;
                }
                field("Shipped Qty"; "Shipped Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}