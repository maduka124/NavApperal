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

                field("Gate Pass - Pending Approvals"; "Gate Pass - Pending Approvals")
                {
                    DrillDownPageID = "Gate Pass List";
                    Caption = 'Gate Pass - Pending Approvals';
                    ApplicationArea = all;
                }

                field("Dept. Purch - Pending Approv"; "Dept. Purch - Pending Approv")
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

    trigger OnOpenPage()
    begin
        if not rec.get() then begin
            rec.INIT();
            rec.INSERT();
        end;
    end;
}