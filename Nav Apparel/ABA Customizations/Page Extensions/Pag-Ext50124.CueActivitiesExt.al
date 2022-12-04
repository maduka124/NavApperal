pageextension 50124 CueActivitiesExt extends "Cue Activities 1"
{
    layout
    {
        addafter("Gate Pass - Pending Approvals")
        {
            field("Daily Requirement -Pending Approvals"; DailyRequirementApprovals)
            {
                ApplicationArea = All;
                AutoFormatType = 10;
                trigger OnDrillDown()
                var
                    DailyReqhedd: Record "Daily Consumption Header";
                begin
                    DailyReqhedd.Reset();
                    DailyReqhedd.SetRange(Status, DailyReqhedd.Status::"Pending Approval");
                    DailyReqhedd.SetRange("Approver UserID", UserId);
                    Page.RunModal(50112, DailyReqhedd);
                end;
            }
            field("General Issue - Pending Approvals"; GenIssueApprovals)
            {
                ApplicationArea = All;
                AutoFormatType = 10;
                trigger OnDrillDown()
                var
                    GenIssueHedd: Record "General Issue Header";
                begin
                    GenIssueHedd.Reset();
                    GenIssueHedd.SetRange(Status, GenIssueHedd.Status::"Pending Approval");
                    GenIssueHedd.SetRange("Approver UserID", UserId);
                    Page.RunModal(50117, GenIssueHedd);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        DailyReqhedd: Record "Daily Consumption Header";
        GenIssueHedd: Record "General Issue Header";
    begin
        DailyReqhedd.Reset();
        DailyReqhedd.SetRange(Status, DailyReqhedd.Status::"Pending Approval");
        DailyReqhedd.SetRange("Approver UserID", UserId);
        DailyRequirementApprovals := DailyReqhedd.Count;

        GenIssueHedd.Reset();
        GenIssueHedd.SetRange(Status, GenIssueHedd.Status::"Pending Approval");
        GenIssueHedd.SetRange("Approver UserID", UserId);
        GenIssueApprovals := GenIssueHedd.Count;
    end;

    var
        DailyRequirementApprovals: Integer;
        GenIssueApprovals: Integer;
}
