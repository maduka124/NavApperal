page 50117 "General Issue Approvals"
{
    ApplicationArea = All;
    Caption = 'General Issue Approvals';
    PageType = List;
    SourceTable = "General Issue Header";
    SourceTableView = where(Status = filter("Pending Approval"));
    UsageCategory = Lists;
    CardPageId = 50114;
    Editable = false;
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Created UserID"; Rec."Created UserID")
                {
                    ApplicationArea = All;
                }
                field("Approved UserID"; Rec."Approved UserID")
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
                Image = Approve;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Approve';
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Get(UserId);
                    if not UserSetup."Gen. Issueing Approve" then
                        Error('You do not have permission to perform this action');

                    Rec.TestField(Status, Rec.Status::"Pending Approval");
                    Sleep(500);

                    Rec.Status := Rec.Status::Approved;
                    Rec."Approved UserID" := UserId;
                    Rec."Approved Date/Time" := CurrentDateTime;
                    Rec.Modify();
                end;
            }
            action(Reject)
            {
                Image = Reject;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Reject';
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Get(UserId);
                    if not UserSetup."Gen. Issueing Approve" then
                        Error('You do not have permission to perform this action');

                    Rec.TestField(Status, Rec.Status::"Pending Approval");
                    Sleep(500);
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                end;
            }
        }

    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Gen. Issueing Approve" then
            Error('You do not have permission to perform this action');
        Rec.SetRange("Approver UserID", UserId);
    end;
}
