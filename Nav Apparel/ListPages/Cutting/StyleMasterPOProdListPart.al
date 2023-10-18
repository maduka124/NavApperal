page 50354 "Style Master PO Prod ListPart"
{
    PageType = ListPart;
    SourceTable = "Style Master PO";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                }

                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field(Qty; Rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Order Qty';
                }

                field("Cut In Qty"; Rec."Cut In Qty")
                {
                    ApplicationArea = All;
                }

                field("Cut Out Qty"; Rec."Cut Out Qty")
                {
                    ApplicationArea = All;
                }

                field("Emb In Qty"; Rec."Emb In Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Embroidary In Qty';
                }

                field("Emb Out Qty"; Rec."Emb Out Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Embroidary Out Qty';
                }

                field("Print In Qty"; Rec."Print In Qty")
                {
                    ApplicationArea = All;
                }

                field("Print Out Qty"; Rec."Print Out Qty")
                {
                    ApplicationArea = All;
                }

                field("Sawing In Qty"; Rec."Sawing In Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Sewing In Qty';
                }

                field("Sawing Out Qty"; Rec."Sawing Out Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Sewing Out Qty';
                }

                field("Wash In Qty"; Rec."Wash In Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Send Qty';
                }

                field("Wash Out Qty"; Rec."Wash Out Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Received Qty';
                }

                field("Finish Qty"; Rec."Finish Qty")
                {
                    ApplicationArea = All;
                }
                field("Shipped Qty"; Rec."Shipped Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}