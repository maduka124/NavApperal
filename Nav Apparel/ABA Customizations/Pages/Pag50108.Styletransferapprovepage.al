page 50108 "Style Transfer Approve Card"
{
    Caption = 'Style Transfer Approve';
    PageType = Card;
    SourceTable = "Style transfer Header";
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;
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
                field("From Prod. Order No."; Rec."From Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("From Style Name"; Rec."From Style Name")
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
                Editable = false;
                SubPageLink = "Document No." = field("No.");
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                ApplicationArea = All;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Get(UserId);
                    if not UserSetup."Head of Department" then
                        Error('You do not have permission to perform this action');

                    rec.Status := rec.Status::Approved;
                    rec.Modify();
                    Message('Document No %1 is approved', rec."No.");
                    CurrPage.Close();
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Get(UserId);
                    if not UserSetup."Head of Department" then
                        Error('You do not have permission to perform this action');

                    rec.Status := rec.Status::Open;
                    rec.Modify();
                    Message('Document No %1 is rejected', rec."No.");
                    CurrPage.Close();
                end;
            }
            //   action("Send for Approval")
            //   {
            //       ApplicationArea = All;
            //       Image = SendApprovalRequest;
            //       Promoted = true;
            //       PromotedCategory = Process;
            //       trigger OnAction()
            //       begin
            //           rec.Status := rec.Status::"Pending Approval";
            //           rec.Modify();
            //           Message('Approval request sent successfully');
            //       end;
            //   }
            //   action(Reopen)
            //   {
            //       ApplicationArea = All;
            //       Image = ReOpen;
            //       Promoted = true;
            //       PromotedCategory = Process;
            //       trigger OnAction()
            //       begin
            //           if Rec.Status = Rec.Status::Approved then
            //               Error('Document already approved');

            //           rec.Status := Rec.Status::Open;
            //           Rec.Modify();
            //       end;
            //   }
        }
    }
}
