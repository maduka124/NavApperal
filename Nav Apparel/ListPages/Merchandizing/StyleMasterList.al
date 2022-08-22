page 71012729 "Style Master"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Style Master";
    SourceTableView = sorting("No.") order(descending) where(Status = filter(Confirmed));
    CardPageId = "Style Master Card";
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
    // StyleMasterPORec: Record "Style Master PO";
    begin
        //StyleMasterPORec.SetRange("Style No.", "No.");
        //StyleMasterPORec.DeleteAll();
        Error('Style already confirmed. Cannot delete.');

    end;
}