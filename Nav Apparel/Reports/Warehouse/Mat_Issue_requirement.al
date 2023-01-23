report 51801 MaterialIssueRequition
{
    RDLCLayout = 'Report_Layouts/Warehouse/MatRequisitionIssue.rdl';
    DefaultLayout = RDLC;
    // ApplicationArea = Manufacturing;
    Caption = 'Material Requisition Issue Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Daily Consumption Header"; "Daily Consumption Header")
        {

            // DataItemTableView = where(Status = filter('Released'));
            // PrintOnlyIfDetail = true;
            DataItemTableView = sorting("No.");
            column(CompLogo; comRec.Picture)
            { }
            column(IssueNo; "No.")
            { }
            column(Source_No_; "Source No.")
            { }
            column(Buyer; Buyer)
            { }
            column(Description; Description)
            { }
            column(Style_Name; "Style Name")
            { }
            column(PO; PO)
            { }
            column(Main_Category_Name; "Main Category Name")
            { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }



            dataitem("Daily Consumption Line"; "Daily Consumption Line")
            {

                DataItemLinkReference = "Daily Consumption Header";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                // DataItemTableView = sorting("Item No.", "Posting Date");
                // RequestFilterFields = "Document No.";
                // DataItemLink = Status = FIELD(Status), "Prod. Order No." = FIELD("No.");
                // DataItemTableView = SORTING(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");
                // column(ItemNo_ProdOrderComp; "Item No.")
                // {
                //     IncludeCaption = true;
                // }

                column(Item_No_; "Item No.")
                { }
                column(DescriptionLine; Description)
                { }
                column(Issued_Quantity; "Issued Quantity")
                { }
                column(Daily_Consumption; "Daily Consumption")
                { }
                column(SystemCreatedAt; SystemCreatedAt)
                { }
                column(size; size)
                { }
                column(UOM; UOM)
                { }
                column(Location; Location)
                { }

                trigger OnPreDataItem()

                begin
                    // SetRange("Document No.", JournalNo);
                    // SetRange("Journal Batch Name", JournalBatchFilter);
                    // // SetRange("Daily Consumption Doc. No.", DocNumber);
                    // JournalBatchFilter := 'DEFAULT';
                end;

                trigger OnAfterGetRecord()

                begin
                    ItemRec.Reset();
                    ItemRec.SetRange("No.", "Item No.");
                    if ItemRec.FindFirst() then begin
                        size := ItemRec."Size Range No.";
                        UOM := ItemRec."Base Unit of Measure";
                        Location := ItemRec."Location Filter";
                    end;
                end;


            }
            trigger OnAfterGetRecord()
            begin

                comRec.Get;
                comRec.CalcFields(Picture);

            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetRange("No.", JournalNo);
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
                    field(JournalNo; JournalNo)
                    {
                        ApplicationArea = All;
                        Caption = 'No';
                        TableRelation = "Daily Consumption Header"."No." where(Status = filter(Approved));
                    }


                }
            }
        }
    }





    var
        Location: Code[20];
        UOM: Code[20];
        size: Code[20];
        ItemRec: Record Item;
        DocNumber: Code[20];
        JournalBatchFilter: Code[10];
        JournalNo: Code[20];
        comRec: Record "Company Information";
}
