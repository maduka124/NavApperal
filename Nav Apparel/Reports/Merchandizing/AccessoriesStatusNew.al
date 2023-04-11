report 51262 AccessoriesStatusReportNew
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Accessories Status Report New';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/Merchandizing/AccessoriesStatusReportNew.rdl';

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = sorting("No.");

            column(Style_No_; "Style No.")
            { }
            column(Garment_Type_Name; "Garment Type Name")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(Order_Qty; "Order Qty")
            { }
            column(CompLogo; comRec.Picture)
            { }

            dataitem("AccessoriesStatusReportNew"; "AccessoriesStatusReportNew")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = StyleNo = field("No.");
                DataItemTableView = sorting("Item Desc");

                column(Item_No; "Item No")
                { }
                column(PONo_; "PONo.")
                { }
                column(Item_Desc; "Item Desc")
                { }
                column(Size; Size)
                { }
                column(Color; Color)
                { }
                column(Article; Article)
                { }
                column(Dimension; Dimension)
                { }
                column(Unit; Unit)
                { }
                column(PO_Qty; "PO Qty")
                { }
                column(GRN_Qty; "GRN Qty")
                { }
                column(Balance; Balance)
                { }
                column(IssueQty; "Issue Qty")
                { }
                column(Stock_Balance; "Stock Balance")
                { }

                trigger OnPreDataItem()
                begin
                    SetRange(AccessoriesStatusReportNew."Secondary UserID", LoginSessionsRec."Secondary UserID");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()
            begin
                SetRange("No.", FilterNo);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'Filter By';
                    field(FilterNo; FilterNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Style';
                        Editable = not EditableGB;
                        TableRelation = "Style Master"."No.";
                    }
                }
            }
        }
    }


    trigger OnPreReport()
    var
        AcceRec: Record AccessoriesStatusReportNew;
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
            LoginSessionsRec.FindSet();
        end;

        // Delete old records
        AcceRec.Reset();
        AcceRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
        if AcceRec.FindSet() then
            AcceRec.DeleteAll();

        //Get Max Seq No
        AcceRec.Reset();
        if AcceRec.FindLast() then
            MaxSeqNo := AcceRec."SeqNo";

        //Get Po lines
        PurchLineRec.Reset();
        PurchLineRec.SetRange(StyleNo, FilterNo);
        PurchLineRec.SetFilter("Document Type", '=%1', PurchLineRec."Document Type"::Order);
        if PurchLineRec.FindSet() then begin
            repeat

                AcceRec.Reset();
                AcceRec.SetRange("Item No", PurchLineRec."No.");
                AcceRec.SetRange("PONo.", PurchLineRec."Document No.");
                AcceRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
                if AcceRec.FindSet() then begin
                    //Modify item line
                    AcceRec."PO Qty" := AcceRec."PO Qty" + PurchLineRec.Quantity;
                    AcceRec.Modify();
                end
                else begin
                    MaxSeqNo += 1;

                    //Get Item details
                    ItemRec.Reset();
                    ItemRec.SetRange("No.", PurchLineRec."No.");
                    if ItemRec.FindSet() then begin
                        //insert lines
                        AcceRec.Init();
                        AcceRec.SeqNo := MaxSeqNo;
                        AcceRec.StyleNo := FilterNo;
                        AcceRec."PONo." := PurchLineRec."Document No.";
                        AcceRec."Item No" := ItemRec."No.";
                        AcceRec.Article := ItemRec.Article;
                        AcceRec.Unit := ItemRec."Base Unit of Measure";
                        AcceRec.Color := ItemRec."Color Name";
                        AcceRec.Dimension := ItemRec."Dimension Width";
                        AcceRec."Item Desc" := ItemRec."Description";
                        AcceRec.Size := ItemRec."Size Range No.";
                        AcceRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        AcceRec."PO Qty" := PurchLineRec.Quantity;
                        AcceRec.Insert();
                    end
                    else
                        Error('Cannot find Item details for : %1', PurchLineRec."No.");
                end;

            until PurchLineRec.Next() = 0;
        end;

        //Get Archieve lines           
        PurchaseArchiveRec.Reset();
        PurchaseArchiveRec.SetRange(StyleNo, FilterNo);
        PurchaseArchiveRec.SetFilter("Document Type", '=%1', PurchaseArchiveRec."Document Type"::Order);
        if PurchaseArchiveRec.FindSet() then begin
            repeat
                MaxSeqNo += 1;

                //Get Item details
                ItemRec.Reset();
                ItemRec.SetRange("No.", PurchaseArchiveRec."No.");
                if ItemRec.FindSet() then begin

                    //Check existance of the item
                    AcceRec.Reset();
                    AcceRec.SetRange("Item No", PurchaseArchiveRec."No.");
                    AcceRec.SetRange("PONo.", PurchaseArchiveRec."Document No.");
                    AcceRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
                    if AcceRec.FindSet() then begin
                        //Modify item line
                        AcceRec."PO Qty" := AcceRec."PO Qty" + PurchaseArchiveRec.Quantity;
                        AcceRec.Modify();
                    end
                    else begin

                        //insert item line
                        AcceRec.Init();
                        AcceRec.SeqNo := MaxSeqNo;
                        AcceRec.StyleNo := FilterNo;
                        AcceRec."PONo." := PurchaseArchiveRec."Document No.";
                        AcceRec."Item No" := ItemRec."No.";
                        AcceRec.Article := ItemRec.Article;
                        AcceRec.Unit := ItemRec."Base Unit of Measure";
                        AcceRec.Color := ItemRec."Color Name";
                        AcceRec.Dimension := ItemRec."Dimension Width";
                        AcceRec."Item Desc" := ItemRec."Description";
                        AcceRec.Size := ItemRec."Size Range No.";
                        AcceRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        AcceRec."PO Qty" := PurchaseArchiveRec.Quantity;
                        AcceRec.Insert();
                    end;
                end
                else
                    Error('Cannot find Item details for : %1', PurchaseArchiveRec."No.");
            until PurchaseArchiveRec.Next() = 0;
        end;

        //Get GRN Lines                  
        PurchRcptLineRec.Reset();
        PurchRcptLineRec.SetRange(StyleNo, FilterNo);
        if PurchRcptLineRec.FindSet() then begin
            repeat
                MaxSeqNo += 1;

                //Get Item details
                ItemRec.Reset();
                ItemRec.SetRange("No.", PurchRcptLineRec."No.");
                if ItemRec.FindSet() then begin

                    //Check existance of the item
                    PurchHDRec.Reset();
                    PurchHDRec.SetRange("No.", PurchRcptLineRec."Document No.");
                    if PurchHDRec.FindFirst() then
                        OrderNO := PurchHDRec."Order No.";

                    AcceRec.Reset();
                    AcceRec.SetRange("Item No", PurchRcptLineRec."No.");
                    AcceRec.SetRange("PONo.", OrderNO);
                    AcceRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
                    if AcceRec.FindSet() then begin
                        //Modify item line
                        AcceRec."GRN Qty" := AcceRec."GRN Qty" + PurchRcptLineRec.Quantity;
                        AcceRec.Balance := AcceRec."PO Qty" - AcceRec."GRN Qty";
                        AcceRec.Modify();
                    end
                    else begin

                        //insert item line
                        AcceRec.Init();
                        AcceRec.SeqNo := MaxSeqNo;
                        AcceRec.StyleNo := FilterNo;
                        AcceRec."PONo." := OrderNO;
                        AcceRec."Item No" := ItemRec."No.";
                        AcceRec.Article := ItemRec.Article;
                        AcceRec.Unit := ItemRec."Base Unit of Measure";
                        AcceRec.Color := ItemRec."Color Name";
                        AcceRec.Dimension := ItemRec."Dimension Width";
                        AcceRec."Item Desc" := ItemRec."Description";
                        AcceRec.Size := ItemRec."Size Range No.";
                        AcceRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        AcceRec."PO Qty" := 0;
                        AcceRec."GRN Qty" := PurchRcptLineRec.Quantity;
                        AcceRec.Balance := AcceRec."PO Qty" - AcceRec."GRN Qty";
                        AcceRec.Insert();
                    end;
                end
                else
                    Error('Cannot find Item details for : %1', PurchRcptLineRec."No.");
            until PurchRcptLineRec.Next() = 0;
        end;


        //get Issue Qty
        AcceRec.Reset();
        AcceRec.SetRange(StyleNo, FilterNo);
        AcceRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
        if AcceRec.FindSet() then begin
            repeat
                IssueQty := 0;
                ItemLedgerRec.Reset();
                ItemLedgerRec.SetRange("Style No.", FilterNo);
                ItemLedgerRec.SetRange("Item No.", AcceRec."Item No");
                ItemLedgerRec.SetFilter("Entry Type", '=%1', ItemLedgerRec."Entry Type"::Consumption);

                if ItemLedgerRec.FindSet() then begin
                    repeat
                        IssueQty += ItemLedgerRec.Quantity;
                    until ItemLedgerRec.Next() = 0;
                end;

                AcceRec."Issue Qty" := IssueQty * -1;
                AcceRec."Stock Balance" := AcceRec."GRN Qty" - AcceRec."Issue Qty";
                AcceRec.Balance := AcceRec."PO Qty" - AcceRec."GRN Qty";
                AcceRec.Modify();
            until AcceRec.Next() = 0;
        end
    end;

    procedure PassParameters(StyleNoPara: Code[50])
    var
    begin
        FilterNo := StyleNoPara;
        EditableGB := true;
    end;

    var
        EditableGB: Boolean;
        MaxSeqNo: BigInteger;
        LoginSessionsRec: Record LoginSessions;
        ItemRec: Record Item;
        PurchLineRec: Record "Purchase Line";
        Qty: Decimal;
        PurchRcptLineRec: Record "Purch. Rcpt. Line";
        IssueQty: Decimal;
        PurchHDRec: Record "Purch. Rcpt. Header";
        OrderNO: code[50];
        PurchaseArchiveRec: Record "Purchase Line Archive";
        comRec: Record "Company Information";
        FilterNo: Code[50];
        ItemLedgerRec: Record "Item Ledger Entry";
}