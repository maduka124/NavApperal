pageextension 71012764 ItemTrackingLinesExt extends "Item Tracking Lines"
{
    layout
    {
        addafter("Lot No.")
        {
            field("Supplier Batch No."; rec."Supplier Batch No.")
            {
                ApplicationArea = ALL;
            }

            field(InvoiceNo; rec.InvoiceNo)
            {
                ApplicationArea = ALL;
            }

            field("Color"; rec."Color")
            {
                ApplicationArea = ALL;

                trigger OnValidate()
                var
                    ColourRec: Record Colour;
                begin
                    ColourRec.Reset();
                    ColourRec.SetRange("Colour Name", rec.Color);
                    if ColourRec.FindSet() then
                        rec."Color No" := ColourRec."No.";

                    CurrPage.Update();
                end;
            }

            field("Shade No"; rec."Shade No")
            {
                ApplicationArea = ALL;

                trigger OnValidate()
                var
                    ShadeRec: Record Shade;
                begin
                    ShadeRec.Reset();
                    ShadeRec.SetRange("No.", rec."Shade No");
                    if ShadeRec.FindSet() then
                        rec.Shade := ShadeRec.Shade;
                end;
            }

            field(Shade; rec.Shade)
            {
                ApplicationArea = ALL;
                Editable = false;
            }

            field("Length Tag"; rec."Length Tag")
            {
                ApplicationArea = ALL;
            }

            field("Length Act"; rec."Length Act")
            {
                ApplicationArea = ALL;
            }

            field("Width Tag"; rec."Width Tag")
            {
                ApplicationArea = ALL;
            }

            field("Width Act"; rec."Width Act")
            {
                ApplicationArea = ALL;
            }
        }
    }
}