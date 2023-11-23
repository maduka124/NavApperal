page 50105 "Style Transfer Card"
{
    Caption = 'Style Transfer Card';
    PageType = Card;
    SourceTable = "Style transfer Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = EditableGb;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Buyer Code"; Rec."Buyer Code")
                {
                    ApplicationArea = All;
                }
                field(Buyer; Rec.Buyer)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'From Buyer';
                }
                field("From Style Name"; Rec."From Style Name")
                {
                    ApplicationArea = All;
                }
                field(PO; Rec.PO)
                {
                    ApplicationArea = All;
                }
                field("From Lot"; Rec."From Lot")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        PurchRcLineRec: Record "Purch. Rcpt. Line";
                        StyleTransLines: Record "Style Transfer Line";
                        Inx: Integer;
                        GrpItem: Code[20];
                    begin
                        Inx := 0;

                        StyleTransLines.Reset();
                        StyleTransLines.SetRange("Document No.", Rec."No.");
                        if StyleTransLines.FindSet() then begin
                            StyleTransLines.DeleteAll();
                        end;

                        PurchRcLineRec.Reset();
                        PurchRcLineRec.SetRange("Buyer No.", Rec."Buyer Code");
                        PurchRcLineRec.SetRange(PONo, Rec.PO);
                        PurchRcLineRec.SetRange(Lot, Rec."From Lot");
                        PurchRcLineRec.SetRange(StyleNo, Rec."From Style No");
                        if PurchRcLineRec.FindSet() then begin
                            repeat
                                if GrpItem <> PurchRcLineRec."No." then begin
                                    Inx += 10000;
                                    StyleTransLines.Init();
                                    StyleTransLines."Document No." := Rec."No.";
                                    StyleTransLines."Line No." := Inx;
                                    StyleTransLines.Validate("Main Category", PurchRcLineRec."Item Category Code");
                                    StyleTransLines."From Prod. Order No." := Rec."From Prod. Order No.";
                                    StyleTransLines."To Prod. Order No." := Rec."To Prod. Order No.";
                                    StyleTransLines.Validate("Item Code", PurchRcLineRec."No.");
                                    StyleTransLines.Insert();
                                    GrpItem := PurchRcLineRec."No.";
                                end;
                            until PurchRcLineRec.Next() = 0;
                        end
                        else
                            Message('Cannot Find a Records');
                    end;

                }
                // field("From Prod. Order No."; Rec."From Prod. Order No.")
                // {
                //     ApplicationArea = All;
                // }

                field("To Buyer Code"; Rec."To Buyer Code")
                {
                    ApplicationArea = All;
                }
                field("To Buyer"; Rec."To Buyer")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("To Style No."; Rec."To Style No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        StyleRec: Record "Style Master";
                    begin

                        StyleRec.Reset();
                        StyleRec.SetRange("Style No.", Rec."To Style No");

                        if not StyleRec.FindSet() then
                            Error('Invalid Style');

                    end;
                }
                field("To PO"; Rec."To PO")
                {
                    ApplicationArea = All;
                }
                field("To Lot"; Rec."To Lot")
                {
                    ApplicationArea = All;
                }
                // field("To Prod. Order No."; Rec."To Prod. Order No.")
                // {
                //     ApplicationArea = All;
                // }
                // field("To Style Name"; Rec."To Style Name")
                // {
                //     ApplicationArea = All;
                // }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Lines; "Style Transfer Subform")
            {
                ApplicationArea = All;
                Enabled = rec."No." <> '';
                UpdatePropagation = Both;
                SubPageLink = "Document No." = field("No.");
                Editable = EditableGb;
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Send for Approval")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    rec.Status := rec.Status::"Pending Approval";
                    rec.Modify();
                    Message('Approval request sent successfully');
                end;
            }
            // action(Reopen)
            // {
            //     ApplicationArea = All;
            //     Image = ReOpen;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     trigger OnAction()
            //     begin
            //         if Rec.Status = Rec.Status::Approved then
            //             // Error('Document already approved');

            //         rec.Status := Rec.Status::Open;
            //         Rec.Modify();
            //     end;
            // }
            action(Print)
            {
                ApplicationArea = all;
                Image = Print;

                trigger OnAction()
                var
                    styleTransferRec: Report StyleTransferReportCard;
                begin
                    styleTransferRec.Set_value(rec."No.");
                    styleTransferRec.RunModal();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        StyleHRec: Record "Style transfer Header";
        StyleLinRec: Record "Style Transfer Line";
        PositiveTotal: Decimal;
        NegativeTotal: Decimal;
        // ItemLeRec: Record "Item Ledger Entry";
        ItemLeRec: Record "Item Journal Line";
    begin
        StyleHRec.Reset();
        StyleHRec.SetRange("No.", Rec."No.");
        StyleHRec.SetRange(Status, Rec.Status::Approved);
        if StyleHRec.FindSet() then begin
            StyleLinRec.Reset();
            StyleLinRec.SetRange("Document No.", StyleHRec."No.");
            if StyleLinRec.FindSet() then begin
                NegativeTotal := 0;
                PositiveTotal := 0;
                ItemLeRec.Reset();
                ItemLeRec.SetRange("Item No.", StyleLinRec."Item Code");
                ItemLeRec.SetRange("Journal Template Name", 'ITEM');
                ItemLeRec.SetRange("Journal Batch Name", 'DEFAULT');
                ItemLeRec.SetRange("Entry Type", ItemLeRec."Entry Type"::"Negative Adjmt.");
                if ItemLeRec.FindSet() then begin
                    ItemLeRec.CalcSums(Quantity);
                    NegativeTotal := ItemLeRec.Quantity;
                end;
                ItemLeRec.Reset();
                ItemLeRec.SetRange("Item No.", StyleLinRec."Item Code");
                ItemLeRec.SetFilter("Journal Template Name", '<>%1', 'ITEM');
                ItemLeRec.SetFilter("Journal Batch Name", '<>%1', 'DEFAULT');
                ItemLeRec.SetFilter("Document No.", '<>%1', StyleLinRec."Document No.");
                ItemLeRec.SetFilter("Entry Type", '<>%1', ItemLeRec."Entry Type"::"Negative Adjmt.");
                ItemLeRec.SetFilter("Entry Type", '<>%1', ItemLeRec."Entry Type"::"Positive Adjmt.");
                if ItemLeRec.FindSet() then begin
                    ItemLeRec.CalcSums(Quantity);
                    PositiveTotal := ItemLeRec.Quantity;
                end;
                StyleLinRec."Available Inventory" := PositiveTotal - (NegativeTotal * -1);
                StyleLinRec.Modify();
                CurrPage.Update();
            end;
        end;
    end;

    trigger OnOpenPage()
    var
        StyleTHRec: Record "Style transfer Header";
    begin
        EditableGb := true;

        StyleTHRec.Reset();
        StyleTHRec.SetRange("No.", Rec."No.");
        StyleTHRec.SetFilter(Status, '<>%1', StyleTHRec.Status::Open);
        if StyleTHRec.FindSet() then begin
            EditableGb := false;
        end;
    end;

    var
        EditableGb: Boolean;
}
