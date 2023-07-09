page 51358 "Order Shipping Export"
{
    PageType = Card;
    SourceTable = "Order Shipping Export Header";


    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                }
                field(Buyer; Rec."Buyer Name")
                {
                    ApplicationArea = All;
                }
                field("Contract Lc No"; Rec."Contract No")
                {
                    ApplicationArea = All;

                }

            }
            // group("Details")
            // {
            //     part(orderShipping; OrderShipping)
            //     {
            //         Caption = ' ';
            //         ApplicationArea = All;
            //         SubPageLink = No = field("No.");
            //     }
            // }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Load Details")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    BankRefColRec: Record BankRefCollectionHeader;
                    BankRefHRec: Record BankReferenceHeader;
                    SalesInvRec: Record "Sales Invoice Header";
                    BomEstimateRec: Record "BOM Estimate Cost";
                    LcRec: Record "Contract/LCMaster";
                    StyleRec: Record "Style Master";
                    OrderSummaryRec: Record "Order Shipping Export Line";
                    StylePoRec: Record "Style Master PO";
                    ContractStyleRec: Record "Contract/LCStyle";
                    LoginRec: Page "Login Card";
                    LoginSessionsRec: Record LoginSessions;
                    UserRec: Record "User Setup";
                    MaxSeqNo: BigInteger;
                begin
                    //Check whether user logged in or not
                    LoginSessionsRec.Reset();
                    LoginSessionsRec.SetRange(SessionID, SessionId());

                    if not LoginSessionsRec.FindSet() then begin  //not logged in
                        Clear(LoginRec);
                        LoginRec.LookupMode(true);
                        LoginRec.RunModal();
                    end;

                    // MaxSeqNo := 0;

                    // Delete Old Records
                    // OrderSummaryRec.Reset();
                    // // OrderSummaryRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
                    // OrderSummaryRec.SetRange(No, Rec."No.");
                    // if OrderSummaryRec.FindSet() then begin
                    //     OrderSummaryRec.DeleteAll();
                    //     CurrPage.Update();
                    // end;

                    //Get Max Seq No
                    OrderSummaryRec.Reset();
                    if OrderSummaryRec.FindLast() then
                        MaxSeqNo := OrderSummaryRec."SeqNo";

                    StyleRec.Reset();
                    StyleRec.SetRange("Style No.", Rec."Style Name");
                    StyleRec.SetRange(Status, StyleRec.Status::Confirmed);
                    if StyleRec.FindSet() then begin
                        StylePoRec.Reset();
                        StylePoRec.SetRange("Style No.", Rec.StyleNO);
                        if StylePoRec.FindSet() then begin
                            repeat
                                repeat
                                    MaxSeqNo += 1;
                                    OrderSummaryRec.Init();
                                    OrderSummaryRec.SeqNo := MaxSeqNo;
                                    OrderSummaryRec.No := Rec."No.";

                                    LcRec.Reset();
                                    LcRec.SetRange("No.", rec."Contract No");
                                    if LcRec.FindSet() then begin
                                        OrderSummaryRec."Contract Lc No" := LcRec."Contract No";
                                        OrderSummaryRec.Season := StyleRec."Season Name";
                                        OrderSummaryRec."Buyer No" := StyleRec."Brand No.";
                                        OrderSummaryRec.Buyer := StyleRec."Buyer Name";
                                        OrderSummaryRec."Style Name" := StyleRec."Style No.";
                                        OrderSummaryRec."Po No" := StylePoRec."PO No.";
                                        OrderSummaryRec."Po Qty" := StylePoRec.Qty;
                                        OrderSummaryRec."Unit Price" := StylePoRec."Unit Price";
                                        OrderSummaryRec."Ship Date" := StylePoRec."Ship Date";
                                        OrderSummaryRec."Ship Qty" := StylePoRec."Shipped Qty";
                                        OrderSummaryRec.Mode := StylePoRec.Mode;

                                        BomEstimateRec.Reset();
                                        BomEstimateRec.SetRange("Style No.", StyleRec."No.");
                                        if BomEstimateRec.FindSet() then begin
                                            OrderSummaryRec.Commission := BomEstimateRec."Commission %";
                                        end;

                                        SalesInvRec.Reset();
                                        SalesInvRec.SetRange("Style Name", Rec."Style Name");
                                        SalesInvRec.SetRange("Sell-to Customer No.", Rec.Buyer);
                                        if SalesInvRec.FindSet() then begin
                                            OrderSummaryRec."Invoice No" := SalesInvRec."Your Reference";
                                            OrderSummaryRec."Invoice Date" := SalesInvRec."Shipment Date";
                                            OrderSummaryRec."No of CTN" := SalesInvRec."No of Cartons";
                                            OrderSummaryRec.CBM := SalesInvRec.CBM;
                                            OrderSummaryRec."BL No" := SalesInvRec."BL No";
                                            OrderSummaryRec."BL Date" := SalesInvRec."BL Date";
                                            OrderSummaryRec."Exp No" := SalesInvRec."Exp No";
                                            OrderSummaryRec."Exp Date" := SalesInvRec."Exp Date";
                                            OrderSummaryRec.Destination := SalesInvRec."Location Code";

                                            BankRefHRec.Reset();
                                            BankRefHRec.SetRange("Buyer No", Rec.Buyer);
                                            BankRefHRec.SetRange("LC/Contract No.", Rec."Contract Lc/No");
                                            // BankRefHRec.SetRange("No.", SalesInvRec.BankRefNo);
                                            if BankRefHRec.FindSet() then begin
                                                OrderSummaryRec."Doc Sub Bank Date" := BankRefHRec."Reference Date";
                                                OrderSummaryRec."Doc Sub Buyer Date" := BankRefHRec."Reference Date";
                                                OrderSummaryRec."Bank Ref" := BankRefHRec."No.";
                                                OrderSummaryRec."Bank Ref Date" := BankRefHRec."Reference Date";
                                                OrderSummaryRec."Maturity Date" := BankRefHRec."Maturity Date";
                                                OrderSummaryRec.Remarks := BankRefHRec.Remarks;

                                                BankRefColRec.Reset();
                                                BankRefColRec.SetRange("BankRefNo.", BankRefHRec."BankRefNo.");
                                                if BankRefColRec.FindSet() then begin
                                                    OrderSummaryRec."Realise Amount" := BankRefColRec."Release Amount";
                                                    OrderSummaryRec."Realise Date" := BankRefColRec."Release Date";
                                                    OrderSummaryRec."Exchange Rate" := BankRefColRec."Exchange Rate";
                                                    OrderSummaryRec."Margin Acc" := BankRefColRec."Margin A/C Amount";
                                                    OrderSummaryRec."FC Acc" := BankRefColRec."FC A/C Amount";
                                                    OrderSummaryRec."Currant Ac Amount" := BankRefColRec."Current A/C Amount";
                                                end;
                                            end;
                                        end;
                                    end;
                                    OrderSummaryRec.Insert();
                                until StylePoRec.Next() = 0;
                            until StyleRec.Next() = 0;
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
        end;

        // if not rec.get() then begin
        //     rec.INIT();
        //     rec.INSERT();
        // end;



    end;

    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."OrderShippingExport Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        OrderShipingRec: Record "Order Shipping Export Line";
    begin
        OrderShipingRec.Reset();
        if OrderShipingRec.FindSet() then begin
            OrderShipingRec.DeleteAll();
        end;
        // Error('Cannot delete this record.');
    end;


}