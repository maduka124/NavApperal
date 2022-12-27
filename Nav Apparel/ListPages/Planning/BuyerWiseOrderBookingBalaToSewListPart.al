page 51169 "BuyWisOdrBoo-BalTosewListPart"
{
    PageType = ListPart;
    SourceTable = BuyerWiseOrderBookinBalatoSew;
    SourceTableView = sorting("Buyer Name") order(ascending);
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
                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                    StyleExpr = StyleExprTxt;
                }

                field(JAN; rec.JAN)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(FEB; rec.FEB)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(MAR; rec.MAR)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(APR; rec.APR)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(MAY; rec.MAY)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(JUN; rec.JUN)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(JUL; rec.JUL)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(AUG; rec.AUG)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(SEP; rec.SEP)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(OCT; rec.OCT)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(NOV; rec.NOV)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(DEC; rec.DEC)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(Total; rec.Total)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorBooking2(Rec);
    end;


    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
}