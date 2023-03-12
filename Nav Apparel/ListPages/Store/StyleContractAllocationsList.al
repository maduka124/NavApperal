page 50841 "StyleContract Allocations List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Contract/LCStyle";
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("ContractNo"; "ContractNo")
                {
                    ApplicationArea = All;
                    Caption = 'Contract';
                }

                field(FactoryName; FactoryName)
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field(BuyerName; BuyerName)
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Order Qty';
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


    trigger OnAfterGetRecord()
    var
        CustomerRec: Record Customer;
        ContractRec: Record "Contract/LCMaster";
        LocationRec: Record Location;
        StyleMasterRec: Record "Style Master";
    begin

        //Get Contract No
        ContractRec.Reset();
        ContractRec.SetRange("No.", rec."No.");
        if ContractRec.FindSet() then
            ContractNo := ContractRec."Contract No";

        //Get Buyer name
        CustomerRec.Reset();
        CustomerRec.SetRange("No.", rec."Buyer No.");
        if CustomerRec.FindSet() then
            BuyerName := CustomerRec.Name;

        //Get Style details
        StyleMasterRec.Reset();
        StyleMasterRec.SetRange("No.", rec."Style No.");
        StyleMasterRec.FindSet();

        //Get factory name
        LocationRec.Reset();
        LocationRec.SetRange(code, StyleMasterRec."Factory Code");
        if LocationRec.FindSet() then
            FactoryName := LocationRec.Name;
    end;

    var
        FactoryName: Text[200];
        BuyerName: Text[200];
        ContractNo: Text[50];
}