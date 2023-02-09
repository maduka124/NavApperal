page 50731 "Service Wrks Line List part"
{
    PageType = ListPart;
    SourceTable = ServiceWorksheetLineNew;
    Editable = true;
    ModifyAllowed = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTableView = sorting("Brand Name", "Model Name", "Machine Category") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Doc No"; rec."Doc No")
                {
                    ApplicationArea = All;
                    Caption = 'Document No';
                }

                field("Part No"; rec."Part No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Part Name"; rec."Part Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                    Editable = false;
                }

                field("Model Name"; rec."Model Name")
                {
                    ApplicationArea = All;
                    Caption = 'Model';
                    Editable = false;
                }

                field("Machine Category"; rec."Machine Category")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Category';
                    Editable = false;
                }

                field("Unit N0."; rec."Unit N0.")
                {
                    ApplicationArea = All;
                    Caption = 'Unit';
                    Editable = false;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Qty';
                }

                field("Service Date"; rec."Service Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Service Due Date';
                }

                field("Next Service Date"; rec."Next Service Date")
                {
                    ApplicationArea = All;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }

                field(Approval; rec.Approval)
                {
                    ApplicationArea = All;
                }

                field("Technician Name"; rec."Technician Name")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var

                    begin

                    end;
                }

            }
        }
    }
}