page 50873 SAH_MerchGRPWiseAlloListPart
{
    PageType = ListPart;
    SourceTable = SAH_MerchGRPWiseAllocation;
    SourceTableView = sorting(Year, "Group Id") order(ascending);
    Caption = ' ';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Group Name"; rec."Group Name")
                {
                    ApplicationArea = All;
                }

                field(JAN; rec.JAN)
                {
                    ApplicationArea = All;
                }

                field(FEB; rec.FEB)
                {
                    ApplicationArea = All;
                }

                field(MAR; rec.MAR)
                {
                    ApplicationArea = All;
                }

                field(APR; rec.APR)
                {
                    ApplicationArea = All;
                }

                field(MAY; rec.MAY)
                {
                    ApplicationArea = All;
                }

                field(JUN; rec.JUN)
                {
                    ApplicationArea = All;
                }

                field(JUL; rec.JUL)
                {
                    ApplicationArea = All;
                }

                field(AUG; rec.AUG)
                {
                    ApplicationArea = All;
                }

                field(SEP; rec.SEP)
                {
                    ApplicationArea = All;
                }

                field(OCT; rec.OCT)
                {
                    ApplicationArea = All;
                }

                field(NOV; rec.NOV)
                {
                    ApplicationArea = All;
                }

                field(DEC; rec.DEC)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}