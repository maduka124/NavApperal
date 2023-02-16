page 51166 "BuyeWisOdrBook-AllBookListPart"
{
    PageType = ListPart;
    SourceTable = BuyerWiseOdrBookingAllBook;
    SourceTableView = sorting("No.", "Buyer Name") order(descending);
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
        StyleExprTxt := ChangeColor.ChangeColorBooking1(Rec);
    end;

    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
}