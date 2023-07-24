page 51372 StyleChangeListPart
{
    PageType = ListPart;
    SourceTable = StyleChangeLine;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Resource No."; rec."Resource No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line';
                    StyleExpr = StyleExprTxt;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'No of Style Changes';
                    StyleExpr = StyleExprTxt;
                }
            }
        }

    }

    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeStyleChange(Rec);

    end;

    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
}