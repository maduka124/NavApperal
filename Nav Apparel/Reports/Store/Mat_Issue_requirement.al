report 51801 MaterialIssueRequition
{
    RDLCLayout = 'Report_Layouts/Store/MatRequisitionIssue.rdl';
    DefaultLayout = RDLC;
    Caption = 'Raw Material Issue Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Daily Consumption Header"; "Daily Consumption Header")
        {
            DataItemTableView = where(Status = filter("Approved"), "Journal Template Name" = filter('CONSUMPTIO'));

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
            column(AllocatedFactory; AllocatedFactory)
            { }
            column(Department_Name; "Department Name")
            { }
            column(Document_Date; "Document Date")
            { }
            column(Approved_Date_Time; "Approved Date/Time")
            { }
            column(Colour_Name; "Colour Name")
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
                column(Posted_Daily_Consump__Doc__No_; "Posted Daily Consump. Doc. No.")
                { }
                column(Main_Category_Name; MainCategoryName1)
                { }


                trigger OnAfterGetRecord()
                begin
                    UOM := '';
                    DescriptionRec := '';
                    MainCategoryName1 := '';

                    ItemRec.Reset();
                    ItemRec.SetRange("No.", "Item No.");
                    if ItemRec.FindFirst() then begin
                        UOM := ItemRec."Base Unit of Measure";
                        DescriptionRec := ItemRec.Description;
                    end;

                    ItemRec.Reset();
                    ItemRec.SetRange("No.", "Item No.");
                    if ItemRec.Findset() then begin
                        MainCategoryRec.Reset();
                        MainCategoryRec.SetRange("No.", ItemRec."Main Category No.");
                        if MainCategoryRec.Findset() then
                            MainCategoryName1 := MainCategoryRec."Main Category Name"
                        else
                            MainCategoryName1 := '';
                    end
                    else
                        MainCategoryName1 := '';
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
                group(Filter)
                {
                    Caption = 'Filter By';
                    field(JournalNo; JournalNo)
                    {
                        ApplicationArea = All;
                        Caption = 'No';
                        //TableRelation = "Daily Consumption Header"."No.";
                        //where(Status = filter(Approved),"Issued UserID" = filter(<> ''));

                        trigger OnLookup(var texts: text): Boolean
                        var
                            DailyConsRec: Record "Daily Consumption Header";
                        begin
                            DailyConsRec.Reset();
                            DailyConsRec.SetFilter(Status, '%1', DailyConsRec.Status::Approved);
                            if DailyConsRec.FindSet() then begin
                                repeat
                                    DailyConsRec.MARK(TRUE);
                                until DailyConsRec.Next() = 0;

                                DailyConsRec.MARKEDONLY(TRUE);
                                if Page.RunModal(51390, DailyConsRec) = Action::LookupOK then begin
                                    JournalNo := DailyConsRec."No.";
                                end;
                            end;
                        end;
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
        MainCategoryRec: Record "Main Category";
        AllocatedFactory: text[50];
        MainCategoryName1: Text[50];
}
