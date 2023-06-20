page 51326 PostedSalesInvoiceTemp
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Invoice Header";
    CardPageId = SalesInvoiceTemp;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                    Caption = 'Factory Inv No';

                }
                field("Contract No"; Rec."Contract No")
                {
                    ApplicationArea = All;

                }
                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;

                }
                field("Export Ref No."; Rec."Export Ref No.")
                { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}