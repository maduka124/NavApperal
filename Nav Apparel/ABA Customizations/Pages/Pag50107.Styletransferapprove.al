page 50107 "Style transfer Approvals"
{
    ApplicationArea = All;
    Caption = 'Style transfer Approvals';
    PageType = List;
    SourceTable = "Style transfer Header";
    SourceTableView = where(Status = filter("Pending Approval"));
    UsageCategory = Lists;
    Editable = false;
    CardPageId = 50108;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
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
                field("To Prod. Order No."; Rec."To Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("To Style Name"; Rec."To Style Name")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
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
                end;
            }
        }
    }
}
