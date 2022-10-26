page 50757 "Style SMV Pending List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Style Master";
    SourceTableView = sorting("No.") order(descending) where(CostingSMV = filter(0));
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
                field("Style No."; "Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style';

                    trigger OnAssistEdit()
                    var
                        NewBrRec: Page "New Breakdown Card";
                    begin
                        // Clear(SampleList);
                        // SampleList.LookupMode(true);
                        NewBrRec.PassParameters("No.");
                        NewBrRec.Run();
                    end;
                }

                field("Store Name"; "Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                }

                field("Season Name"; "Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                }

                field("Brand Name"; "Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Garment Type Name"; "Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                }

                field("Size Range Name"; "Size Range Name")
                {
                    ApplicationArea = All;
                    Caption = 'Size Range';
                }

                field("Merchandiser Name"; "Merchandiser Name")
                {
                    ApplicationArea = All;
                }

                field("Order Qty"; "Order Qty")
                {
                    ApplicationArea = All;
                }

                field("Created Date"; "Created Date")
                {
                    ApplicationArea = All;
                }

                field("Ship Date"; "Ship Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}