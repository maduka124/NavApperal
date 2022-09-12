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

                field("Amount Including VAT"; "Amount Including VAT")
                {
                    ApplicationArea = All;
                    Caption = 'PO Value';
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
                    PIDetailsHeadRec: Record "PI Details Header";
                    PIPOItemDetRec: Record "PI Po Item Details";
                    PIPODetailsRec: Record "PI Po Details";
                    NavAppCodeUnitRec: Codeunit NavAppCodeUnit;
                    TotalValue: Decimal;
                    TotPOValue: Decimal;
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
                            PurchaseHeaderRec.CalcFields("Amount Including VAT");
                            PIPODetailsRec."PO Value" := PurchaseHeaderRec."Amount Including VAT";
                            PIPODetailsRec.Insert();

                            //Update Purchase order pi no
                            PurchaseHeaderRec."Assigned PI No." := PurchaseHeaderRec."PI No.";
                            PurchaseHeaderRec.Modify();

                        until PurchaseHeaderRec.Next() = 0;

                    end
                    else
                        Error('Select records.');

                    //Update Select as false
                    PurchaseHeaderRec.Reset();
                    PurchaseHeaderRec.SetRange("Buy-from Vendor No.", "Buy-from Vendor No.");
                    PurchaseHeaderRec.SetFilter(Select, '=%1', true);

                    if PurchaseHeaderRec.FindSet() then
                        PurchaseHeaderRec.ModifyAll(Select, false);

                    //Update PO_PI_Item table
                    NavAppCodeUnitRec.Update_PI_PO_Items("PI No.");

                    //calculate Total Items Value and Update Header Value
                    PIPOItemDetRec.Reset();
                    PIPOItemDetRec.SetRange("PI No.", "PI No.");

                    if PIPOItemDetRec.FindSet() then
                        repeat
                            TotalValue += PIPOItemDetRec.Value;
                        until PIPOItemDetRec.Next() = 0;


                    PIPODetailsRec.Reset();
                    PIPODetailsRec.SetRange("PI No.", "PI No.");

                    if PIPODetailsRec.FindSet() then begin
                        repeat
                            TotPOValue += PIPODetailsRec."PO Value";
                        until PIPODetailsRec.Next() = 0;
                    end;

                    PIDetailsHeadRec.Reset();
                    PIDetailsHeadRec.SetRange("No.", "PI No.");
                    PIDetailsHeadRec.FindSet();
                    PIDetailsHeadRec."PI Value" := TotalValue;
                    PIDetailsHeadRec."PO Total" := TotPOValue;
                    PIDetailsHeadRec.Modify();

                    CurrPage.Update();
                end;
            }
        }
    }
}