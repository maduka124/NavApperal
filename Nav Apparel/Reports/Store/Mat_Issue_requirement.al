report 51801 MaterialIssueRequition
{
    RDLCLayout = 'Report_Layouts/Store/MatRequisitionIssue.rdl';
    DefaultLayout = RDLC;
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
            column(AllocatedFactory; AllocatedFactory)
            { }

            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLinkReference = "Daily Consumption Header";
                DataItemLink = "Daily Consumption Doc. No." = field("No."), "Document No." = field("Prod. Order No.");
                DataItemTableView = where("Entry Type" = filter(Consumption));

                column(Item_No_; "Item No.")
                { }
                column(Source_No_FG; "Source No.")
                { }
                column(Quantity; Quantity * -1)
                { }
                column(DescriptionLine; DescriptionRec)
                { }
                column(SystemCreatedAt; "Posting Date")
                { }
                column(UOM; "Unit of Measure Code")
                { }
                column(Original_Daily_Requirement; "Original Daily Requirement")
                { }

                trigger OnAfterGetRecord()
                begin
                    UOM := '';
                    DescriptionRec := '';

                    ItemRec.Reset();
                    ItemRec.SetRange("No.", "Item No.");
                    if ItemRec.FindFirst() then begin
                        UOM := ItemRec."Base Unit of Measure";
                        DescriptionRec := ItemRec.Description;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                StyleMasRec: Record "Style Master";
            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                StyleMasRec.Reset();
                StyleMasRec.SetRange("Style No.", "Daily Consumption Header"."Style No.");
                if StyleMasRec.Findset() then
                    AllocatedFactory := StyleMasRec."Factory Name";

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
        DescriptionRec: Text[200];
        UOM: Code[20];
        ItemRec: Record Item;
        JournalNo: Code[20];
        comRec: Record "Company Information";
        AllocatedFactory: text[50];
}
