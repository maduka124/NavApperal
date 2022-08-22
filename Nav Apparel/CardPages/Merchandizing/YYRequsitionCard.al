page 71012822 "YY Requsition Card"
{
    PageType = Card;
    SourceTable = "YY Requsition Header";
    Caption = 'YY Requisition';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'YY Request No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange("Name", "Buyer Name");
                        if BuyerRec.FindSet() then begin
                            "Buyer No." := BuyerRec."No.";
                            CurrPage.Update();
                        end;
                    end;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        StyleMasRec: Record "Style Master";
                    begin

                        StyleMasRec.Reset();
                        StyleMasRec.SetRange("Style No.", "Style Name");
                        if StyleMasRec.FindSet() then begin
                            "Style No." := StyleMasRec."No.";
                        end;
                    end;
                }

                field("Garment Type Name"; "Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';

                    trigger OnValidate()
                    var
                        GarmentTypeRec: Record "Garment Type";
                    begin
                        GarmentTypeRec.Reset();
                        GarmentTypeRec.SetRange("Garment Type Description", "Garment Type Name");
                        if GarmentTypeRec.FindSet() then
                            "Garment Type No." := GarmentTypeRec."No.";
                    end;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
            }

            group("YY Request Details")
            {
                part("YY Requsition ListPart"; "YY Requsition ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No.");
                }
            }
        }
    }

    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Sample YY Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        YYReqLineRec: Record "YY Requsition Line";
    begin
        YYReqLineRec.Reset();
        YYReqLineRec.SetRange("No.", "No.");
        YYReqLineRec.DeleteAll();
    end;

}