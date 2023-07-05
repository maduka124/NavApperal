page 51346 LineWiseCapacityListpart
{
    PageType = ListPart;
    ApplicationArea = All;   
    UsageCategory = Lists;
    SourceTable = LineWiseCapacity;
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

                field("Resource Name"; rec."Resource Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Line';
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
            }
        }
    }

    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorLineWiseCap(rec)
    end;


    VAR
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
}