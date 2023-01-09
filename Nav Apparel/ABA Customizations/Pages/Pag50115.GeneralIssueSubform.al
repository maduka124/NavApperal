page 50115 "General Issue Subform"
{
    ApplicationArea = Suite;
    UsageCategory = Lists;
    Caption = 'General Issue Subform';
    PageType = ListPart;
    SourceTable = "General Issue Line";
    AutoSplitKey = true;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Main Category"; Rec."Main Category")
                {
                    ApplicationArea = All;
                }
                field("Main Category Name"; Rec."Main Category Name")
                {
                    ApplicationArea = All;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;

                    //Added by Maduka on 9/1/2023
                    trigger OnValidate()
                    var
                        ItemLedgerRec: Record "Item Ledger Entry";
                    begin
                        ItemLedgerRec.Reset();
                        ItemLedgerRec.SetRange("Item No.", Rec."Item Code");
                        if Rec."Location Code" <> '' then
                            ItemLedgerRec.SetRange("Location Code", Rec."Location Code");

                        if ItemLedgerRec.FindSet() then begin
                            repeat
                                Rec."Quantity In Stock" += ItemLedgerRec."Remaining Quantity";
                            until ItemLedgerRec.Next() = 0;
                        end;
                    end;
                }

                //Added by Maduka on 9/1/2023
                field("Quantity In Stock"; Rec."Quantity In Stock")
                {
                    ApplicationArea = All;
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
