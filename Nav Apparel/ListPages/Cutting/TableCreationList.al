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
    begin
        TableCreLineRec.SetRange("TableCreNo.", Rec.TableCreNo);
        TableCreLineRec.DeleteAll();
    end;
}