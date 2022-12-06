page 50769 "Bank Ref Collection List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BankRefCollectionHeader;
    CardPageId = "Bank Ref Collection Card";
    Editable = false;
    SourceTableView = sorting("BankRefNo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("BankRefNo."; Rec."BankRefNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Reference No';
                }

                field("Release Amount"; Rec."Release Amount")
                {
                    ApplicationArea = All;
                }

                field("Release Date"; Rec."Release Date")
                {
                    ApplicationArea = All;
                }

                field("Exchange Rate"; Rec."Exchange Rate")
                {
                    ApplicationArea = All;
                }

                field("Margin A/C Amount"; Rec."Margin A/C Amount")
                {
                    ApplicationArea = All;
                }

                field("Bank Charges"; Rec."Bank Charges")
                {
                    ApplicationArea = All;
                }

                field(Tax; Rec.Tax)
                {
                    ApplicationArea = All;
                }

                field("Currier Charges"; Rec."Currier Charges")
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
        BankRefeCollRec: Record BankRefCollectionLine;
    begin
        BankRefeCollRec.Reset();
        BankRefeCollRec.SetRange("BankRefNo.", Rec."BankRefNo.");
        if BankRefeCollRec.FindSet() then
            BankRefeCollRec.Delete();
    end;
}