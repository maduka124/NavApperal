page 71012670 "Assortment Details"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Style Master";
    CardPageId = "Assortment Card";
    SourceTableView = sorting("No.") order(descending) where(Status = filter(Confirmed));
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;

                field("Style No."; "Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                }

                field("Merchandiser Name"; "Merchandiser Name")
                {
                    ApplicationArea = All;
                    Caption = 'Merchandiser';
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

                field("Order Qty"; "Order Qty")
                {
                    ApplicationArea = All;
                }

                field("Lead Time"; "Lead Time")
                {
                    ApplicationArea = All;
                }

                field("Ship Date"; "Ship Date")
                {
                    ApplicationArea = All;
                }

                field(SMV; SMV)
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
   

    trigger OnDeleteRecord(): Boolean
    var
    begin
        Error('Style already confirmed. Cannot delete.');
    end;


}