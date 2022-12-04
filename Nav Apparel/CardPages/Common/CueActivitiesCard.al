page 50787 "Cue Activities 1"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Activities Cue 1";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup("Test")
            {
                //CueGroupLayout = Wide;
                ShowCaption = false;

                field("Gate Pass - Pending Approvals"; rec."Gate Pass - Pending Approvals")
                {
                    DrillDownPageID = "Gate Pass List";
                    Caption = 'Gate Pass - Pending Approvals';
                    ApplicationArea = all;
                }


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

                field("Dept. Purch - Pending Approv"; rec."Dept. Purch - Pending Approv")
                {
                    DrillDownPageID = "Department Requisition Sheet";
                    Caption = 'Dept. Purchasing - Pending Approvals';
                    ApplicationArea = all;
                }

                // actions
                // {
                //     action(ActionName)
                //     {
                //         RunObject = page "Gate Pass List";
                //         Image = TileNew;

                //         trigger OnAction()
                //         begin
                //         end;
                //     }
                // }
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


    trigger OnOpenPage()
    begin
        if not rec.get() then begin
            rec.INIT();
            rec.INSERT();
        end;
    end;


    var
        DailyRequirementApprovals: Integer;
        GenIssueApprovals: Integer;
}