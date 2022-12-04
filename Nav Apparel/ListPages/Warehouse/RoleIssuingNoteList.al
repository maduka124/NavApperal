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
                field("RoleIssuNo."; rec."RoleIssuNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Roll Issuing No';
                }

                field("Req No."; rec."Req No.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Req. No';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                }

                field(OnHandQty; rec.OnHandQty)
                {
                    ApplicationArea = All;
                    Caption = 'On Hand Qty';
                }

                field("Required Width"; rec."Required Width")
                {
                    ApplicationArea = All;
                }

                field("Required Length"; rec."Required Length")
                {
                    ApplicationArea = All;
                }

                field("Selected Qty"; rec."Selected Qty")
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
        LaySheetRec.SetRange("LaySheetNo.", rec."RoleIssuNo.");

        if LaySheetRec.FindSet() then begin
            Message('Cannot delete. Role Issue No already used in the Laysheet No : %1', LaySheetRec."LaySheetNo.");
            exit(false);
        end;

        RoleIssuingNoteLineRec.reset();
        RoleIssuingNoteLineRec.SetRange("RoleIssuNo.", rec."RoleIssuNo.");
        RoleIssuingNoteLineRec.DeleteAll();
    end;

}