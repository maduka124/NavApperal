page 50616 "Table Creation Card"
{
    PageType = Card;
    SourceTable = TableCreation;
    Caption = 'Cutting Table Planning';

    layout
    {
        area(Content)
        {
            group(General)
            {

                Editable = EditableGB;

                field(TableCreNo; rec.TableCreNo)
                {
                    ApplicationArea = All;
                    Caption = 'Table Creation No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Plan Date"; rec."Plan Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                        UserRec: Record "User Setup";
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

                        //Done By Sachith on 03/04/23 
                        UserRec.Reset();
                        UserRec.Get(UserId);

                        if UserRec."Factory Code" <> '' then begin
                            Rec."Factory Code" := UserRec."Factory Code";
                            CurrPage.Update();
                        end
                        else
                            Error('Factory not assigned for the user.');

                    end;
                }

                field("Table Name"; rec."Table Name")
                {
                    ApplicationArea = All;
                    Caption = 'Table No';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        TableMasterRec: Record TableMaster;
                    begin
                        TableMasterRec.Reset();
                        TableMasterRec.SetRange("Table Name", rec."Table Name");
                        if TableMasterRec.FindSet() then
                            rec."Table No." := TableMasterRec."Table No.";
                    end;
                }
            }

            group("Tables")
            {
                Editable = EditableGB;
                part("Table Creation Line ListPart"; "Table Creation Line ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "TableCreNo." = FIELD(TableCreNo);
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."TableCre Nos.", xRec.TableCreNo, rec.TableCreNo) THEN BEGIN
            NoSeriesMngment.SetSeries(rec.TableCreNo);
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        TableCreLineRec: Record TableCreartionLine;
        UserRec: Record "User Setup";
    begin

        //Done By sachith on 06/04/23
        UserRec.Reset();
        UserRec.Get(UserId);

        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.')
        end
        else
            Error('You are not authorized to delete records.');

        TableCreLineRec.SetRange("TableCreNo.", rec.TableCreNo);
        TableCreLineRec.DeleteAll();
    end;

    //Done By Sachith on 03/04/23 
    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin

        UserRec.Reset();
        UserRec.Get(UserId);

        if rec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> '') then begin
                if (UserRec."Factory Code" = rec."Factory Code") then
                    EditableGB := true
                else
                    EditableGB := false;
            end
            else
                EditableGB := false;
        end
        else
            if (UserRec."Factory Code" = '') then begin
                Error('Factory not assigned for the user.');
                EditableGB := false;
            end
            else
                EditableGB := true;
    end;

    var
        EditableGB: Boolean;
}