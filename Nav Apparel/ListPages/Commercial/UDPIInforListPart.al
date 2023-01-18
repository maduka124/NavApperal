page 51213 "PI Infor ListPart"
{
    PageType = ListPart;
    SourceTable = UDPIinformationLine;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Supplier; rec.Supplier)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Main Category"; rec."Main Category")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Item Code"; rec."Item Code")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Item Description"; rec."Item Description")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Order Qty"; rec."Order Qty1")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Value; rec.Value)
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
        StyleExprTxt := ChangeColor.ChangeColorUDPIInfo(Rec);
    end;


    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
}