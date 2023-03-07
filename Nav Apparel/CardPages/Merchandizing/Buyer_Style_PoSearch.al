page 51247 "Buyer Style PO Search"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Editable = true;
    SourceTable = BuyerStylePOSearchHeader;
    Caption = 'Buyer/Style/Vendor PO Details';

    layout
    {
        area(Content)
        {
            group(Genaral)
            {
                field("Buyer Name"; Rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = all;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                    begin
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", Rec."Style Name");

                        if not StyleMasterRec.FindSet() then
                            Error('Invalid Style');
                    end;
                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Caption = 'Invoiced';

                    trigger OnValidate()
                    var
                    begin
                        if Rec.Posted = true then begin
                            VisiblePO := false;
                            VisibleGRN := true;
                        end
                        else begin
                            VisiblePO := true;
                            VisibleGRN := false;
                        end;
                    end;
                }
            }

            group("PO Details")
            {
                part("Buyer Style PO Search Listpart1"; "BuyerStyle PO Search Listpart1")
                {
                    Caption = ' ';
                    Visible = VisiblePO;
                    ApplicationArea = All;
                }
            }

            group("PO Details (Invoiced)")
            {
                part("Buyer Style PO Search Listpart2"; "BuyerStyle PO Search Listpart2")
                {
                    Caption = ' ';
                    Visible = VisibleGRN;
                    ApplicationArea = All;
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action("Load PO")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    PurchaseHeaderArchivedRec: Record "Purchase Header Archive";
                    purchaseLineArchivedRec: record "Purchase Line Archive";
                    PurchaseHeaderRec: Record "Purchase Header";
                    purchaseLineRec: record "Purchase Line";
                    BuyerStylePoSearchRec: Record "Buyer Style PO Search New";
                    BuyerStyleGRNSearchRec: Record "Buyer Style PO Search GRN";
                    LoginSessionsRec: Record LoginSessions;
                    LoginRec: Page "Login Card";
                begin

                    //Check whether user logged in or not
                    LoginSessionsRec.Reset();
                    LoginSessionsRec.SetRange(SessionID, SessionId());

                    if not LoginSessionsRec.FindSet() then begin  //not logged in
                        Clear(LoginRec);
                        LoginRec.LookupMode(true);
                        LoginRec.RunModal();

                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());
                        LoginSessionsRec.FindSet()
                    end;

                    if Rec."Buyer Code" = '' then
                        Error('Select Buyer');

                    MaxSeqNo := 0;

                    // Delete old records
                    BuyerStylePoSearchRec.Reset();
                    BuyerStylePoSearchRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
                    if BuyerStylePoSearchRec.findset then
                        BuyerStylePoSearchRec.DeleteAll();

                    // Delete old records
                    BuyerStyleGRNSearchRec.Reset();
                    BuyerStyleGRNSearchRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
                    if BuyerStyleGRNSearchRec.findset then
                        BuyerStyleGRNSearchRec.DeleteAll();


                    //Buyer Only
                    if Rec."Style Name" = '' then begin

                        // Not Posted
                        if Rec.Posted = false then begin

                            //Get Max Seq No
                            BuyerStylePoSearchRec.Reset();
                            if BuyerStylePoSearchRec.FindLast() then
                                MaxSeqNo := BuyerStylePoSearchRec."Seq No";

                            purchaseLineRec.Reset();
                            purchaseLineRec.SetRange("Buyer No.", Rec."Buyer Code");

                            if purchaseLineRec.FindSet() then begin
                                repeat

                                    BuyerStylePoSearchRec.Reset();
                                    BuyerStylePoSearchRec.SetRange("PO No", purchaseLineRec."Document No.");

                                    if not BuyerStylePoSearchRec.FindSet() then begin

                                        MaxSeqNo += 1;
                                        BuyerStylePoSearchRec.Init();
                                        BuyerStylePoSearchRec."Seq No" := MaxSeqNo;
                                        BuyerStylePoSearchRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                                        BuyerStylePoSearchRec."PO No" := purchaseLineRec."Document No.";

                                        PurchaseHeaderRec.Reset();
                                        PurchaseHeaderRec.SetRange("No.", purchaseLineRec."Document No.");
                                        PurchaseHeaderRec.SetRange("Document Type", purchaseLineRec."Document Type"::Order);
                                        if PurchaseHeaderRec.FindSet() then begin
                                            PurchaseHeaderRec.CalcFields(Amount);
                                            PurchaseHeaderRec.CalcFields("Amount Including VAT");
                                            BuyerStylePoSearchRec.Supplier := PurchaseHeaderRec."Buy-from Vendor Name";
                                            BuyerStylePoSearchRec.Date := PurchaseHeaderRec."Document Date";
                                            BuyerStylePoSearchRec.Location := PurchaseHeaderRec."Location Code";
                                            BuyerStylePoSearchRec.Status := PurchaseHeaderRec.Status;
                                            BuyerStylePoSearchRec.Amount := PurchaseHeaderRec.Amount;
                                            BuyerStylePoSearchRec."Amount Including VAT" := PurchaseHeaderRec."Amount Including VAT";
                                        end;
                                        BuyerStylePoSearchRec.Insert();
                                    end;

                                until purchaseLineRec.Next() = 0;
                            end
                            else
                                Error('No PO found');
                        end
                        else begin
                            //Posted PO                           

                            //Get Max Seq No
                            BuyerStyleGRNSearchRec.Reset();
                            if BuyerStyleGRNSearchRec.FindLast() then
                                MaxSeqNo := BuyerStyleGRNSearchRec."Seq No";

                            purchaseLineArchivedRec.Reset();
                            purchaseLineArchivedRec.SetRange("Buyer No.", Rec."Buyer Code");

                            if purchaseLineArchivedRec.FindSet() then begin
                                repeat

                                    BuyerStyleGRNSearchRec.Reset();
                                    BuyerStyleGRNSearchRec.SetRange("GRN No", purchaseLineArchivedRec."Document No.");

                                    if not BuyerStyleGRNSearchRec.FindSet() then begin
                                        MaxSeqNo += 1;
                                        BuyerStyleGRNSearchRec.Init();
                                        BuyerStyleGRNSearchRec."Seq No" := MaxSeqNo;
                                        BuyerStyleGRNSearchRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                                        BuyerStyleGRNSearchRec."GRN No" := purchaseLineArchivedRec."Document No.";

                                        PurchaseHeaderArchivedRec.Reset();
                                        PurchaseHeaderArchivedRec.SetRange("No.", purchaseLineArchivedRec."Document No.");

                                        if PurchaseHeaderArchivedRec.FindSet() then begin
                                            BuyerStyleGRNSearchRec.Supplier := PurchaseHeaderArchivedRec."Buy-from Vendor Name";
                                            BuyerStyleGRNSearchRec.Date := PurchaseHeaderArchivedRec."Posting Date";
                                            BuyerStyleGRNSearchRec.Location := PurchaseHeaderArchivedRec."Location Code";
                                            PurchaseHeaderArchivedRec.CalcFields(Amount);
                                            PurchaseHeaderArchivedRec.CalcFields("Amount Including VAT");
                                            BuyerStyleGRNSearchRec.Amount := PurchaseHeaderArchivedRec.Amount;
                                            BuyerStyleGRNSearchRec."Amount Including VAT" := PurchaseHeaderArchivedRec."Amount Including VAT";
                                        end;
                                        BuyerStyleGRNSearchRec.Insert();
                                    end;
                                until purchaseLineArchivedRec.Next() = 0;
                            end
                            else
                                Error('No PO found');
                        end;
                    end
                    else begin   //Select Buyer And Style

                        // Not Posted
                        if Rec.Posted = false then begin

                            //Get Max Seq No
                            BuyerStylePoSearchRec.Reset();
                            if BuyerStylePoSearchRec.FindLast() then
                                MaxSeqNo := BuyerStylePoSearchRec."Seq No";

                            purchaseLineRec.Reset();
                            purchaseLineRec.SetRange(StyleName, Rec."Style Name");
                            purchaseLineRec.SetRange("Buyer No.", Rec."Buyer Code");

                            if purchaseLineRec.FindSet() then begin
                                repeat

                                    BuyerStylePoSearchRec.Reset();
                                    BuyerStylePoSearchRec.SetRange("PO No", purchaseLineRec."Document No.");

                                    if not BuyerStylePoSearchRec.FindSet() then begin
                                        MaxSeqNo += 1;
                                        BuyerStylePoSearchRec.Init();
                                        BuyerStylePoSearchRec."Seq No" := MaxSeqNo;
                                        BuyerStylePoSearchRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                                        BuyerStylePoSearchRec."PO No" := purchaseLineRec."Document No.";

                                        PurchaseHeaderRec.Reset();
                                        PurchaseHeaderRec.SetRange("No.", purchaseLineRec."Document No.");
                                        PurchaseHeaderRec.SetRange("Document Type", purchaseLineRec."Document Type"::Order);

                                        if PurchaseHeaderRec.FindSet() then begin
                                            PurchaseHeaderRec.CalcFields(Amount);
                                            PurchaseHeaderRec.CalcFields("Amount Including VAT");
                                            BuyerStylePoSearchRec.Supplier := PurchaseHeaderRec."Buy-from Vendor Name";
                                            BuyerStylePoSearchRec.Date := PurchaseHeaderRec."Document Date";
                                            BuyerStylePoSearchRec.Status := PurchaseHeaderRec.Status;
                                            BuyerStylePoSearchRec.Location := PurchaseHeaderRec."Location Code";
                                            BuyerStylePoSearchRec.Amount := PurchaseHeaderRec.Amount;
                                            BuyerStylePoSearchRec."Amount Including VAT" := PurchaseHeaderRec."Amount Including VAT";
                                        end;
                                        BuyerStylePoSearchRec.Insert();
                                    end;
                                until purchaseLineRec.Next() = 0;
                            end
                            else
                                Error('No PO found');
                        end

                        //Posted PO
                        else begin

                            // VisiblePO := false;
                            // VisibleGRN := true;

                            //Get Max Seq No
                            BuyerStyleGRNSearchRec.Reset();
                            if BuyerStyleGRNSearchRec.FindLast() then
                                MaxSeqNo := BuyerStyleGRNSearchRec."Seq No";

                            purchaseLineArchivedRec.Reset();
                            purchaseLineArchivedRec.SetRange("Buyer No.", Rec."Buyer Code");
                            purchaseLineArchivedRec.SetRange(StyleName, Rec."Style Name");
                            if purchaseLineArchivedRec.FindSet() then begin
                                repeat

                                    BuyerStyleGRNSearchRec.Reset();
                                    BuyerStyleGRNSearchRec.SetRange("GRN No", purchaseLineArchivedRec."Document No.");

                                    if not BuyerStyleGRNSearchRec.FindSet() then begin
                                        MaxSeqNo += 1;
                                        BuyerStyleGRNSearchRec.Init();
                                        BuyerStyleGRNSearchRec."Seq No" := MaxSeqNo;
                                        BuyerStyleGRNSearchRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                                        BuyerStyleGRNSearchRec."GRN No" := purchaseLineArchivedRec."Document No.";

                                        PurchaseHeaderArchivedRec.Reset();
                                        PurchaseHeaderArchivedRec.SetRange("No.", purchaseLineArchivedRec."Document No.");

                                        if PurchaseHeaderArchivedRec.FindSet() then begin
                                            BuyerStyleGRNSearchRec.Supplier := PurchaseHeaderArchivedRec."Buy-from Vendor Name";
                                            BuyerStyleGRNSearchRec.Date := PurchaseHeaderArchivedRec."Posting Date";
                                            BuyerStyleGRNSearchRec.Location := PurchaseHeaderArchivedRec."Location Code";
                                            PurchaseHeaderArchivedRec.CalcFields(Amount);
                                            PurchaseHeaderArchivedRec.CalcFields("Amount Including VAT");
                                            BuyerStyleGRNSearchRec.Amount := PurchaseHeaderArchivedRec.Amount;
                                            BuyerStyleGRNSearchRec."Amount Including VAT" := PurchaseHeaderArchivedRec."Amount Including VAT";
                                        end;
                                        BuyerStyleGRNSearchRec.Insert();
                                    end;
                                until purchaseLineArchivedRec.Next() = 0;
                            end
                            else
                                Error('No PO found');
                        end;
                    end;
                end;
            }
        }
    }


    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
        UsersetupRec: Record "User Setup";
        BuyerStylePOSearchHeaderRec: Record BuyerStylePOSearchHeader;
    begin
        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();
        end;

        // if not rec.get() then begin
        //     rec.INIT();
        //     rec.INSERT();
        // end;

        VisiblePO := true;
        VisibleGRN := false;

        BuyerStylePOSearchHeaderRec.Get(Rec."No.");
        BuyerStylePOSearchHeaderRec.Posted := false;

    end;


    trigger OnDeleteRecord(): Boolean
    var

    begin
        Error('Cannot delete this record.');
    end;


    var

        MaxSeqNo: BigInteger;
        VisiblePO: Boolean;
        VisibleGRN: Boolean;
}
