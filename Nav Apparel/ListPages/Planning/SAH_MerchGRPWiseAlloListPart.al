page 50873 SAH_MerchGRPWiseAlloListPart
{
    PageType = ListPart;
    SourceTable = SAH_MerchGRPWiseAllocation;
    SourceTableView = sorting("No.", Year, "Group Id") order(ascending);
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
                field("Group Head"; rec."Group Head")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                // field("Group Name"; rec."Group Name")
                // {
                //     ApplicationArea = All;
                //     StyleExpr = StyleExprTxt;
                // }

                // field("Group Id"; rec."Group Id")
                // {
                //     ApplicationArea = All;
                //     StyleExpr = StyleExprTxt;
                // }

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
            }
        }
    }

    //Done By Sachith on 7/2/23
    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorBooking5(Rec);
    end;

    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
}