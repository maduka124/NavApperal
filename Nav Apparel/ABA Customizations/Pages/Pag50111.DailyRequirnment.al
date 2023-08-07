page 50111 "Daily Requirement"
{
    Caption = 'Material Requirement';
    PageType = ListPart;
    SourceTable = "Item Journal Line";
    ApplicationArea = Suite;
    UsageCategory = Lists;
    LinksAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Order No."; Rec."Order No.")
                {
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                //Mihiranga 2023/01/13
                field("Request Qty"; Rec."Request Qty")
                {
                    Visible = false;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var

        ItemJrnlLineTempRec: Record ItemJournalLinetemp;
        //DailyConsumHeaderRec: Record "Daily Consumption Header";
        ReserveEntry: Record "Reservation Entry";
    begin
        ItemJrnlLineTempRec.Reset();
        ItemJrnlLineTempRec.SetRange("Journal Template Name", Rec."Journal Template Name");
        ItemJrnlLineTempRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        ItemJrnlLineTempRec.SetRange("Source No.", rec."Source No.");
        ItemJrnlLineTempRec.SetRange("Daily Consumption Doc. No.", rec."Daily Consumption Doc. No.");
        ItemJrnlLineTempRec.SetRange("Item No.", rec."Item No.");
        if ItemJrnlLineTempRec.Findset() then
            ItemJrnlLineTempRec.DeleteAll();


        ReserveEntry.RESET;
        ReserveEntry.SetRange("Item No.", rec."Item No.");
        ReserveEntry.SetRange("Source ID", rec."Journal Template Name");
        ReserveEntry.SetRange("Source Batch Name", Rec."Journal Batch Name");
        ReserveEntry.SetRange("Source Ref. No.", rec."Line No.");
        if ReserveEntry.Findset() then
            ReserveEntry.DeleteAll();
    end;
}

