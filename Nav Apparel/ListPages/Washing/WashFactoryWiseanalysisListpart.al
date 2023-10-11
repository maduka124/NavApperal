page 51432 WashFacWiseanalyis
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = WashFactoryWiseanalysisTbl;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    SourceTableView = sorting("Line No") order(ascending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Wash Type"; Rec."Wash Type")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Type';
                    StyleExpr = StyleExprTxt;
                }

                field(Jan; Rec.Jan)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Feb; Rec.Feb)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Mar; Rec.Mar)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Apr; Rec.Apr)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(May; Rec.May)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Jun; Rec.Jun)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Jul; Rec.Jul)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Aug; Rec.Aug)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Sep; Rec.Sep)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Oct; Rec.Oct)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field(Nov; Rec.Nov)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Dec; Rec.Dec)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Total; Rec.Total)
                {
                    ApplicationArea = All;
                    Caption = 'Total';
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorWashinAnlyse2(Rec);
    end;

    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;

    trigger OnOpenPage()
    var
        WashFactoryWiseanalysisTblRec: Record WashFactoryWiseanalysisTbl;
    begin

        WashFactoryWiseanalysisTblRec.Reset();
        if WashFactoryWiseanalysisTblRec.FindSet() then
            WashFactoryWiseanalysisTblRec.DeleteAll();

    end;
}