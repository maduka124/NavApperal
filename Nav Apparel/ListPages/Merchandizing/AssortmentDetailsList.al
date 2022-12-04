page 51021 "Assortment Details"
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

                field("Style No."; rec."Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                }

                field("Merchandiser Name"; rec."Merchandiser Name")
                {
                    ApplicationArea = All;
                    Caption = 'Merchandiser';
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

                field("Order Qty"; rec."Order Qty")
                {
                    ApplicationArea = All;
                }

                field("Lead Time"; rec."Lead Time")
                {
                    ApplicationArea = All;
                }

                field("Ship Date"; rec."Ship Date")
                {
                    ApplicationArea = All;
                }

                field(SMV; rec.SMV)
                {
                    ApplicationArea = All;
                }

                field(Status; rec.Status)
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