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
                field(Buyer;rec.Buyer)
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
                    //SubPageLink = "LC/Contract No." = FIELD("Contract No");
                }
            }
        }
    }


    trigger OnOpenPage()
    var
        "ContLCMasRec": Record "Contract/LCMaster";
        B2BRec: Record B2BLCMaster;
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

        //Balance := "B2B LC Limit" - "BBLC Opened";
    end;


    var
        Amount: Decimal;
        "BBLC LIMIT": Decimal;
        "BBLC AMOUNT": Decimal;
        "BBLC OPENED": Decimal;
        "BBLC OPENED %": decimal;
}