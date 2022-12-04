pageextension 51045 GRNListExt extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        // modify("Location Code")
        // {
        //     ShowMandatory = true;
        // }

        addafter(Description)
        {
            field("Buyer Name"; rec."Buyer Name")
            {
                ApplicationArea = all;
                Caption = 'Buyer';
                Editable = false;

                trigger OnValidate()
                var
                    BuyerRec: Record Customer;
                begin
                    BuyerRec.Reset();
                    BuyerRec.SetRange(Name, rec."Buyer Name");
                    if BuyerRec.FindSet() then
                        rec."Buyer No." := BuyerRec."No.";
                end;
            }

            field(StyleName; rec.StyleName)
            {
                ApplicationArea = all;
                Caption = 'Style';
                Editable = false;
            }


        }
    }
}