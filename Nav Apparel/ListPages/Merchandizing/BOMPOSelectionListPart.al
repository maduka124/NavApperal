page 51034 "BOM PO Selection ListPart"
{
    PageType = ListPart;
    SourceTable = BOMPOSelection;
    SourceTableView = sorting("BOM No.", "Lot No.") order(ascending);
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Lot No';
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'PO No';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Mode; rec.Mode)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Ship Date"; rec."Ship Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Selection; rec.Selection)
                {
                    ApplicationArea = All;
                    Caption = 'Select';

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                        Calculate();
                        CurrPage.Update();
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // action("Calculate Qantity")
            // {
            //     ApplicationArea = All;
            //     Image = Calculate;

            //     trigger OnAction()
            //     var
            //         Total: Integer;
            //         BOMPOSelectionRec: Record BOMPOSelection;
            //         BOMRec: Record BOM;
            //         BOMLineEstimateRec: Record "BOM Line Estimate";
            //     begin
            //         Total := 0;
            //         BOMPOSelectionRec.Reset();
            //         BOMPOSelectionRec.SetRange("BOM No.", "BOM No.");
            //         BOMPOSelectionRec.SetRange(Selection, true);

            //         if BOMPOSelectionRec.FindSet() then begin
            //             repeat
            //                 Total += BOMPOSelectionRec.Qty;
            //             until BOMPOSelectionRec.Next() = 0;
            //         end;

            //         BOMRec.Reset();
            //         BOMRec.SetRange("No", "BOM No.");
            //         BOMRec.ModifyAll(Quantity, Total);

            //         //Update BOM Estimate Line Qty
            //         BOMLineEstimateRec.Reset();
            //         BOMLineEstimateRec.SetRange("No.", "BOM No.");
            //         BOMLineEstimateRec.ModifyAll("GMT Qty", Total);

            //         CurrPage.Update();
            //     end;
            // }
        }
    }

    procedure Calculate()
    var
        Total: Integer;
        BOMPOSelectionRec: Record BOMPOSelection;
        BOMRec: Record BOM;
        BOMLineEstimateRec: Record "BOM Line Estimate";

    begin

        Total := 0;
        BOMPOSelectionRec.Reset();
        BOMPOSelectionRec.SetRange("BOM No.", rec."BOM No.");
        BOMPOSelectionRec.SetRange(Selection, true);

        if BOMPOSelectionRec.FindSet() then begin
            repeat
                Total += BOMPOSelectionRec.Qty;
            until BOMPOSelectionRec.Next() = 0;
        end;

        BOMRec.Reset();
        BOMRec.SetRange("No", rec."BOM No.");
        BOMRec.ModifyAll(Quantity, Total);

        //Update BOM Estimate Line Qty
        BOMLineEstimateRec.Reset();
        BOMLineEstimateRec.SetRange("No.", rec."BOM No.");
        BOMLineEstimateRec.ModifyAll("GMT Qty", Total);

        CurrPage.Update();
    end;
}