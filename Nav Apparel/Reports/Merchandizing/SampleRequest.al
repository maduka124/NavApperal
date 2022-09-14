report 50639 SampleRequest
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sample Request Report';
    RDLCLayout = 'Report_Layouts/Merchandizing/SampleRequest.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sample Requsition Header"; "Sample Requsition Header")
        {
            DataItemTableView = sorting("No.");
            column(Buyer_Name; "Buyer Name")
            { }
            column(Style_Name; "Style Name")
            { }
            column(Wash_Plant_Name; "Wash Plant Name")
            { }
            column(Wash_Type_Name; "Wash Type Name")
            { }
            column(Created_Date; "Created Date")
            { }
            column(Created_User; "Created User")
            { }
            column(Style_No_; "Style No.")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(No_; "No.")
            { }

            dataitem("Sample Requsition Line"; "Sample Requsition Line")
            {
                DataItemLinkReference = "Sample Requsition Header";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.");
                column(Sample_Name; "Sample Name")
                { }
                column(Color_Name; "Color Name")
                { }
                column(Size; Size)
                { }
                column(Qty; Qty)
                { }
                column(Req_Date; "Req Date")
                { }
                column(Comment; Comment)
                { }
                column(Fabrication_Name; "Fabrication Name")
                { }
            }
            dataitem("Sample Requsition Acce"; "Sample Requsition Acce")
            {
                DataItemLinkReference = "Sample Requsition Header";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.");
                column(Requirment; Requirment)
                { }
                column(AcceRemarks; Remarks)
                { }
                column(MainCategoryName; "Main Category Name")
                { }
            }

            trigger OnPreDataItem()

            begin
                SetRange("No.", HeaderNo);
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
                    field(HeaderNo; HeaderNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Sample Request No';
                        TableRelation = "Sample Requsition Header"."No.";

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


    var

        HeaderNo: Code[20];
        comRec: Record "Company Information";


}