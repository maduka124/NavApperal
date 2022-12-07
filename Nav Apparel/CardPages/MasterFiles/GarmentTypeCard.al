page 50954 "Garment Type Card"
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
                field("No."; rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        GarmentType: Page "Garment Type Lookup Card";
                        GarmentTypRec: Record "Garment Type";
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        IF rec.Type = rec.Type::Set THEN begin
                            GarmentTypRec.Reset();
                            GarmentTypRec.SetFilter(Code, '<> MIX');

                            if Page.RunModal(71012748, GarmentTypRec) = Action::LookupOK then begin
                                GarmentTypRec.SetRange(Selected, true);
                                if GarmentTypRec.FindSet() then
                                    repeat
                                        rec."Garment Type Description" += GarmentTypRec.Code + ',';
                                    until GarmentTypRec.Next() = 0;
                            end;

                            rec.Code := 'MIX';
                        end
                        else begin
                            rec.Code := '';
                            rec."Garment Type Description" := '';
                        end;


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

                field(Code; rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type Code';
                    ShowMandatory = true;
                }

                field("Garment Type Description"; rec."Garment Type Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field(Category; rec.Category)
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Garment Type Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;

}