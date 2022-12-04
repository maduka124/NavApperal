report 50126 generalIssueReportItem
{
    UsageCategory = ReportsAndAnalysis;
    // ApplicationArea = All;
    Caption = 'General Issue Note';
    RDLCLayout = 'Reports/Report_Layouts/GeneralIssueReportItem.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Item Journal Line"; "Item Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.");
            column(Line_No_; "Line No.")
            { }
            column(Document_No_; "Document No.")
            { }
            column(Item_No_; "Item No.")
            { }
            column(Description; Description)
            { }
            column(Quantity; Quantity)
            { }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            { }
            column(Main_Category_Name; "Main Category Name")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            { }
            column(Requsting_Department_Name; "Requsting Department Name")
            { }
            //     column()
            //     { }
            //     column()
            //     { }
            //     column()
            //     { }

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()

            begin
                SetRange("Document No.", DocumentNo);
                SetRange("Location Code", LocationFilter);
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
                    field(DocumentNo; DocumentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'No';
                        Editable = false;

                    }
                    field(LocationFilter; LocationFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Batch Name';
                        Editable = false;

                    }
                }
            }
        }


    }
    procedure Set_Value(No: Code[20])
    var
    begin
        DocumentNo := No;
    end;

    procedure Set_batch(Location: Code[100])
    var
    begin
        LocationFilter := Location;
    end;


    var
        LocationFilter: Code[10];
        DocumentNo: Code[20];
        comRec: Record "Company Information";
}