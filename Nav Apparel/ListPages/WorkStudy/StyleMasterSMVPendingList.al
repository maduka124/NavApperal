page 50757 "Style SMV Pending List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Style Master";
    SourceTableView = sorting("No.") order(descending) where(CostingSMV = filter(0), Type = filter(Costing));
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    Caption = 'SMV Pending Style List';
    ///CardPageId = "New Breakdown Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Style No."; rec."Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style';

                    trigger OnAssistEdit()
                    var
                        NewBrRec: Page "New Breakdown Card";
                    begin
                        // Clear(SampleList);
                        // SampleList.LookupMode(true);
                        NewBrRec.PassParameters(rec."No.");
                        NewBrRec.Run();
                    end;
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                }

                field("Size Range Name"; rec."Size Range Name")
                {
                    ApplicationArea = All;
                    Caption = 'Size Range';
                }

                field("Merchandiser Name"; rec."Merchandiser Name")
                {
                    ApplicationArea = All;
                }

                field("Order Qty"; rec."Order Qty")
                {
                    ApplicationArea = All;
                }

                field("Created Date"; rec."Created Date")
                {
                    ApplicationArea = All;
                }

                field("Ship Date"; rec."Ship Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}