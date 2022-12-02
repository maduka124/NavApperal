page 50873 SAH_MerchGRPWiseAlloListPart
{
    PageType = ListPart;
    SourceTable = SAH_MerchGRPWiseAllocation;
    SourceTableView = sorting(Year, "Group Name") order(ascending);
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
                field("Group Name"; "Group Name")
                {
                    ApplicationArea = All;
                }

                field(JAN; JAN)
                {
                    ApplicationArea = All;
                }

                field(FEB; FEB)
                {
                    ApplicationArea = All;
                }

                field(MAR; MAR)
                {
                    ApplicationArea = All;
                }

                field(APR; APR)
                {
                    ApplicationArea = All;
                }

                field(MAY; MAY)
                {
                    ApplicationArea = All;
                }

                field(JUN; JUN)
                {
                    ApplicationArea = All;
                }

                field(JUL; JUL)
                {
                    ApplicationArea = All;
                }

                field(AUG; AUG)
                {
                    ApplicationArea = All;
                }

                field(SEP; SEP)
                {
                    ApplicationArea = All;
                }

                field(OCT; OCT)
                {
                    ApplicationArea = All;
                }

                field(NOV; NOV)
                {
                    ApplicationArea = All;
                }

                field(DEC; DEC)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}