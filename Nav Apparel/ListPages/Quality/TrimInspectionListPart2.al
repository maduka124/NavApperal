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
                field("PurchRecNo."; rec."PurchRecNo.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'GRN No';
                }

                field("Line No"; rec."Line No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Seq No';
                }

                field("Main Category Name"; rec."Main Category Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Main Category';
                }

                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Item';
                }

                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Color';
                }

                field(Size; rec.Size)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Article; rec.Article)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Dimension; rec.Dimension)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Unit Name"; rec."Unit Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Unit';
                }

                field("GRN Qty"; rec."GRN Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sample Qty"; rec."Sample Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Accept; rec.Accept)
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    var
                    begin
                        rec.Reject := rec."Sample Qty" - rec.Accept;
                        if rec.Reject > rec.RejectLevel then
                            rec.Status := rec.Status::Fail
                        else
                            rec.Status := rec.Status::Pass;

                        SetStatus();
                    end;
                }

                field(Reject; rec.Reject)
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    var
                    begin
                        rec.Accept := rec."Sample Qty" - rec.Reject;
                        if rec.Reject > rec.RejectLevel then
                            rec.Status := rec.Status::Fail
                        else
                            rec.Status := rec.Status::Pass;

                        SetStatus();
                    end;
                }

                field(Status; rec.Status)
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
        TrimInsRec.SetRange("PurchRecNo.", rec."PurchRecNo.");
        Status := true;

        if TrimInsRec.FindSet() then begin
            repeat
                if (TrimInsRec.Status = TrimInsRec.Status::Fail) or (TrimInsRec.Status = TrimInsRec.Status::Blank) then
                    Status := false;
            until TrimInsRec.Next() = 0;

            //Update GRN 'TrimInspected' status
            PurchRec.Reset();
            PurchRec.SetRange("No.", rec."PurchRecNo.");
            PurchRec.FindSet();

            if Status = true then
                PurchRec.ModifyAll("Trim Inspected", true)
            else
                PurchRec.ModifyAll("Trim Inspected", false);

        end;

    end;
}