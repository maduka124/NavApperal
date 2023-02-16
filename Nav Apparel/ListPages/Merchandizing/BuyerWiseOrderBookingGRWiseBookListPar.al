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
                    StyleExpr = StyleExprTxt;
                }

                //Done By Sachith on 16/02/23
                field("Brand Name"; Rec."Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                }

                field(JAN; rec.JAN)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(JAN_FOB; rec.JAN_FOB)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(FEB; rec.FEB)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(FEB_FOB; rec.FEB_FOB)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(MAR; rec.MAR)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(MAR_FOB; rec.MAR_FOB)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(APR; rec.APR)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(APR_FOB; rec.APR_FOB)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(MAY; rec.MAY)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(MAY_FOB; rec.MAY_FOB)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(JUN; rec.JUN)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(JUN_FOB; rec.JUN_FOB)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(JUL; rec.JUL)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(JUL_FOB; rec.JUL_FOB)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(AUG; rec.AUG)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(AUG_FOB; rec.AUG_FOB)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(SEP; rec.SEP)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(SEP_FOB; rec.SEP_FOB)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(OCT; rec.OCT)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(OCT_FOB; rec.OCT_FOB)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(NOV; rec.NOV)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(NOV_FOB; rec.NOV_FOB)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(DEC; rec.DEC)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(DEC_FOB; rec.DEC_FOB)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Total; rec.Total)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(Total_FOB; rec.Total_FOB)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }


    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorBooking4(Rec);
    end;


    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;

}