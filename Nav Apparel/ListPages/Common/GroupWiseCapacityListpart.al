page 51342 GroupWiseCapacityListpart
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = GroupWiseCapacity;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
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
                    Caption = 'Planned Avg SMV';
                }

                field(Finishing; rec.Finishing)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Ship Qty"; rec."Ship Qty")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Ship Value"; rec."Ship Value")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Avg Plan Mnts"; rec."Avg Plan Mnts")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Avg Prod. Mnts"; rec."Avg Prod. Mnts")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Plan Hit"; rec."Plan Hit")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Plan Eff."; rec."Plan Eff.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Actual Eff."; rec."Actual Eff.")
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
        StyleExprTxt := ChangeColor.ChangeColorGroupWiseCap(Rec);
    end;


    VAR
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
}