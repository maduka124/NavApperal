page 51344 FactoryWiseCapacityListpart
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FactoryWiseCapacity;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Factory; rec.Factory)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Month; rec.Month)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Capacity Pcs"; rec."Capacity Pcs")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Planned Pcs"; rec."Planned Pcs")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Achieved Pcs"; rec."Achieved Pcs")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Diff."; rec."Diff.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Avg SMV"; rec."Avg SMV")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Plan Eff."; rec."Plan Eff.")
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
        StyleExprTxt := ChangeColor.ChangeColorFactoryWiseCap(rec)
    end;


    VAR
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
}