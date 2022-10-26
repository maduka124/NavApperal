page 50639 "Role Issuing Note List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = RoleIssuingNoteHeader;
    CardPageId = "Roll Issuing Note Card";
    SourceTableView = sorting("RoleIssuNo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("RoleIssuNo."; "RoleIssuNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Roll Issuing No';
                }

                field("Req No."; "Req No.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Req. No';
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                }

                field(OnHandQty; OnHandQty)
                {
                    ApplicationArea = All;
                    Caption = 'On Hand Qty';
                }

                field("Required Width"; "Required Width")
                {
                    ApplicationArea = All;
                }

                field("Required Length"; "Required Length")
                {
                    ApplicationArea = All;
                }

                field("Selected Qty"; "Selected Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        RoleIssuingNoteLineRec: Record RoleIssuingNoteLine;
        LaysheetRec: Record LaySheetHeader;
    begin

        //Check in the laysheet
        LaySheetRec.Reset();
        LaySheetRec.SetRange("LaySheetNo.", "RoleIssuNo.");

        if LaySheetRec.FindSet() then begin
            Message('Cannot delete. Role Issue No already used in the Laysheet No : %1', LaySheetRec."LaySheetNo.");
            exit(false);
        end;

        RoleIssuingNoteLineRec.reset();
        RoleIssuingNoteLineRec.SetRange("RoleIssuNo.", "RoleIssuNo.");
        RoleIssuingNoteLineRec.DeleteAll();
    end;

}