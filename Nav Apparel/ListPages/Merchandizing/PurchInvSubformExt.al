pageextension 51469 PurchInvSubform extends "Purch. Invoice Subform"
{
    layout
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                GLRec: Record "G/L Account";
                ItemRec: Record Item;
                ResourseRec: Record Resource;
                FixREc: Record "Fixed Asset";
                ItemChargeRec: Record "Item Charge";
            begin
                ItemChargeRec.Reset();
                ItemChargeRec.SetRange("No.", Rec."No.");
                if ItemChargeRec.FindSet() then begin
                    Rec."Account Name" := ItemChargeRec.Description;
                    Rec.Modify();
                    CurrPage.Update();
                end;

                GLRec.Reset();
                GLRec.SetRange("No.", Rec."No.");
                if GLRec.FindSet() then begin
                    Rec."Account Name" := GLRec.Name;
                    Rec.Modify();
                    CurrPage.Update();
                end;

                ItemRec.Reset();
                ItemRec.SetRange("No.", Rec."No.");
                if ItemRec.FindSet() then begin
                    Rec."Account Name" := ItemRec.Description;
                    Rec.Modify();
                    CurrPage.Update();
                end;

                ResourseRec.Reset();
                ResourseRec.SetRange("No.", Rec."No.");
                if ResourseRec.FindSet() then begin
                    Rec."Account Name" := ResourseRec.Name;
                    Rec.Modify();
                    CurrPage.Update();
                end;

                FixREc.Reset();
                FixREc.SetRange("No.", Rec."No.");
                if FixREc.FindSet() then begin
                    Rec."Account Name" := FixREc.Description;
                    Rec.Modify();
                    CurrPage.Update();
                end;

            end;
        }
        addafter("No.")
        {

            field("Account Name"; Rec."Account Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
}