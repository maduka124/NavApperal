page 50440 "Sample Status List"
{
    PageType = List;
    AutoSplitKey = true;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sample Requsition Line";
    Editable = false;
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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

                field("Sample Name"; rec."Sample Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sample';
                }

                field("Fabrication Name"; rec."Fabrication Name")
                {
                    ApplicationArea = All;
                    Caption = 'Fabrication';
                }

                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                }

                field(Size; rec.Size)
                {
                    ApplicationArea = All;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Complete';
                }

                field("Complete Qty"; rec."Complete Qty")
                {
                    ApplicationArea = All;
                }

                field("Req Date"; rec."Req Date")
                {
                    ApplicationArea = All;
                }

                field(Comment; rec.Comment)
                {
                    ApplicationArea = All;
                }

                field("Created User"; rec."Created User")
                {
                    ApplicationArea = All;
                }

                field("Created Date"; rec."Created Date")
                {
                    ApplicationArea = All;
                }

                field("Plan Start Date"; rec."Plan Start Date")
                {
                    ApplicationArea = All;
                }

                field("Plan End Date"; rec."Plan End Date")
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
}