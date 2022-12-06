page 50681 "FabricCodeList"
{
    PageType = List;
    SourceTable = FabricCodeMaster;
    CardPageId = FabricCodeCard;
    SourceTableView = sorting(FabricCode) order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(FabricCode; Rec.FabricCode)
                {
                    ApplicationArea = all;
                    Caption = 'Fabric Code';
                }

                field(Composition; Rec.Composition)
                {
                    ApplicationArea = All;
                }

                field(Construction; Rec.Construction)
                {
                    ApplicationArea = All;
                }

                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            // LoginSessionsRec.Reset();
            // LoginSessionsRec.SetRange(SessionID, SessionId());
            // if LoginSessionsRec.FindSet() then
            //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end
        else begin   //logged in
            //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end;

    end;
}