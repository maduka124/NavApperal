page 51347 CapacityDashboardList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = CapacityDashboardHeader;
    CardPageId = CapacityDashboardCard;
    SourceTableView = sorting(Year) order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Year; rec.Year)
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


    trigger OnDeleteRecord(): Boolean
    var
        GroupWiseCapacityRec: Record GroupWiseCapacity;
        LineWiseCapacityRec: Record LineWiseCapacity;
        FactoryWiseCapacityRec: Record FactoryWiseCapacity;
    begin
        GroupWiseCapacityRec.Reset();
        GroupWiseCapacityRec.SetRange(Year, rec.Year);
        if GroupWiseCapacityRec.FindSet() then
            GroupWiseCapacityRec.DeleteAll();

        LineWiseCapacityRec.Reset();
        LineWiseCapacityRec.SetRange(Year, rec.Year);
        if LineWiseCapacityRec.FindSet() then
            LineWiseCapacityRec.DeleteAll();

        FactoryWiseCapacityRec.Reset();
        FactoryWiseCapacityRec.SetRange(Year, rec.Year);
        if FactoryWiseCapacityRec.FindSet() then
            FactoryWiseCapacityRec.DeleteAll();
    end;
}