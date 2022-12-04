page 50114 "General Issue Card"
{
    Caption = 'General Issue';
    PageType = Card;
    SourceTable = "General Issue Header";

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Department Name"; rec."Department Name")
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
                    Editable = false;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Lines; "General Issue Subform")
            {
                ApplicationArea = Suite;
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
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Image = SendApprovalRequest;
                Caption = 'Send Approval Request';
                Promoted = true;
                PromotedCategory = Process;
                Visible = not BooVis;
                trigger OnAction()
                var
                    GenIsseLine: Record "General Issue Line";
                    UserSetup: Record "User Setup";
                begin
                    Rec.TestField(Status, rec.Status::Open);
                    GenIsseLine.Reset();
                    GenIsseLine.SetRange("Document No.", Rec."No.");
                    if not GenIsseLine.FindFirst() then
                        Error('There is nothing to send');

                    UserSetup.Get(UserId);

                    Sleep(500);

                    if UserSetup."Gen. Issueing Approver" = '' then
                        Error('Approval user not found');

                    Rec.Status := Rec.Status::"Pending Approval";
                    Rec."Approver UserID" := UserSetup."Gen. Issueing Approver";
                    Rec.Modify();
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Image = CancelApprovalRequest;
                Caption = 'Cancel Approval Request';
                Promoted = true;
                PromotedCategory = Process;
                Visible = not BooVis;
                trigger OnAction()
                begin
                    Rec.TestField(Status, rec.Status::"Pending Approval");

                    Sleep(500);
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                end;
            }
            action(Approve)
            {
                Image = Approve;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Approve';
                Visible = BooVis;
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
            action(Print)
            {
                ApplicationArea = all;
                Image = Print;

                trigger OnAction()
                var
                    GeneralIssueCardRec: Report GeneralIssueReportCard;
                begin
                    GeneralIssueCardRec.Set_value(Rec."No.");
                    GeneralIssueCardRec.RunModal();
                end;
            }
            action(Reject)
            {
                Image = Reject;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Reject';
                Visible = BooVis;
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
        ItemJnalRec: Record "Item Journal Line";
        ItemLedRec: Record "Item Ledger Entry";

    begin
        Vis1 := false;

        UserSetup.Get(UserId);
        if not UserSetup."Gen. Issueing Approve" then
            BooVis := false
        else
            BooVis := true;

        // ItemJnalRec.Reset();
        // ItemJnalRec.SetRange("Journal Template Name", rec."Journal Template Name");
        // ItemJnalRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        // ItemJnalRec.SetRange("Daily Consumption Doc. No.", Rec."No.");
        // if ItemJnalRec.FindFirst() then
        //     Vis1 := true;
    end;

    var
        Vis1: Boolean;
        BooVis: Boolean;
}
