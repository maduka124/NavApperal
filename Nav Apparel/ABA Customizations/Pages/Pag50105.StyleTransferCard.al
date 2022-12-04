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
                }
                field("Style No."; Rec."Style No.")
                {
                    ApplicationArea = All;
                }
                field(PO; Rec.PO)
                {
                    ApplicationArea = All;
                }
                field("From Prod. Order No."; Rec."From Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("From Style Name"; Rec."From Style Name")
                {
                    ApplicationArea = All;
                }
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
                }
                field("To PO"; Rec."To PO")
                {
                    ApplicationArea = All;
                }
                field("To Prod. Order No."; Rec."To Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("To Style Name"; Rec."To Style Name")
                {
                    ApplicationArea = All;
                }
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
            action(Reopen)
            {
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Approved then
                        Error('Document already approved');

                    rec.Status := Rec.Status::Open;
                    Rec.Modify();
                end;
            }
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
}
