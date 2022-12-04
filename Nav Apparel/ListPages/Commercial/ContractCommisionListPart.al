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
                field(Commision; Rec.Commision)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ItemChargeRec: Record "Item Charge";
                    begin
                        ItemChargeRec.Reset();
                        ItemChargeRec.SetRange(Description, Rec."Commision");

                        if ItemChargeRec.FindSet() then
                            Rec."Commision No." := ItemChargeRec."No.";
                    end;
                }

                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        CurrencyRec: Record Currency;
                    begin
                        CurrencyRec.Reset();
                        CurrencyRec.SetRange(Description, Rec.Currency);
                        if CurrencyRec.FindSet() then
                            Rec."Currency No." := CurrencyRec.Code;
                    end;
                }

                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        "Contract/LCMasterRec": Record "Contract/LCMaster";
                    begin
                        "Contract/LCMasterRec".Reset();
                        "Contract/LCMasterRec".SetRange("No.", Rec."No.");
                        "Contract/LCMasterRec".FindSet();
                        Rec.Amount := ("Contract/LCMasterRec"."Auto Calculate Value" * Rec.Percentage) / 100;
                    end;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}