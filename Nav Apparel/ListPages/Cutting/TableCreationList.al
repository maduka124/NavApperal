page 50615 "Table Creation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = TableCreation;
    CardPageId = "Table Creation Card";
    SourceTableView = sorting(TableCreNo) order(descending);
    Caption = 'Cutting Table Planning';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(TableCreNo; Rec.TableCreNo)
                {
                    ApplicationArea = All;
                    Caption = 'Table Creation No';
                }

                field("Plan Date"; Rec."Plan Date")
                {
                    ApplicationArea = All;
                }

                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = All;
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

        TableCreLineRec.SetRange("TableCreNo.", Rec.TableCreNo);
        TableCreLineRec.DeleteAll();
    end;
}