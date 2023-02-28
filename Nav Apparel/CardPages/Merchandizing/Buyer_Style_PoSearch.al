page 51247 "Buyer Style PO Search"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(Genaral)
            {
                field(Buyer; Buyer)
                {
                    ApplicationArea = All;
                    TableRelation = Customer."No.";

                    trigger OnLookup(var text: Text): Boolean
                    var
                        CutomerRec: Record Customer;
                        UserSetupRec: Record "User Setup";
                    begin

                        // UserSetupRec.Reset();
                        // UserSetupRec.SetRange("User ID", UserId);
                        UserSetupRec.Get(UserId);

                        if UserSetupRec."Merchandizer All Group" = true then begin
                            if Page.RunModal(22, CutomerRec) = Action::LookupOK then
                                Buyer := CutomerRec."No.";
                        end
                        else begin
                            if UserSetupRec."Merchandizer Group Name" <> '' then begin
                                CutomerRec.Reset();
                                CutomerRec.SetRange("Group Name", UserSetupRec."Merchandizer Group Name");
                                if CutomerRec.FindSet() then begin
                                    if Page.RunModal(22, CutomerRec) = Action::LookupOK then begin
                                        Buyer := CutomerRec."No.";
                                    end;
                                end;
                            end
                            else begin
                                if Page.RunModal(22, CutomerRec) = Action::LookupOK then begin
                                    Buyer := CutomerRec."No.";
                                end;
                            end;
                        end;

                    end;
                }

                field(Style; Style)
                {
                    ApplicationArea = all;
                    TableRelation = "Style Master"."No.";

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CutomerRec: Record Customer;
                        StyleMasterRec: Record "Style Master";
                    begin

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Buyer No.", Buyer);

                        if StyleMasterRec.FindSet() then begin
                            if Page.RunModal(51067, StyleMasterRec) = Action::LookupOK then
                                Style := StyleMasterRec."No.";
                        end;

                    end;
                }

                field(Posted; Posted)
                {
                    ApplicationArea = All;
                }
            }

            group(" ")
            {
                part("Buyer Style PO Search Listpart"; "Buyer Style PO Search Listpart")
                {
                    Caption = ' ';
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
                    PurchaseRcptHeaderRec: Record "Purch. Rcpt. Header";
                    PurchaseRcptLineRec: record "Purch. Rcpt. Line";
                    PurchaseHeaderRec: Record "Purchase Header";
                    purchaseLineRec: record "Purchase Line";
                    BuyerStylePoSearchRec: Record "Buyer Style PO Search New";
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

                        // LoginSessionsRec.Reset();
                        // LoginSessionsRec.SetRange(SessionID, SessionId());
                        // if LoginSessionsRec.FindSet() then
                        //     "Secondary UserID" := LoginSessionsRec."Secondary UserID";
                    end;
                    // else begin   //logged in
                    //     "Secondary UserID" := LoginSessionsRec."Secondary UserID";
                    // end;

                    if Buyer = '' then
                        Error('Select Buyer');

                    MaxSeqNo := 0;

                    // delete old records
                    BuyerStylePoSearchRec.Reset();
                    BuyerStylePoSearchRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
                    if BuyerStylePoSearchRec.findset then
                        BuyerStylePoSearchRec.DeleteAll();


                    //Select Buyer Only
                    if Style = '' then begin

                        // Not Posted
                        if Posted = false then begin

                            //Get Max Seq No
                            BuyerStylePoSearchRec.Reset();
                            if BuyerStylePoSearchRec.FindLast() then
                                MaxSeqNo := BuyerStylePoSearchRec."Seq No";

                            purchaseLineRec.Reset();
                            purchaseLineRec.SetRange("Buyer No.", Buyer);

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
                                            BuyerStylePoSearchRec.Supplier := PurchaseHeaderRec."Buy-from Vendor Name";
                                            BuyerStylePoSearchRec.Date := PurchaseHeaderRec."Document Date";
                                            BuyerStylePoSearchRec.Location := PurchaseHeaderRec."Location Code";
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
                        //Posted PO
                        else begin

                            //Get Max Seq No
                            BuyerStylePoSearchRec.Reset();
                            if BuyerStylePoSearchRec.FindLast() then
                                MaxSeqNo := BuyerStylePoSearchRec."Seq No";

                            PurchaseRcptLineRec.Reset();
                            PurchaseRcptLineRec.SetRange("Buyer No.", Buyer);

                            if PurchaseRcptLineRec.FindSet() then begin
                                repeat

                                    BuyerStylePoSearchRec.Reset();
                                    BuyerStylePoSearchRec.SetRange("PO No", PurchaseRcptLineRec."Order No.");

                                    if not BuyerStylePoSearchRec.FindSet() then begin
                                        MaxSeqNo += 1;
                                        BuyerStylePoSearchRec.Init();
                                        BuyerStylePoSearchRec."Seq No" := MaxSeqNo;
                                        BuyerStylePoSearchRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                                        BuyerStylePoSearchRec."PO No" := PurchaseRcptLineRec."Order No.";

                                        PurchaseRcptHeaderRec.Reset();
                                        PurchaseRcptHeaderRec.SetRange("Order No.", PurchaseRcptLineRec."Order No.");

                                        if PurchaseRcptHeaderRec.FindSet() then begin
                                            BuyerStylePoSearchRec.Supplier := PurchaseRcptHeaderRec."Buy-from Vendor Name";
                                            BuyerStylePoSearchRec.Date := PurchaseRcptHeaderRec."Posting Date";
                                            BuyerStylePoSearchRec.Location := PurchaseRcptHeaderRec."Location Code";
                                            BuyerStylePoSearchRec.Amount := 0;
                                            BuyerStylePoSearchRec."Amount Including VAT" := 0;
                                        end;
                                        BuyerStylePoSearchRec.Insert();
                                    end;
                                until PurchaseRcptLineRec.Next() = 0;
                            end
                            else
                                Error('No PO found');
                        end;
                    end

                    //Select Buyer And Style
                    else begin

                        // Not Posted
                        if Posted = false then begin

                            //Get Max Seq No
                            BuyerStylePoSearchRec.Reset();
                            if BuyerStylePoSearchRec.FindLast() then
                                MaxSeqNo := BuyerStylePoSearchRec."Seq No";

                            purchaseLineRec.Reset();
                            purchaseLineRec.SetRange(StyleNo, Style);
                            purchaseLineRec.SetRange("Buyer No.", Buyer);

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
                                            BuyerStylePoSearchRec.Supplier := PurchaseHeaderRec."Buy-from Vendor Name";
                                            BuyerStylePoSearchRec.Date := PurchaseHeaderRec."Document Date";
                                            BuyerStylePoSearchRec.Location := PurchaseHeaderRec."Location Code";
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

                        //Posted PO
                        else begin

                            //Get Max Seq No
                            BuyerStylePoSearchRec.Reset();
                            if BuyerStylePoSearchRec.FindLast() then
                                MaxSeqNo := BuyerStylePoSearchRec."Seq No";

                            PurchaseRcptLineRec.Reset();
                            PurchaseRcptLineRec.SetRange("Buyer No.", Buyer);
                            PurchaseRcptLineRec.SetRange(StyleNo, Style);

                            if PurchaseRcptLineRec.FindSet() then begin
                                repeat

                                    BuyerStylePoSearchRec.Reset();
                                    BuyerStylePoSearchRec.SetRange("PO No", PurchaseRcptLineRec."Order No.");

                                    if not BuyerStylePoSearchRec.FindSet() then begin
                                        MaxSeqNo += 1;
                                        BuyerStylePoSearchRec.Init();
                                        BuyerStylePoSearchRec."Seq No" := MaxSeqNo;
                                        BuyerStylePoSearchRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                                        BuyerStylePoSearchRec."PO No" := PurchaseRcptLineRec."Order No.";

                                        PurchaseRcptHeaderRec.Reset();
                                        PurchaseRcptHeaderRec.SetRange("Order No.", PurchaseRcptLineRec."Order No.");

                                        if PurchaseRcptHeaderRec.FindSet() then begin
                                            BuyerStylePoSearchRec.Supplier := PurchaseRcptHeaderRec."Buy-from Vendor Name";
                                            BuyerStylePoSearchRec.Date := PurchaseRcptHeaderRec."Posting Date";
                                            BuyerStylePoSearchRec.Location := PurchaseRcptHeaderRec."Location Code";
                                            BuyerStylePoSearchRec.Amount := 0;
                                            BuyerStylePoSearchRec."Amount Including VAT" := 0;
                                        end;
                                        BuyerStylePoSearchRec.Insert();
                                    end;
                                until PurchaseRcptLineRec.Next() = 0;
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
            //     "Secondary UserID" := LoginSessionsRec."Secondary UserID";
        end;
        // else begin   //logged in
        //     "Secondary UserID" := LoginSessionsRec."Secondary UserID";
        // end;
    end;

    var
        Buyer: Code[20];
        Style: Text[50];
        Posted: Boolean;
        MaxSeqNo: BigInteger;


}