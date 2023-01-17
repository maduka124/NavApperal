report 50124 GeneralIssueReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    Caption = 'General Issue Note Report';
    RDLCLayout = 'Reports/Report_Layouts/GeneralIssueReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("General Issue Header"; "General Issue Header")
        {
            DataItemTableView = sorting("No.");
            column(BuCode; BuCode)
            { }
            column(Department_Name; "Department Name")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(No_; "No.")
            { }


            dataitem("General Issue Line"; "General Issue Line")
            {
                DataItemLinkReference = "General Issue Header";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                column(Line_No_; "Line No.")
                { }
                column(Document_No_; "Document No.")
                { }
                column(Item_No_; "Item Code")
                { }
                column(Description; Description)
                { }
                column(Quantity; Quantity)
                { }
                column(Unit_of_Measure_Code; "Unit of Measure")
                { }
                column(Main_Category_Name; "Main Category Name")
                { }

            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLinkReference = "General Issue Header";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Entry No.");
                column(ItemLeQuantity; Quantity)
                { }
            }
            trigger OnPreDataItem()

            begin
                SetRange("No.", GenIssueNo);
            end;

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                ItemJournalBatchRec.Reset();
                ItemJournalBatchRec.SetRange(Name, "Journal Batch Name");
                if ItemJournalBatchRec.FindFirst() then begin
                    BuCode := ItemJournalBatchRec."Shortcut Dimension 1 Code";
                end;

                // ItemLedgRec.Reset();
                // ItemLedgRec.SetRange("Document No.", "No.");
                // if ItemLedgRec.FindFirst() then begin
                //     ItemLeQuantity := ItemLedgRec.Quantity;
                // end;
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
                    field(GenIssueNo; GenIssueNo)
                    {
                        ApplicationArea = All;
                        Caption = 'No';
                        TableRelation = "General Issue Header"."No.";

                    }
                }
            }
        }
    }

    var
        ItemLeQuantity: Decimal;
        ItemLedgRec: Record "Item Ledger Entry";
        BuCode: Code[20];
        GenIssueNo: Code[20];
        comRec: Record "Company Information";
        ItemJournalBatchRec: Record "Item Journal Batch";
}