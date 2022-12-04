page 51064 "Style Allocation"
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

                field("Style No."; rec."Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    Editable = false;
                }

                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        Locationrec: Record Location;
                    begin
                        Locationrec.Reset();
                        Locationrec.SetRange(Name, rec."Factory Name");
                        if Locationrec.FindSet() then
                            rec."Factory Code" := Locationrec.Code;
                    end;
                }

                field("Global Dimension Code"; rec."Global Dimension Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Merchandiser Code"; rec."Merchandiser Code")
                {
                    ApplicationArea = All;
                    Caption = 'Merchandiser';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        UserRec: Record User;
                    begin
                        UserRec.Reset();
                        UserRec.SetRange("User Name", rec."Merchandiser Code");

                        if UserRec.FindFirst() then
                            rec."Merchandiser Name" := UserRec."Full Name"
                        else
                            rec."Merchandiser Name" := '';
                    end;
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                    Editable = false;
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                    Editable = false;
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                    Editable = false;
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                    Editable = false;
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                    Editable = false;
                }

                field("Size Range Name"; rec."Size Range Name")
                {
                    ApplicationArea = All;
                    Caption = 'Size Range';
                    Editable = false;
                }

                field("Order Qty"; rec."Order Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Lead Time"; rec."Lead Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Ship Date"; rec."Ship Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(SMV; rec.SMV)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}