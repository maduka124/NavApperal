page 50982 "Action Type Card"
{
    PageType = Card;
    SourceTable = "Action Type";
    Caption = 'Action Type ';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Action Type No';
                }

                field("Action Type"; rec."Action Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;
                    end;
                }

                // field(Barcode; Barcode)
                // {
                //     ApplicationArea = All;
                // }

                // field(BarcodeImage; BarcodeImage)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Barcode';
                // }
            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(Save)
    //         {
    //             ApplicationArea = All;

    //             trigger OnAction()
    //             var
    //                 BarcodeString: Text;
    //                 BarcodeSymbology: Enum "Barcode Symbology";
    //                 BarcodeFontProvider: Interface "Barcode Font Provider";
    //                 Temp: Text;

    //             // BarcodeSymbology: Enum "Barcode Symbology";
    //             // BarcodeFontProvider: Interface "Barcode Font Provider";


    //             begin

    //                 //method 1

    //                 BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
    //                 BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
    //                 BarcodeString := "No.";
    //                 BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
    //                 EncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
    //                 Temp := EncodedText.Replace('(', '');
    //                 Barcode := Temp.Replace(')', '');

    //                 CurrPage.Update();

    //                 //method 2
    //                 // BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
    //                 // BarcodeSymbology := Enum::"Barcode Symbology"::Code128;
    //                 // BarcodeFontProvider.ValidateInput("No.", BarcodeSymbology);
    //                 // EncodeTextCode128 := BarcodeFontProvider.EncodeFont("No.", BarcodeSymbology);
    //                 // InsertValues(EncodeTextCode128);

    //             end;
    //         }
    //     }
    // }

    // var
    //     // Variable for the barcode encoded string
    //     EncodedText: Text;

    //     //EncodeTextCode128: Text;

    // local procedure InsertValues(Input: text)
    // var
    //     ItemBarcode: Record "Action Type";
    //     oStream: OutStream;
    //     istream: InStream;
    // begin
    //     ItemBarcode.Reset();
    //     ItemBarcode.SetRange("No.", "No.");
    //     ItemBarcode.FindSet();

    //     ItemBarcode.Barcode := Input;

    //     ItemBarcode.BarcodeImage.CreateOutStream(oStream);
    //     oStream.WriteText(Input);
    //     ItemBarcode.BarcodeImage.CreateInStream(istream);
    //     CopyStream(oStream, istream);

    //     ItemBarcode.Modify();
    // end;

}