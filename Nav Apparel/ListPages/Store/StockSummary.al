page 50313 StockSummary
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = StockSummary;
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
                field(ContractNo; Rec."Contract Lc No")
                {
                    ApplicationArea = All;
                    Caption = 'Contract No';
                }
                field(MainCatName; Rec."Main Category Name")
                {
                    ApplicationArea = all;
                    Caption = 'Main Category Name';
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = all;
                }

            }
        }
    }


    trigger OnOpenPage()
    var
        StockSumRec2: Record StockSummary;
        StockSumRec: Record StockSummary;
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
        UserRec: Record "User Setup";
        styleRec: Record "Style Master";
        LcRec: Record "Contract/LCMaster";
        GRNRec: Record "Purch. Rcpt. Line";
        ItemLedgRec: Record "Item Ledger Entry";
        ItemRec: Record Item;
    begin
        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();
        end;


        // Delete Old Records
        StockSumRec.Reset();
        StockSumRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
        if StockSumRec.FindSet() then
            StockSumRec.DeleteAll();

        //Get Max Seq No
        StockSumRec.Reset();
        if StockSumRec.FindLast() then
            MaxSeqNo := StockSumRec."SeqNo";

        styleRec.Reset();
        styleRec.SetRange(Status, styleRec.Status::Confirmed);
        if styleRec.FindSet() then begin
            repeat
                MaxSeqNo += 1;
                StockSumRec.Init();
                StockSumRec.SeqNo := MaxSeqNo;
                StockSumRec."Style No" := styleRec."No.";
                StockSumRec."Style Name" := styleRec."Style No.";
                StockSumRec."Buyer Name" := styleRec."Buyer Name";
                StockSumRec."Factory Name" := styleRec."Factory Name";

                LcRec.Reset();
                LcRec.SetRange("No.", styleRec.AssignedContractNo);
                if LcRec.FindSet() then
                    StockSumRec."Contract Lc No" := LcRec."Contract No";


                GRNRec.Reset();
                GRNRec.SetRange(StyleNo, styleRec."No.");
                if GRNRec.FindSet() then begin
                    ItemLedgRec.Reset();
                    ItemLedgRec.SetRange("Document No.", GRNRec."Document No.");
                    if ItemLedgRec.FindSet() then begin
                        StockSumRec.Value := ItemLedgRec.Quantity * 3.2;
                        StockSumRec.Quantity := ItemLedgRec.Quantity;
                    end;

                    ItemRec.Reset();
                    ItemRec.SetRange("No.", ItemLedgRec."Item No.");
                    if ItemRec.FindSet() then begin
                        StockSumRec.UOM := ItemRec."Base Unit of Measure";
                        StockSumRec."Main Category Name" := ItemRec."Main Category Name";
                    end;

                end;
                StockSumRec.Insert();
            until styleRec.Next() = 0;
        end;


    end;




    var
        MaxSeqNo: BigInteger;
        ContractNoLC: Text[50];
        MainCatName: Text[50];
        Quantity: Decimal;
        Value: Decimal;
        UOM: Code[20];
        FactoryName: Text[200];
        BuyerName: Text[200];
    
}