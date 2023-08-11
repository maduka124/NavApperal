report 51392 MaterialIssueRequitionCommon
{
    RDLCLayout = 'Report_Layouts/Store/MatRequisitionIssueCommon.rdl';
    DefaultLayout = RDLC;
    Caption = 'Raw Material Requisition Status Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Daily Consumption Header"; "Daily Consumption Header")
        {
            DataItemTableView = where("Journal Template Name" = filter('CONSUMPTIO'));

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

            dataitem("Daily Consumption Line2"; "Daily Consumption Line2")
            {
                DataItemLinkReference = "Daily Consumption Header";
                DataItemLink = "Daily Consumption Doc. No." = field("No.");

                column(Item_No_; "Item No.")
                { }
                column(Source_No_FG; "Source No.")
                { }
                column(Quantity; "Posted requirement")
                { }
                column(DescriptionLine; DescriptionRec)
                { }
                column(UOM; "UOM")
                { }
                column(Original_Daily_Requirement; "Original Requirement")
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
                        Caption = 'Req. No';

                        trigger OnLookup(var texts: text): Boolean
                        var
                            DailyConsRec: Record "Daily Consumption Header";
                        begin
                            DailyConsRec.Reset();
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
