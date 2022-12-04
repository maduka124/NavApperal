pageextension 50106 ItemJnalBatch extends "Item Journal Batches"
{
    layout
    {
        addafter("Reason Code")
        {
            field("Item Category Code"; rec."Item Category Code")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Inventory Posting Group"; rec."Inventory Posting Group")
            {
                ApplicationArea = All;
                Visible = vis;
            }
            field("gen. Prod. Posting Group"; rec."gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Visible = GenVis;
            }
            field("Location Code"; rec."Location Code")
            {
                ApplicationArea = All;
                Visible = GenVis;
            }
            field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
                Visible = GenVis;
            }
        }
    }
    trigger OnOpenPage()
    var
        ItemJournalTemplate: Record "Item Journal Template";
        InventSetup: Record "Inventory Setup";
    begin
        Vis := false;
        GenVis := false;

        InventSetup.Get();

        ItemJournalTemplate.Get(rec."Journal Template Name");
        if ItemJournalTemplate.Type = ItemJournalTemplate.Type::Consumption then begin
            if not ItemJournalTemplate.Recurring then
                Vis := true;
        end;
        if InventSetup."Gen. Issue Template" = Rec."Journal Template Name" then
            GenVis := true;
    end;

    var
        Vis: Boolean;
        GenVis: Boolean;
}
