page 71012610 "Garment Type Card"
{
    PageType = Card;
    SourceTable = "Garment Type";
    Caption = 'Garment Type';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field(Type; Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        GarmentType: Page "Garment Type Lookup Card";
                        GarmentTypRec: Record "Garment Type";
                    begin
                        IF Type = Type::Set THEN begin
                            GarmentTypRec.Reset();
                            GarmentTypRec.SetFilter(Code, '<> MIX');

                            if Page.RunModal(71012748, GarmentTypRec) = Action::LookupOK then begin
                                GarmentTypRec.SetRange(Selected, true);
                                if GarmentTypRec.FindSet() then
                                    repeat
                                        "Garment Type Description" += GarmentTypRec.Code + ',';
                                    until GarmentTypRec.Next() = 0;
                            end;

                            Code := 'MIX';
                        end
                        else begin
                            Code := '';
                            "Garment Type Description" := '';
                        end;
                    end;
                }

                field(Code; Code)
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type Code';
                    ShowMandatory = true;
                }

                field("Garment Type Description"; "Garment Type Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field(Category; Category)
                {
                    ApplicationArea = All;
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Garment Type Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

}