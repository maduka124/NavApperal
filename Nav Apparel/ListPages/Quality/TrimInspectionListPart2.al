page 50573 "Trim Inspection ListPart2"
{
    PageType = ListPart;
    SourceTable = TrimInspectionLine;
    SourceTableView = sorting("PurchRecNo.", "Line No");
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("PurchRecNo."; "PurchRecNo.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'GRN No';
                }

                field("Line No"; "Line No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Seq No';
                }

                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Main Category';
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Item';
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Color';
                }

                field(Size; Size)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Article; Article)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Dimension; Dimension)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Unit Name"; "Unit Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Unit';
                }

                field("GRN Qty"; "GRN Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sample Qty"; "Sample Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Accept; Accept)
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    var
                    begin
                        Reject := "Sample Qty" - Accept;
                        if Reject > RejectLevel then
                            Status := Status::Fail
                        else
                            Status := Status::Pass;

                        SetStatus();
                    end;
                }

                field(Reject; Reject)
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    var
                    begin
                        Accept := "Sample Qty" - Reject;
                        if Reject > RejectLevel then
                            Status := Status::Fail
                        else
                            Status := Status::Pass;

                        SetStatus();
                    end;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    procedure SetStatus()
    var
        TrimInsRec: Record TrimInspectionLine;
        PurchRec: Record "Purch. Rcpt. Header";
        Status: Boolean;
    begin

        CurrPage.Update();

        TrimInsRec.Reset();
        TrimInsRec.SetRange("PurchRecNo.", "PurchRecNo.");
        Status := true;

        if TrimInsRec.FindSet() then begin
            repeat
                if (TrimInsRec.Status = TrimInsRec.Status::Fail) or (TrimInsRec.Status = TrimInsRec.Status::Blank) then
                    Status := false;
            until TrimInsRec.Next() = 0;

            //Update GRN 'TrimInspected' status
            PurchRec.Reset();
            PurchRec.SetRange("No.", "PurchRecNo.");
            PurchRec.FindSet();

            if Status = true then
                PurchRec.ModifyAll("Trim Inspected", true)
            else
                PurchRec.ModifyAll("Trim Inspected", false);

        end;

    end;
}