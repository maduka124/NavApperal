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
                        UsersetupRec: Record "User Setup";
                    begin

                        // UsersetupRec.Get(UserId);
                        UsersetupRec.Reset();
                        UsersetupRec.SetRange("User ID", UserID);
                        if UsersetupRec."Merchandizer Group Name" = '' then begin
                            if Page.RunModal(22, CutomerRec) = Action::LookupOK then
                                Buyer := CutomerRec."No.";
                        end

                        else
                            if Page.RunModal(22, CutomerRec) = Action::LookupOK then begin
                                Buyer := CutomerRec."No.";
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
                    PurchaseHeaderRec: Record "Purchase Header";
                    purchaseLineRec: record "Purchase Line";
                    BuyerStylePoSearchRec: Record "Buyer Style PO Search";
                begin

                    //delete old records
                    BuyerStylePoSearchRec.Reset();
                    BuyerStylePoSearchRec.SetRange("Secondary UserID", "Secondary UserID");

                    if BuyerStylePoSearchRec.findset then
                        BuyerStylePoSearchRec.DeleteAll();

                    if Buyer = '' then
                        Error('Select Buyer');

                    //Select Buyer Only
                    // Not Posted

                    if Style = '' then begin

                        purchaseLineRec.Reset();
                        purchaseLineRec.SetRange("Buyer No.", Buyer);

                        if PurchaseHeaderRec.FindSet() then begin
                            repeat

                                BuyerStylePoSearchRec.Init();
                                BuyerStylePoSearchRec."PO No" := purchaseLineRec."Document No.";
                                BuyerStylePoSearchRec.Insert();

                            until purchaseLineRec.Next() = 0;
                            BuyerStylePoSearchRec.Reset();

                            BuyerStylePoSearchRec.Init();
                            BuyerStylePoSearchRec."PO No" := purchaseLineRec."Document No.";
                            BuyerStylePoSearchRec.Insert();
                        end

                        else
                            Error('thre is no POs');



                    end
                    else
                        ;


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


        // //Check whether user logged in or not
        // LoginSessionsRec.Reset();
        // LoginSessionsRec.SetRange(SessionID, SessionId());

        // if not LoginSessionsRec.FindSet() then begin  //not logged in
        //     Clear(LoginRec);
        //     LoginRec.LookupMode(true);
        //     LoginRec.RunModal();

        //     LoginSessionsRec.Reset();
        //     LoginSessionsRec.SetRange(SessionID, SessionId());
        //     if LoginSessionsRec.FindSet() then
        //         "Secondary UserID" := LoginSessionsRec."Secondary UserID";
        // end
        // else begin   //logged in
        //     "Secondary UserID" := LoginSessionsRec."Secondary UserID";
        // end;
    end;

    var
        Buyer: Code[20];
        Style: Text[50];
        UserID: Code[50];
        Posted: Boolean;
        "Secondary UserID": Code[20];


}