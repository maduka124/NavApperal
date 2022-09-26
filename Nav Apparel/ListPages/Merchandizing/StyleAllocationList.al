page 71012732 "Style Allocation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Style Master";
    SourceTableView = sorting("No.") order(descending) where(Status = filter(Confirmed));
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = true;

                field("Style No."; "Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    Editable = false;
                }

                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        Locationrec: Record Location;
                    begin
                        Locationrec.Reset();
                        Locationrec.SetRange(Name, "Factory Name");
                        if Locationrec.FindSet() then
                            "Factory Code" := Locationrec.Code;
                    end;
                }

                field("Global Dimension Code";"Global Dimension Code")
                {
                    ApplicationArea = All;                 
                    ShowMandatory = true;                   
                }

                field("Merchandiser Code"; "Merchandiser Code")
                {
                    ApplicationArea = All;
                    Caption = 'Merchandiser';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        UserRec: Record User;
                    begin
                        UserRec.Reset();
                        UserRec.SetRange("User Name", "Merchandiser Code");

                        if UserRec.FindFirst() then
                            "Merchandiser Name" := UserRec."Full Name"
                        else
                            "Merchandiser Name" := '';
                    end;
                }

                field("Store Name"; "Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                    Editable = false;
                }

                field("Season Name"; "Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                    Editable = false;
                }

                field("Brand Name"; "Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                    Editable = false;
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                    Editable = false;
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Garment Type Name"; "Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                    Editable = false;
                }

                field("Size Range Name"; "Size Range Name")
                {
                    ApplicationArea = All;
                    Caption = 'Size Range';
                    Editable = false;
                }

                field("Order Qty"; "Order Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Lead Time"; "Lead Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Ship Date"; "Ship Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(SMV; SMV)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}