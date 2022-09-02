report 50642 PurchaseOrderReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Purchase Order Report';
    RDLCLayout = 'Report_Layouts/Merchandizing/PurchaseOrderReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("No.");
            column(SystemCreatedBy; SystemCreatedBy)
            { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.")
            { }
            column(Pay_to_Contact; "Pay-to Contact")
            { }
            column(Pay_to_Address; "Pay-to Address")
            { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            { }
            column(companyName; comrec.Name)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Due_Date; "Due Date")
            { }
            column(TermDes; TermDes)
            { }
            column(PONo_; "No.")
            { }
            column(Pay_to_Address_2; "Pay-to Address 2")
            { }
            column(Pay_to_City; "Pay-to City")
            { }
            column(Pay_to_County; "Pay-to County")
            { }
            column(Pay_to_Post_Code; "Pay-to Post Code")
            { }
            column(Document_Date; "Document Date")
            { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLinkReference = "Purchase Header";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.");

                column(Quantity; Quantity)
                { }
                column(Line_Amount; "Line Amount")
                { }
                column(Direct_Unit_Cost; "Direct Unit Cost")
                { }
                column(Buyer; Buyer)
                { }
                column(Season; Season)
                { }
                column(Style; Style)
                { }
                column(Description; Description)
                { }
                // column(MainCategory; MainCategory)
                // { }
                dataitem(Item; Item)
                {
                    DataItemLinkReference = "Purchase Line";
                    DataItemLink = "No." = field("No.");
                    DataItemTableView = sorting("No.");
                    column(MainCategory; "Main Category Name")
                    { }
                    column(SizeRangeNo; "Size Range No.")
                    { }
                    column(Article; ArticleName)
                    { }
                    column(DimenshionWidthNo; "Dimension Width")
                    { }
                    column(ItemDescription; Description)
                    { }
                    column(No_; "No.")
                    { }
                    column(color; "Color Name")
                    { }
                    column(Unit_of_Measure; "Base Unit of Measure")
                    { }
                    trigger OnAfterGetRecord()

                    begin
                        ArticleRec.SetRange("No.", "Article No.");
                        if ArticleRec.FindFirst() then begin
                            ArticleName := ArticleRec.Article;
                        end;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    // ItemRec.SetRange("No.", "Purchase Line"."No.");
                    // if ItemRec.FindFirst() then begin
                    //     SizeRangeNo := ItemRec."Size Range No.";
                    //     Article := ItemRec.Article;
                    //     DimenshionWidthNo := ItemRec."Dimension Width";
                    //     color := ItemRec."Color Name";
                    //     MainCategory := ItemRec."Main Category Name"
                    // end;
                    StyleRec.SetRange("No.", StyleNo);
                    if StyleRec.FindFirst() then begin
                        Buyer := StyleRec."Buyer Name";
                        Season := StyleRec."Season Name";
                        Style := StyleRec."Style No.";
                    end;
                end;

            }
            trigger OnAfterGetRecord()

            begin
                PaymentsRec.SetRange(Code, "Payment Terms Code");
                if PaymentsRec.FindFirst() then begin
                    TermDes := PaymentsRec.Description;
                end;
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
                        Caption = 'Purchase No';
                        TableRelation = "Purchase Header"."No.";

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var

        color: Text[50];
        SizeRangeNo: Code[20];
        ArticleName: text[50];
        DimenshionWidthNo: Text[100];
        ItemRec: Record Item;
        comrec: Record "Company Information";
        StyleRec: Record "Style Master";
        Season: Text[50];
        Buyer: Text[50];
        Style: Text[50];
        PaymentsRec: Record "Payment Terms";
        TermDes: Text[100];
        FilterNo: Code[30];
        MainCategory: text[50];
        ArticleRec: Record Article;
}