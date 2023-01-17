page 51211 "Style PO Info ListPart"
{
    PageType = ListPart;
    SourceTable = UDStylePOinformation;
    Editable = false;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    StyleExpr = StyleExprTxt;
                }

                field("PO NO"; rec."PO No")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                    StyleExpr = StyleExprTxt;
                }

                field("Order Qty"; rec."Order Qty")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Ship Date"; rec."Ship Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Values; rec.Values)
                {
                    ApplicationArea = All;
                    Caption = 'Value';
                    StyleExpr = StyleExprTxt;
                }

                field("Ship Qty"; rec."Ship Qty")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Ship Values"; rec."Ship Values")
                {
                    ApplicationArea = All;
                    Caption = 'Ship Value';
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }


    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorUDStylePOInfo(Rec);
    end;


    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
}