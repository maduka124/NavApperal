page 50659 WashingBOMList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Production BOM Header";
    CardPageId = "Production BOM";
    Caption = 'Recipe/Production BOM';
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
                    Caption = 'Recipe/Prod. BOM No';
                }

                field("Wash Type"; rec."Wash Type")
                {
                    ApplicationArea = All;

                }

                field("BOM Type"; rec."BOM Type")
                {
                    ApplicationArea = All;
                }

                field("Bulk/Sample"; rec."Bulk/Sample")
                {
                    ApplicationArea = All;
                }

                field("Lot Size (Kg)"; rec."Lot Size (Kg)")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                }

                field(Lot; rec.Lot)
                {
                    ApplicationArea = All;
                }

                field(Color; rec.Color)
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