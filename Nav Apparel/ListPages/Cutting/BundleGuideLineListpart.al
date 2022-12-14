page 50669 BundleGuideLineListpart
{
    PageType = ListPart;
    SourceTable = BundleGuideLine;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Bundle No"; "Bundle No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Cut No"; "Cut No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(SJCNo; SJCNo)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Sew. Job No';
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Color';
                }

                field("Role ID"; "Role ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Roll ID';
                }

                field("Shade Name"; "Shade Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ShadeRec: Record Shade;
                    begin
                        ShadeRec.Reset();
                        ShadeRec.SetRange(Shade, "Shade Name");
                        if ShadeRec.FindSet() then
                            "Shade No" := ShadeRec."No.";

                        CurrPage.Update();

                    end;
                }

                field("Sticker Sequence"; "Sticker Sequence")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Size; Size)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Generate Barcode")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    BarcodeString: Text;
                    BarcodeSymbology: Enum "Barcode Symbology";
                    BarcodeFontProvider: Interface "Barcode Font Provider";
                    Temp: Text;
                begin


                    BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
                    BarcodeString := "BundleGuideNo.";
                    BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                    EncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
                    Temp := EncodedText.Replace('(', '');
                    Barcode := Temp.Replace(')', '');

                    CurrPage.Update();
                end;
            }
        }
    }

    var

        EncodedText: Text;


}