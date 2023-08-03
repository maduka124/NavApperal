page 51363 StyleWiseMachineReqListpart
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = StyleWiseMachineLine;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Machine No"; Rec."Machine No")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Machine Name"; Rec."Machine Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Machine Qty"; Rec."Machine Qty")
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
        StyleExprTxt := ChangeColor.ChangeColorManMachine(Rec);
    end;


    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
}