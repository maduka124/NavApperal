report 50122 StyleTransferReportCard
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Style Transfer Report';
    RDLCLayout = 'Reports/Report_Layouts/StyleTransferReport.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Style transfer Header"; "Style transfer Header")
        {
            DataItemTableView = sorting("No.");
            column(From_Prod__Order_No_; "From Prod. Order No.")
            { }
            column(To_Prod__Order_No_; "To Prod. Order No.")
            { }
            column(From_Style_Name; "From Style Name")
            { }
            column(To_Style_Name; "To Style Name")
            { }
            column(Remarks; Remarks)
            { }
            column(CompLogo; comRec.Picture)
            { }

            dataitem("Style Transfer Line"; "Style Transfer Line")
            {
                DataItemLinkReference = "Style transfer Header";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                column(Main_Category_Name; "Main Category Name")
                { }
                column(Main_Category; "Main Category")
                { }
                column(Item_Code; "Item Code")
                { }
                column(Description; Description)
                { }
                column(Required_Quantity; "Required Quantity")
                { }
                column(Unit_of_Measure; "Unit of Measure")
                { }
            }

            trigger OnPreDataItem()

            begin
                SetRange("No.", StyleTranferFilter);
            end;

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
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
                    field(StyleTranferFilter; StyleTranferFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'No';
                        // TableRelation = "Style transfer Header"."No.";
                        Editable = false;

                    }
                }
            }
        }


    }
    procedure Set_Value(FilterNo: Code[20])
    var
    begin
        StyleTranferFilter := FilterNo;
    end;



    var
        StyleTranferFilter: Code[20];
        comRec: Record "Company Information";

}