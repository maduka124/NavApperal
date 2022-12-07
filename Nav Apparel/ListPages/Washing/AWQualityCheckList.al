page 50688 AWQualityCheck
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = AWQualityCheckHeader;
    CardPageId = QCHeaderCardAW;
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'AW Quality Check No';
                }

                field("Job Card No"; rec."Job Card No")
                {
                    ApplicationArea = All;
                }

                field("Sample Req No"; rec."Sample Req No")
                {
                    ApplicationArea = All;
                }

                field(CustomerName; rec.CustomerName)
                {
                    ApplicationArea = All;
                    Caption = 'Customer';
                }

                field("Req date"; rec."Req date")
                {
                    ApplicationArea = All;
                }

                field("QC AW Date"; rec."QC AW Date")
                {
                    ApplicationArea = All;
                    Caption = 'AW QC Date';
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
        AWQualityCheckLineRec: Record AWQualityCheckLine;
    begin
        AWQualityCheckLineRec.Reset();
        AWQualityCheckLineRec.SetRange(No, rec."No.");
        if AWQualityCheckLineRec.FindSet() then
            AWQualityCheckLineRec.DeleteAll();
    end;

}