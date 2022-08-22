page 50507 "Contract Commision ListPart"
{
    PageType = ListPart;
    SourceTable = "Contract Commision";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Commision; Commision)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ItemChargeRec: Record "Item Charge";
                    begin
                        ItemChargeRec.Reset();
                        ItemChargeRec.SetRange(Description, "Commision");

                        if ItemChargeRec.FindSet() then
                            "Commision No." := ItemChargeRec."No.";
                    end;
                }

                field(Currency; Currency)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        CurrencyRec: Record Currency;
                    begin
                        CurrencyRec.Reset();
                        CurrencyRec.SetRange(Description, Currency);
                        if CurrencyRec.FindSet() then
                            "Currency No." := CurrencyRec.Code;
                    end;
                }

                field(Percentage; Percentage)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        "Contract/LCMasterRec": Record "Contract/LCMaster";
                    begin
                        "Contract/LCMasterRec".Reset();
                        "Contract/LCMasterRec".SetRange("No.", "No.");
                        "Contract/LCMasterRec".FindSet();
                        Amount := ("Contract/LCMasterRec"."Auto Calculate Value" * Percentage) / 100;
                    end;
                }

                field(Amount; Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}