pageextension 71012764 ItemTrackingLinesExt extends "Item Tracking Lines"
{
    layout
    {
        addafter("Lot No.")
        {
            field("Supplier Batch No."; "Supplier Batch No.")
            {
                ApplicationArea = ALL;
            }

            field(InvoiceNo; InvoiceNo)
            {
                ApplicationArea = ALL;
            }

            field("Color"; "Color")
            {
                ApplicationArea = ALL;

                trigger OnValidate()
                var
                    ColourRec: Record Colour;
                begin
                    ColourRec.Reset();
                    ColourRec.SetRange("Colour Name", Color);
                    if ColourRec.FindSet() then
                        "Color No" := ColourRec."No.";

                    CurrPage.Update();
                end;
            }

            field("Shade No"; "Shade No")
            {
                ApplicationArea = ALL;

                trigger OnValidate()
                var
                    ShadeRec: Record Shade;
                begin
                    ShadeRec.Reset();
                    ShadeRec.SetRange("No.", "Shade No");
                    if ShadeRec.FindSet() then
                        Shade := ShadeRec.Shade;
                end;
            }

            field(Shade; Shade)
            {
                ApplicationArea = ALL;
                Editable = false;
            }

            field("Length Tag"; "Length Tag")
            {
                ApplicationArea = ALL;
            }

            field("Length Act"; "Length Act")
            {
                ApplicationArea = ALL;
            }

            field("Width Tag"; "Width Tag")
            {
                ApplicationArea = ALL;
            }

            field("Width Act"; "Width Act")
            {
                ApplicationArea = ALL;
            }
        }
    }
}