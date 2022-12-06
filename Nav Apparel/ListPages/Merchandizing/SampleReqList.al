page 51063 "Sample Request"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sample Requsition Header";
    CardPageId = "Sample Request Card";
    SourceTableView = sorting("No.") order(descending);
    Caption = 'Sample Requisition';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Request No';
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }

                field("Wash Type Name"; rec."Wash Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Type';
                }

                //Done By Sachith -22/10/20
                field("Global Dimension Code"; rec."Global Dimension Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        SampleReqLineRec: Record "Sample Requsition Line";
        SampleReqAcceRec: Record "Sample Requsition Acce";
        SampleReqDocRec: Record "Sample Requsition Doc";
    begin

        if rec.WriteToMRPStatus = 1 then
            Error('Sample request has been posted already. You cannot delete.');

        SampleReqLineRec.Reset();
        SampleReqLineRec.SetRange("No.", rec."No.");
        SampleReqLineRec.DeleteAll();

        SampleReqAcceRec.Reset();
        SampleReqAcceRec.SetRange("No.", rec."No.");
        SampleReqAcceRec.DeleteAll();

        SampleReqDocRec.Reset();
        SampleReqDocRec.SetRange("No.", rec."No.");
        SampleReqDocRec.DeleteAll();

    end;


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