page 51395 ExtraPercentageForCuttingList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ExtraPercentageForCutting;
    CardPageId = ExtraPercentageForCuttingCard;
    Caption = 'Qty Wise Extra % For Cutting';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Start Qty"; rec."Start Qty")
                {
                    ApplicationArea = All;
                }

                field("Finish Qty"; rec."Finish Qty")
                {
                    ApplicationArea = All;
                }

                field(Percentage; rec.Percentage)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
    begin
        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());
        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();
        end;
    end;
}