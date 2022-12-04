page 50356 "Daily Sewing In/Out"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ProductionOutHeader;
    SourceTableView = sorting("No.") order(descending) where(Type = filter('Saw'));
    CardPageId = "Daily Sewing In/Out Card";

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
                    Caption = 'Resource';
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
        NavAppCodeUnit.Delete_Prod_Records(rec."No.", rec."Style No.", rec."PO No", 'IN', 'Saw', rec.Type::Saw);
        NavAppCodeUnit.Delete_Prod_Records(rec."No.", rec."Style No.", rec."PO No", 'OUT', 'Saw', rec.Type::Saw);
    end;
}