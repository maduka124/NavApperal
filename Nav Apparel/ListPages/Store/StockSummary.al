page 50313 StockSummary
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Style Master";
    SourceTableView = where(Status = filter(Confirmed));
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    Caption = 'Stock Summary';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(FactoryName; Rec."Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory Name';
                }
                field(BuyerName; Rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer Name';
                }
                field(ContractNo; ContractNoLC)
                {
                    ApplicationArea = All;
                    Caption = 'Contract No';
                }
                field(MainCatName; MainCatName)
                {
                    ApplicationArea = all;
                    Caption = 'Main Category Name';
                }
                field(UOM; UOM)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field(Value; Value)
                {
                    ApplicationArea = all;
                }

            }
        }
    }


    trigger OnOpenPage()
    var


        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
        UserRec: Record "User Setup";
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
        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Merchandizer Group Name" <> '' then
            rec.SetFilter("Merchandizer Group Name", '=%1', UserRec."Merchandizer Group Name");
    end;


    trigger OnAfterGetRecord()
    var
        ItemLedgRec: Record "Item Ledger Entry";
        ItemRec: Record Item;
        GRNRec: Record "Purch. Rcpt. Line";
        styleRec: Record "Style Master";
        LcRec: Record "Contract/LCMaster";

    begin
        // styleRec.Reset();
        // styleRec.SetRange("Merchandizer Group Name", rec."Merchandizer Group Name");
        // styleRec.SetRange(ContractNo, Rec.ContractNo);
        // styleRec.SetRange("Buyer No.", Rec."Buyer No.");
        // if styleRec.FindSet() then begin

        // end;
        // styleRec.Reset();
        // styleRec.SetRange("No.", Rec."No.");
        // styleRec.SetRange(AssignedContractNo, Rec.AssignedContractNo);
        // styleRec.SetRange("Factory Code", Rec."Factory Code");
        // styleRec.SetRange("Buyer No.", Rec."Buyer No.");
        // if styleRec.FindFirst() then begin
        //     repeat
        //         Rec."Factory Name" := styleRec."Factory Name";
        //         rec."Buyer Name" := styleRec."Buyer Name";
        //         Rec.AssignedContractNo := styleRec.AssignedContractNo;
        //     until styleRec.Next() = 0;
        // end;


        LcRec.Reset();
        LcRec.SetRange("No.", Rec.AssignedContractNo);
        if LcRec.FindSet() then begin
            ContractNoLC := LcRec."Contract No";
        end;

        GRNRec.Reset();
        GRNRec.SetRange(StyleNo, Rec."No.");
        if GRNRec.FindSet() then begin

            ItemLedgRec.Reset();
            ItemLedgRec.SetRange("Document No.", GRNRec."Document No.");
            if ItemLedgRec.FindSet() then begin
                Value := ItemLedgRec.Quantity * 3.2;
                Quantity := ItemLedgRec.Quantity;

                ItemRec.Reset();
                ItemRec.SetRange("No.", ItemLedgRec."Item No.");
                if ItemRec.FindSet() then begin
                    UOM := ItemRec."Base Unit of Measure";
                    MainCatName := ItemRec."Main Category Name";
                end;
            end;

        end;
    end;



    var
        ContractNoLC: Text[50];
        MainCatName: Text[50];
        Quantity: Decimal;
        Value: Decimal;
        UOM: Code[20];
        // Merchandizer: Text[200];
        FactoryName: Text[200];
        BuyerName: Text[200];
    // ContractNo: Text[50];
}