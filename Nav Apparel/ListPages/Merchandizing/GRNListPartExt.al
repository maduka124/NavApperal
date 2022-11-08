pageextension 71012851 GRNListExt extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        // modify("Location Code")
        // {
        //     ShowMandatory = true;
        // }

        addafter(Description)
        {
            field("Buyer Name"; "Buyer Name")
            {
                ApplicationArea = all;
                Caption = 'Buyer';
                Editable = false;

                trigger OnValidate()
                var
                    BuyerRec: Record Customer;
                begin
                    BuyerRec.Reset();
                    BuyerRec.SetRange(Name, "Buyer Name");
                    if BuyerRec.FindSet() then
                        "Buyer No." := BuyerRec."No.";
                end;
            }

            field(StyleName; StyleName)
            {
                ApplicationArea = all;
                Caption = 'Style';
                Editable = false;
            }
        }
    }
}