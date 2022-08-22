page 50362 "Daily Printing In/Out"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ProductionOutHeader;
    SourceTableView = where(Type = filter('print'));
    CardPageId = "Daily Printing In/Out Card";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Prod Date"; "Prod Date")
                {
                    ApplicationArea = All;
                    Caption = 'Production Date';
                }

                field("Resource Name"; "Resource Name")
                {
                    ApplicationArea = All;
                    Caption = 'Resource';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("PO No"; "PO No")
                {
                    ApplicationArea = All;
                }

                field("Output Qty"; "Output Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        NavAppCodeUnit: Codeunit NavAppCodeUnit;
    begin
        NavAppCodeUnit.Delete_Prod_Records("No.", "Style No.", "PO No", 'IN', 'Print', Type::Print);
        NavAppCodeUnit.Delete_Prod_Records("No.", "Style No.", "PO No", 'OUT', 'Print', Type::Print);
    end;
}