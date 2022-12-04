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
                field("Prod Date"; rec."Prod Date")
                {
                    ApplicationArea = All;
                    Caption = 'Production Date';
                }

                field("Resource Name"; rec."Resource Name")
                {
                    ApplicationArea = All;
                    Caption = 'Resource';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("PO No"; rec."PO No")
                {
                    ApplicationArea = All;
                }

                field("Output Qty"; rec."Output Qty")
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
        NavAppCodeUnit.Delete_Prod_Records(rec."No.", rec."Style No.", rec."PO No", 'IN', 'Emb', rec.Type::Emb);
        NavAppCodeUnit.Delete_Prod_Records(rec."No.", rec."Style No.", rec."PO No", 'OUT', 'Emb', rec.Type::Emb);
    end;
}