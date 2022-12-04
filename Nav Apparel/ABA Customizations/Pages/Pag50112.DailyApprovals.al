page 50112 "Daily Requirement Approvals"
{
    ApplicationArea = All;
    Caption = 'Daily Requirement Approvals';
    PageType = List;
    SourceTable = "Daily Consumption Header";
    UsageCategory = Lists;
    CardPageId = 50102;
    Editable = false;
    SourceTableView = where(Status = filter("Pending Approval"));
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
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field(Buyer; rec.Buyer)
                {
                    ApplicationArea = All;
                }
                field("Style No."; rec."Style No.")
                {
                    ApplicationArea = All;
                }
                field(PO; rec.PO)
                {
                    ApplicationArea = All;
                }
                field("Colour Name"; rec."Colour Name")
                {
                    ApplicationArea = All;
                }
                field("Created UserID"; rec."Created UserID")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
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
                Image = Approve;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Approve';
                trigger OnAction()
                var
                    ItemJnalLine: Record "Item Journal Line";
                    UserSetup: Record "User Setup";
                    AppOK: Boolean;
                begin
                    AppOK := false;
                    UserSetup.Get(UserId);
                    if not UserSetup."Consumption Approve" then
                        Error('You do not have permission to perform this action');

                    Rec.TestField(Status, Rec.Status::"Pending Approval");
                    Sleep(500);

                    ItemJnalLine.Reset();
                    ItemJnalLine.SetRange("Journal Template Name", rec."Journal Template Name");
                    ItemJnalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    ItemJnalLine.SetRange("Daily Consumption Doc. No.", Rec."No.");
                    if ItemJnalLine.FindFirst() then
                        repeat
                            ItemJnalLine.validate("Line Approved", true);
                            ItemJnalLine.Modify();
                            AppOK := true;
                        until ItemJnalLine.Next() = 0;
                    Commit();
                    if AppOK then begin
                        Rec.Status := Rec.Status::Approved;
                        Rec."Approved UserID" := UserId;
                        Rec."Approved Date/Time" := CurrentDateTime;
                        Rec.Modify();
                    end;

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
                    if not UserSetup."Consumption Approve" then
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
        if not UserSetup."Consumption Approve" then
            Error('You do not have permission to perform this action');

        Rec.SetRange("Approver UserID", UserId);
    end;
}
