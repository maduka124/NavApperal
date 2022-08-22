page 71012790 "PI Po Details ListPart 1"
{
    PageType = ListPart;
    SourceTable = "Purchase Header";
    SourceTableView = where("Assigned PI No." = filter(''));
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Select; Select)
                {
                    ApplicationArea = All;
                }

                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action(Add)
            {
                ApplicationArea = All;
                Image = Add;

                trigger OnAction()
                var
                    PurchaseHeaderRec: Record "Purchase Header";
                    PIPODetailsRec: Record "PI Po Details";
                    NavAppCodeUnitRec: Codeunit NavAppCodeUnit;
                begin

                    PurchaseHeaderRec.Reset();
                    PurchaseHeaderRec.SetCurrentKey("Buy-from Vendor No.");
                    PurchaseHeaderRec.SetRange("Buy-from Vendor No.", "Buy-from Vendor No.");
                    PurchaseHeaderRec.SetFilter(Select, '=%1', true);

                    if PurchaseHeaderRec.FindSet() then begin

                        repeat
                            //add new po to the PI
                            PIPODetailsRec.Init();
                            PIPODetailsRec."PI No." := PurchaseHeaderRec."PI No.";
                            PIPODetailsRec."PO No." := PurchaseHeaderRec."No.";
                            PIPODetailsRec.Insert();

                            //Update Purchase order pi no
                            PurchaseHeaderRec."Assigned PI No." := PurchaseHeaderRec."PI No.";
                            PurchaseHeaderRec.Modify();

                        until PurchaseHeaderRec.Next() = 0;

                    end;

                    //Update Select as false
                    PurchaseHeaderRec.Reset();
                    PurchaseHeaderRec.SetRange("Buy-from Vendor No.", "Buy-from Vendor No.");
                    PurchaseHeaderRec.SetFilter(Select, '=%1', true);

                    if PurchaseHeaderRec.FindSet() then
                        PurchaseHeaderRec.ModifyAll(Select, false);

                    //Update PO_PI_Item table
                    NavAppCodeUnitRec.Update_PI_PO_Items("PI No.");

                    CurrPage.Update();
                end;
            }
        }
    }
}