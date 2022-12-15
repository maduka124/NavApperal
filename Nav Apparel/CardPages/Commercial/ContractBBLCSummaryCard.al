page 50791 "ContractBBLCSummaryCard"
{
    PageType = Card;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = "Contract/LCMaster";
    Caption = 'Contract BBLC Summary';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Buyer; rec.Buyer)
                {
                    ApplicationArea = All;
                }

                field("Contract No"; rec."Contract No")
                {
                    ApplicationArea = All;
                }

                field("Amount"; "Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("BBLC Limit"; "BBLC LIMIT")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("BBLC Amount"; "BBLC AMOUNT")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("BBLC Opened"; "BBLC OPENED")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("B2B LC Opened (%)"; "BBLC OPENED %")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(" ")
            {
                part("Contract BBLC Summary ListPart1"; "ContractBBLC Summary ListPart1")
                {
                    ApplicationArea = All;
                    Caption = 'B2BLC Details';
                    SubPageLink = "LC/Contract No." = FIELD("Contract No");
                }
            }

            group("  ")
            {
                part("Contract BBLC Summary ListPart2"; "ContractBBLC Summary ListPart2")
                {
                    ApplicationArea = All;
                    Caption = 'Awaiting POs';
                    SubPageLink = "Contract No" = field("Contract No");
                }
            }
        }
    }


    trigger OnOpenPage()
    var
        "ContLCMasRec": Record "Contract/LCMaster";
        B2BRec: Record B2BLCMaster;
        AwaitingPOsRec: Record AwaitingPOs;
        AwaitingPOs2Rec: Record AwaitingPOs;
        PurchaseHeadeaerRec: Record "Purchase Header";
        PurchaselineRec: Record "Purchase Line";
        ContractStyleRec: Record "Contract/LCStyle";
    begin

        ContLCMasRec.Reset();
        ContLCMasRec.SetRange("Contract No", rec."Contract No");
        if ContLCMasRec.FindSet() then begin
            Amount := ContLCMasRec."Contract Value";
            "BBLC Limit" := ContLCMasRec.BBLC;
            "BBLC AMOUNT" := (ContLCMasRec."Contract Value" * ContLCMasRec.BBLC) / 100;
        end;

        //Calculate B2B LC opened and %
        B2BRec.Reset();
        B2BRec.SetRange("LC/Contract No.", rec."Contract No");

        if B2BRec.FindSet() then begin
            repeat
                "BBLC Opened" += B2BRec."B2B LC Value";
            until B2BRec.Next() = 0;
            "BBLC OPENED %" := ("BBLC Opened" / "Amount") * 100;
        end;

        //Done By Sachith 14/12/22
        //Delete Old Records
        AwaitingPOsRec.Reset();
        AwaitingPOsRec.SetRange("Contract No", Rec."Contract No");

        if AwaitingPOsRec.FindSet() then
            AwaitingPOsRec.DeleteAll();

        ContractStyleRec.Reset();
        ContractStyleRec.SetRange("No.", Rec."No.");

        if ContractStyleRec.FindSet() then begin

            repeat

                PurchaselineRec.Reset();
                PurchaselineRec.SetRange(StyleNo, ContractStyleRec."Style No.");

                if PurchaselineRec.FindSet() then begin
                    repeat

                        AwaitingPOsRec.Reset();
                        AwaitingPOsRec.SetRange("Contract No", Rec."Contract No");
                        AwaitingPOsRec.SetRange("Style No", ContractStyleRec."Style No.");
                        AwaitingPOsRec.SetRange("PO No", PurchaselineRec."Document No.");

                        if not AwaitingPOsRec.FindSet() then begin
                            AwaitingPOsRec.Init();
                            AwaitingPOsRec."Contract No" := Rec."Contract No";
                            AwaitingPOsRec."No." := Rec."No.";
                            AwaitingPOsRec."Style Name" := ContractStyleRec."Style Name";
                            AwaitingPOsRec."Style No" := ContractStyleRec."Style No.";
                            AwaitingPOsRec."PO No" := PurchaselineRec."Document No.";
                            AwaitingPOsRec.Insert();
                            CurrPage.Update();
                        end;

                        PurchaseHeadeaerRec.Reset();
                        PurchaseHeadeaerRec.SetRange("No.", AwaitingPOsRec."PO No");
                        PurchaseHeadeaerRec.SetFilter("Assigned PI No.", '%1', '');

                        if PurchaseHeadeaerRec.FindSet() then begin

                            AwaitingPOsRec."Amount Including VAT" := PurchaseHeadeaerRec."Amount Including VAT";
                            AwaitingPOsRec."Buy-from Vendor Name" := PurchaseHeadeaerRec."Buy-from Vendor Name";
                            AwaitingPOsRec."Document Date" := PurchaseHeadeaerRec."Document Date";
                            AwaitingPOsRec."No." := PurchaseHeadeaerRec."Buy-from Vendor No.";
                            AwaitingPOsRec.Modify();
                            CurrPage.Update();

                        end;
                    until PurchaselineRec.Next() = 0;
                end;
            until ContractStyleRec.Next() = 0;
        end;
    end;

    var
        Amount: Decimal;
        "BBLC LIMIT": Decimal;
        "BBLC AMOUNT": Decimal;
        "BBLC OPENED": Decimal;
        "BBLC OPENED %": decimal;
}