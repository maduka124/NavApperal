page 51173 "BuyWisOdrBoo-GRWisBookListPart"
{
    PageType = ListPart;
    SourceTable = BuyerWiseOrderBookinGRWiseBook;
    SourceTableView = sorting("Group Name") order(ascending);
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

                field(JAN_FOB; rec.JAN_FOB)
                {
                    ApplicationArea = All;
                }

                field(FEB; rec.FEB)
                {
                    ApplicationArea = All;
                }

                field(FEB_FOB; rec.FEB_FOB)
                {
                    ApplicationArea = All;
                }

                field(MAR; rec.MAR)
                {
                    ApplicationArea = All;
                }

                field(MAR_FOB; rec.MAR_FOB)
                {
                    ApplicationArea = All;
                }

                field(APR; rec.APR)
                {
                    ApplicationArea = All;
                }

                field(APR_FOB; rec.APR_FOB)
                {
                    ApplicationArea = All;
                }

                field(MAY; rec.MAY)
                {
                    ApplicationArea = All;
                }

                field(MAY_FOB; rec.MAY_FOB)
                {
                    ApplicationArea = All;
                }

                field(JUN; rec.JUN)
                {
                    ApplicationArea = All;
                }

                field(JUN_FOB; rec.JUN_FOB)
                {
                    ApplicationArea = All;
                }

                field(JUL; rec.JUL)
                {
                    ApplicationArea = All;
                }

                field(JUL_FOB; rec.JUL_FOB)
                {
                    ApplicationArea = All;
                }

                field(AUG; rec.AUG)
                {
                    ApplicationArea = All;
                }

                field(AUG_FOB; rec.AUG_FOB)
                {
                    ApplicationArea = All;
                }

                field(SEP; rec.SEP)
                {
                    ApplicationArea = All;
                }

                field(SEP_FOB; rec.SEP_FOB)
                {
                    ApplicationArea = All;
                }

                field(OCT; rec.OCT)
                {
                    ApplicationArea = All;
                }

                field(OCT_FOB; rec.OCT_FOB)
                {
                    ApplicationArea = All;
                }

                field(NOV; rec.NOV)
                {
                    ApplicationArea = All;
                }

                field(NOV_FOB; rec.NOV_FOB)
                {
                    ApplicationArea = All;
                }

                field(DEC; rec.DEC)
                {
                    ApplicationArea = All;
                }

                field(DEC_FOB; rec.DEC_FOB)
                {
                    ApplicationArea = All;
                }

                field(Total; rec.Total)
                {
                    ApplicationArea = All;
                }

                field(Total_FOB; rec.Total_FOB)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}