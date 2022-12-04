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
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Request No';
                    Editable = false;
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Created User"; rec."Created User")
                {
                    ApplicationArea = All;
                    Caption = 'Merchant';
                    Editable = false;
                }

                field("Created Date"; rec."Created Date")
                {
                    ApplicationArea = All;
                    Caption = 'Ent. Date';
                    Editable = false;
                }

                field("Sample Room Name"; rec."Sample Room Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Room';
                    Editable = false;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Group HD"; rec."Group HD")
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
                Scope = Repeater;
                Promoted = true;

                trigger OnAction()
                var
                    WIP: Record wip;
                begin
                    wip.Reset();
                    wip.FindSet();
                    wip.ModifyAll("Req No.", rec."No.");
                end;
            }
        }
    }
}