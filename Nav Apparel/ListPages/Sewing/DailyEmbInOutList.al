page 50359 "Daily Embroidary In/Out"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ProductionOutHeader;
    SourceTableView = sorting("No.") order(descending) where(Type = filter('Emb'));
    CardPageId = "Daily Embroidary In/Out Card";


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
        NavAppCodeUnit.Delete_Prod_Records("No.", "Style No.", "PO No", 'IN', 'Emb', Type::Emb);
        NavAppCodeUnit.Delete_Prod_Records("No.", "Style No.", "PO No", 'OUT', 'Emb', Type::Emb);
    end;
}