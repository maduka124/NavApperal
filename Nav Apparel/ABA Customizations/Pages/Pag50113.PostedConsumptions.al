page 50113 "Posted Consumptions"
{
    Caption = 'Posted Consumptions';
    PageType = ListPart;
    SourceTable = "Item Ledger Entry";
    ApplicationArea = Suite;
    UsageCategory = Lists;
    SourceTableView = where("Entry Type" = filter(Consumption));
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                    Caption = 'RM No';

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Caption = 'RM Description';

                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = all;
                    Caption = 'FG No';
                }
                field("FG Description"; Rec."FG Description")
                {
                    ApplicationArea = all;
                    Caption = 'FG Description';
                }
                field("Item Tracking"; rec."Item Tracking")
                {
                    ApplicationArea = all;
                }

                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Original Daily Requirement"; rec."Original Daily Requirement")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        ItemRec: Record Item;
    begin
        ItemRec.Reset();
        ItemRec.SetRange("No.", rec."Item No.");
        if ItemRec.FindFirst() then
            rec.Description := ItemRec.Description;

        ItemRec.Reset();
        ItemRec.SetRange("No.", rec."Source No.");
        if ItemRec.FindFirst() then
            rec."FG Description" := ItemRec.Description;

    end;
}
