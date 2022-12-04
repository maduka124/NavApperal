page 51067 "Style Master"
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

                field("Style No."; rec."Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
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
    // StyleMasterPORec: Record "Style Master PO";
    begin
        //StyleMasterPORec.SetRange("Style No.", "No.");
        //StyleMasterPORec.DeleteAll();
        Error('Style already confirmed. Cannot delete.');

    end;
}