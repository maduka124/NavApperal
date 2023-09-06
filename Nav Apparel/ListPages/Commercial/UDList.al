page 51206 "UD List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = UDHeader;
    CardPageId = "UD Card";
    Editable = false;
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'UD No';
                }

                field(Buyer; Rec.Buyer)
                {
                    ApplicationArea = All;
                }

                field("LC/Contract No."; Rec."LC/Contract No.")
                {
                    ApplicationArea = All;
                }

                field(Factory; rec.Factory)
                {
                    ApplicationArea = All;
                    Caption = 'Company';
                }

                field(Qantity; Rec.Qantity)
                {
                    ApplicationArea = All;
                }

                field(Value; rec.Value)
                {
                    ApplicationArea = All;
                }

                field("B2BLC%"; Rec."B2BLC%")
                {
                    ApplicationArea = All;
                }

                field(UDQty; rec.UDQty)
                {
                    ApplicationArea = All;
                    Caption = 'UD Qty';
                }

                field(UDValue; rec.UDValue)
                {
                    ApplicationArea = All;
                    Caption = 'UD Value';
                }

                field(UDBalance; rec.UDBalance)
                {
                    ApplicationArea = All;
                    Caption = 'UD Balance';
                }

                field(UDBalanceValue; rec.UDBalanceValue)
                {
                    ApplicationArea = All;
                    Caption = 'UD Balance Value';
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
        UDBBLcInfoRec: Record UDBBLcInformation;
        UDStyPOInfoRec: Record UDStylePOinformation;
        UDPIInfoRec: Record UDPIinformationLine;
    begin

        UDBBLcInfoRec.Reset();
        UDBBLcInfoRec.SetRange("No.", rec."No.");
        if UDBBLcInfoRec.FindSet() then
            UDBBLcInfoRec.DeleteAll();

        UDStyPOInfoRec.Reset();
        UDStyPOInfoRec.SetRange("No.", rec."No.");
        if UDStyPOInfoRec.FindSet() then
            UDStyPOInfoRec.DeleteAll();

        UDPIInfoRec.Reset();
        UDPIInfoRec.SetRange("No.", rec."No.");
        if UDPIInfoRec.FindSet() then
            UDPIInfoRec.DeleteAll();
    end;
}