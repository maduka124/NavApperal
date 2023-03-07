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
            DataItemTableView = where(Status = filter('Approved'), "Journal Template Name" = filter('CONSUMPTIO'));

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

            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLinkReference = "Daily Consumption Header";
                // DataItemLink = "Document No." = field("Prod. Order No.");
                DataItemLink = "Daily Consumption Doc. No." = field("No."), "Document No." = field("Prod. Order No.");
                DataItemTableView = where("Entry Type" = filter(Consumption));

                column(Quantity; Quantity * -1)
                { }
                column(OrginalDailyReq; RoundDailyReq)
                { }
                column(Item_No_; "Source No.")
                { }
                column(DescriptionLine; DescriptionRec)
                { }
                column(SystemCreatedAt; "Posting Date")
                { }
                column(UOM; "Unit of Measure Code")
                { }
                column(Location; "Location Code")
                { }
                column(size; size)
                { }
                column(Original_Daily_Requirement; "Original Daily Requirement")
                { }

                trigger OnAfterGetRecord()
                begin
                    ItemRec.Reset();
                    ItemRec.SetRange("No.", "Source No.");
                    if ItemRec.FindFirst() then begin
                        size := ItemRec."Size Range No.";
                        UOM := ItemRec."Base Unit of Measure";
                        Location := ItemRec."Location Filter";
                        DescriptionRec := ItemRec.Description;
                    end;

                    RoundDailyReq := Round("Original Daily Requirement", 0.01, '>');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()
            var
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
                        TableRelation = "Daily Consumption Header"."No." where(Status = filter(Approved),
                        "Issued UserID" = filter(<> ''));

                    }
                }
            }
        }
    }

    var
        RoundDailyReq: Decimal;
        DescriptionRec: Text[200];
        Location: Code[20];
        UOM: Code[20];
        size: Code[20];
        ItemRec: Record Item;
        JournalNo: Code[20];
        comRec: Record "Company Information";
}
