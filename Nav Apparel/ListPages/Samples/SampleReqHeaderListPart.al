page 50427 "Sample Request Header ListPart"
{
    PageType = ListPart;
    SourceTable = "Sample Requsition Header";
    SourceTableView = where(Status = filter(Pending));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Request No';
                    Editable = false;
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Created User"; "Created User")
                {
                    ApplicationArea = All;
                    Caption = 'Merchant';
                    Editable = false;
                }

                field("Created Date"; "Created Date")
                {
                    ApplicationArea = All;
                    Caption = 'Ent. Date';
                    Editable = false;
                }

                field("Sample Room Name"; "Sample Room Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Room';
                    Editable = false;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Group HD"; "Group HD")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Load)
            {
                ApplicationArea = All;
                Image = GetOrder;

                trigger OnAction()
                var
                    WIP: Record wip;
                begin

                    wip.Reset();
                    wip.FindSet();
                    wip.ModifyAll("Req No.", "No.");

                end;
            }
        }
    }
}