page 50352 "Daily Cutting Out"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ProductionOutHeader;
    SourceTableView = where(Type = filter('Cut'));
    CardPageId = "Daily Cutting Out Card";


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
        NavAppCodeUnit.Delete_Prod_Records("No.", "Style No.", "PO No", 'OUT', 'Cut', Type::Cut);
    end;
}