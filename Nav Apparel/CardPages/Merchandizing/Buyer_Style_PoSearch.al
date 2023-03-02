page 51247 "Buyer Style PO Search"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Editable = true;
    SourceTable = BuyerStylePOSearchHeader;



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

                    // TableRelation = Customer."No.";

                    // trigger OnLookup(var text: Text): Boolean
                    // var
                    //     CutomerRec: Record Customer;
                    //     UserSetupRec: Record "User Setup";
                    // begin

                    //     UserSetupRec.Get(UserId);

                    //     if UserSetupRec."Merchandizer All Group" = true then begin
                    //         if Page.RunModal(22, CutomerRec) = Action::LookupOK then
                    //             Buyer := CutomerRec."No.";
                    //     end
                    //     else begin
                    //         if UserSetupRec."Merchandizer Group Name" <> '' then begin
                    //             CutomerRec.Reset();
                    //             CutomerRec.SetRange("Group Name", UserSetupRec."Merchandizer Group Name");
                    //             if CutomerRec.FindSet() then begin
                    //                 if Page.RunModal(22, CutomerRec) = Action::LookupOK then begin
                    //                     Buyer := CutomerRec."No.";
                    //                 end;
                    //             end;
                    //         end
                    //         else begin
                    //             if Page.RunModal(22, CutomerRec) = Action::LookupOK then begin
                    //                 Buyer := CutomerRec."No.";
                    //             end;
                    //         end;
                    //     end;
                    // end;
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

                        if StyleMasterRec.FindSet() then
                            Rec."Style No" := StyleMasterRec."No."
                        else
                            Error('Invalid Style');
                    end;
                    // TableRelation = "Style Master"."No.";

                    // trigger OnLookup(var Text: Text): Boolean
                    // var
                    //     CutomerRec: Record Customer;
                    //     StyleMasterRec: Record "Style Master";
                    // begin
                    //     StyleMasterRec.Reset();
                    //     StyleMasterRec.SetRange("Buyer No.", Rec."Buyer Code");

                    //     if StyleMasterRec.FindSet() then begin
                    //         if Page.RunModal(51067, StyleMasterRec) = Action::LookupOK then
                    //             Style := StyleMasterRec."No.";
                    //     end;
                    // end;
                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;

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

            group(" ")
            {
                part("Buyer Style PO Search Listpart1"; "BuyerStyle PO Search Listpart1")
                {
                    Caption = ' ';
                    Visible = VisiblePO;
                    ApplicationArea = All;
                }

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
            action("Load PO/GRN")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    PurchaseRcptHeaderRec: Record "Purch. Rcpt. Header";
                    PurchaseRcptLineRec: record "Purch. Rcpt. Line";
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
                    if Rec."Style No" = '' then begin

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
                                            BuyerStylePoSearchRec.Amount := purchaseLineRec.Amount;
                                            BuyerStylePoSearchRec."Amount Including VAT" := purchaseLineRec."Amount Including VAT";
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

                            PurchaseRcptLineRec.Reset();
                            PurchaseRcptLineRec.SetRange("Buyer No.", Rec."Buyer Code");

                            if PurchaseRcptLineRec.FindSet() then begin
                                repeat

                                    BuyerStyleGRNSearchRec.Reset();
                                    BuyerStyleGRNSearchRec.SetRange("GRN No", PurchaseRcptLineRec."Document No.");

                                    if not BuyerStyleGRNSearchRec.FindSet() then begin
                                        MaxSeqNo += 1;
                                        BuyerStyleGRNSearchRec.Init();
                                        BuyerStyleGRNSearchRec."Seq No" := MaxSeqNo;
                                        BuyerStyleGRNSearchRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                                        BuyerStyleGRNSearchRec."GRN No" := PurchaseRcptLineRec."Document No.";

                                        PurchaseRcptHeaderRec.Reset();
                                        PurchaseRcptHeaderRec.SetRange("No.", PurchaseRcptLineRec."Document No.");

                                        if PurchaseRcptHeaderRec.FindSet() then begin
                                            BuyerStyleGRNSearchRec.Supplier := PurchaseRcptHeaderRec."Buy-from Vendor Name";
                                            BuyerStyleGRNSearchRec.Date := PurchaseRcptHeaderRec."Posting Date";
                                            BuyerStyleGRNSearchRec.Location := PurchaseRcptHeaderRec."Location Code";
                                            BuyerStyleGRNSearchRec.Amount := 0;
                                            BuyerStyleGRNSearchRec."Amount Including VAT" := 0;
                                        end;
                                        BuyerStyleGRNSearchRec.Insert();
                                    end;
                                until PurchaseRcptLineRec.Next() = 0;
                            end
                            else
                                Error('No GRN found');
                        end;
                    end

                    //Select Buyer And Style
                    else begin

                        // Not Posted
                        if Rec.Posted = false then begin

                            // VisiblePO := true;
                            // VisibleGRN := false;

                            //Get Max Seq No
                            BuyerStylePoSearchRec.Reset();
                            if BuyerStylePoSearchRec.FindLast() then
                                MaxSeqNo := BuyerStylePoSearchRec."Seq No";

                            purchaseLineRec.Reset();
                            purchaseLineRec.SetRange(StyleNo, Rec."Style No");
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

                            PurchaseRcptLineRec.Reset();
                            PurchaseRcptLineRec.SetRange("Buyer No.", Rec."Buyer Code");
                            PurchaseRcptLineRec.SetRange(StyleNo, Rec."Style No");

                            if PurchaseRcptLineRec.FindSet() then begin
                                repeat

                                    BuyerStyleGRNSearchRec.Reset();
                                    BuyerStyleGRNSearchRec.SetRange("GRN No", PurchaseRcptLineRec."Document No.");

                                    if not BuyerStyleGRNSearchRec.FindSet() then begin
                                        MaxSeqNo += 1;
                                        BuyerStyleGRNSearchRec.Init();
                                        BuyerStyleGRNSearchRec."Seq No" := MaxSeqNo;
                                        BuyerStyleGRNSearchRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                                        BuyerStyleGRNSearchRec."GRN No" := PurchaseRcptLineRec."Document No.";

                                        PurchaseRcptHeaderRec.Reset();
                                        PurchaseRcptHeaderRec.SetRange("No.", PurchaseRcptLineRec."Document No.");

                                        if PurchaseRcptHeaderRec.FindSet() then begin
                                            BuyerStyleGRNSearchRec.Supplier := PurchaseRcptHeaderRec."Buy-from Vendor Name";
                                            BuyerStyleGRNSearchRec.Date := PurchaseRcptHeaderRec."Posting Date";
                                            BuyerStyleGRNSearchRec.Location := PurchaseRcptHeaderRec."Location Code";
                                            BuyerStyleGRNSearchRec.Amount := 0;
                                            BuyerStyleGRNSearchRec."Amount Including VAT" := 0;
                                        end;
                                        BuyerStyleGRNSearchRec.Insert();
                                    end;
                                until PurchaseRcptLineRec.Next() = 0;
                            end
                            else
                                Error('No GRN found');
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
