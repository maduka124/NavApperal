page 50120 "Approved Daily Consump. List"
{
    ApplicationArea = All;
    Caption = 'Approved Raw Material Requisition List';
    PageType = List;
    SourceTable = "Daily Consumption Header";
    UsageCategory = Lists;
    SourceTableView = where(Status = filter(Approved));
    //CardPageId = 50102;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Buyer; Rec.Buyer)
                {
                    ApplicationArea = All;
                }
                field("Style No."; Rec."Style No.")
                {
                    ApplicationArea = All;
                }
                field(PO; rec.PO)
                {
                    ApplicationArea = All;
                }
                field("Colour Name"; rec."Colour Name")
                {
                    ApplicationArea = All;
                }
                field("Created UserID"; rec."Created UserID")
                {
                    Caption = 'User';
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved Date/Time"; rec."Approved Date/Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issued UserID"; rec."Issued UserID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issued Date/Time"; rec."Issued Date/Time")
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
            action("Material Request")
            {
                Caption = 'Material Issue';
                ApplicationArea = All;
                Image = ConsumptionJournal;
                Promoted = true;
                PromotedCategory = Process;

                // RunObject = page "Consumption Journal";
                // RunPageLink = "Daily Consumption Doc. No." = field("No.");
                trigger OnAction()
                var
                    ItemJnalRec: Record "Item Journal Line";
                    ItemJnlMgt: Codeunit ItemJnlManagement;

                begin
                    ItemJnalRec.Reset();
                    ItemJnalRec.SetRange("Journal Template Name", rec."Journal Template Name");
                    ItemJnlMgt.SetName(rec."Journal Batch Name", ItemJnalRec);
                    ItemJnalRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    ItemJnalRec.SetRange("Daily Consumption Doc. No.", rec."No.");

                    Page.RunModal(99000846, ItemJnalRec);

                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("Created UserID", UserId);
    end;
}
