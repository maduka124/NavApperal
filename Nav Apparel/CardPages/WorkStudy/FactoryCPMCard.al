page 50776 "Factory CPM Card"
{
    PageType = Card;
    SourceTable = "Factory CPM";
    Caption = 'Factory Wise CPM';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Factory Name"; rec."Factory Name")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                    Caption = 'Factory';

                    trigger OnValidate()
                    var
                        Locationrec: Record Location;
                        FacCPMRec: Record "Factory CPM";
                        LineNo: Integer;
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


                        Locationrec.Reset();
                        Locationrec.SetRange(Name, rec."Factory Name");
                        if Locationrec.FindSet() then
                            rec."Factory Code" := Locationrec.Code;

                        //Get Max line no
                        FacCPMRec.Reset();
                        FacCPMRec.SetRange("Factory Code", Locationrec.Code);

                        if FacCPMRec.FindLast() then
                            LineNo := FacCPMRec."Line No";

                        rec."Line No" := LineNo + 1;
                        CurrPage.Update();
                    end;
                }

                field(CPM; rec.CPM)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                }
            }
        }
    }

    trigger OnClosePage()
    var
    begin
        if (rec."Factory Name" <> '') and (rec.CPM = 0) then
            Error('CPM is blank.');

        if (rec."Factory Name" = '') and (rec.CPM > 0) then
            Error('Factory is blank.');
    end;
}