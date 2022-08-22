page 71012730 "Style Master Card"
{
    PageType = Card;
    SourceTable = "Style Master";
    Caption = 'Style Master';
    InsertAllowed = false;
    DeleteAllowed = false;

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
                    Caption = 'Style No';
                }

                field("Style No."; "Style No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style Name';
                }

                field("Store Name"; "Store Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Store';
                }

                field("Season Name"; "Season Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Season';
                }

                field("Brand Name"; "Brand Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Brand';
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Department';
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Garment Type Name"; "Garment Type Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Garment Type';
                }

                field("Order Qty"; "Order Qty")
                {
                    ApplicationArea = All;
                }

                field("CM Price (Doz)"; "CM Price (Doz)")
                {
                    ApplicationArea = All;
                }

                field(SMV; SMV)
                {
                    ApplicationArea = All;
                }

                field("Plan Efficiency %"; "Plan Efficiency %")
                {
                    ApplicationArea = All;
                }

                field(BPCD; BPCD)
                {
                    ApplicationArea = All;
                }

                // field("LC No/Contract"; "LC No/Contract")
                // {
                //     ApplicationArea = All;
                // }
            }

            group(" ")
            {
                part("SpecialOperationStyle Listpart"; "SpecialOperationStyle Listpart")
                {
                    ApplicationArea = All;
                    Caption = 'Special Operations';
                    SubPageLink = "Style No." = FIELD("No.");
                    Editable = false;
                }
            }

            group("")
            {
                part("Style Master PO ListPart"; "Style Master PO ListPart")
                {
                    ApplicationArea = All;
                    Caption = 'Order Details';
                    SubPageLink = "Style No." = FIELD("No.");
                }
            }

            group("  ")
            {
                field("PO Total"; "PO Total")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }


        area(FactBoxes)
        {
            part("Style Picture"; "BOM Picture FactBox")
            {
                ApplicationArea = All;
                Caption = 'Style Picture';
                SubPageLink = "No." = FIELD("No.");
                Editable = false;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        StyleMasterRec: Record "Style Master";
        StyleMasterPORec: Record "Style Master PO";
        Tot: BigInteger;
    begin
        if "Order Qty" = 0 then begin
            Error('Order quantity cannot be zero.');
        end;

        //Update Po Total         
        StyleMasterPORec.Reset();
        StyleMasterPORec.SetRange("Style No.", "No.");
        StyleMasterPORec.FindSet();

        repeat
            Tot += StyleMasterPORec.Qty;
        until StyleMasterPORec.Next() = 0;

        "PO Total" := Tot;
        CurrPage.Update();

        if "Order Qty" <> "PO Total" then begin
            Error('Order quantity should match PO total.');
        end;
    end;


    trigger OnOpenPage()
    var
        BOMEstimateCostRec: Record "BOM Estimate Cost";
        StyleMasterRec: Record "Style Master";
    begin
        BOMEstimateCostRec.Reset();
        BOMEstimateCostRec.SetCurrentKey("Style No.");
        BOMEstimateCostRec.SetRange("Style No.", "No.");

        if BOMEstimateCostRec.FindSet() then begin

            if Format("CM Price (Doz)") = '0' then
                "CM Price (Doz)" := BOMEstimateCostRec."CM Doz";

            // if SMV = 0.00 then
            //     SMV := BOMEstimateCostRec.SMV;

            if "Plan Efficiency %" = 0.00 then
                "Plan Efficiency %" := BOMEstimateCostRec."Project Efficiency.";

            CurrPage.Update();

        end;
    end;

    trigger OnDeleteRecord(): Boolean
    var
    begin
        if Status = Status::Confirmed then
            Error('Style already confirmed. Cannot delete.');
    end;
}