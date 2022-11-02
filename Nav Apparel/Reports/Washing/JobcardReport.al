report 50670 JobCardReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Job Card Report';
    RDLCLayout = 'Report_Layouts/Washing/JobCardReport.rdl';
    //PdfFontEmbedding = Yes;
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = sorting("No.");
            //RequestFilterFields=Status;
            column(Barcode; Barcode)
            { }
            column(Buyer; Buyer)
            { }
            column(No_; "No.")
            { }
            column(Description; Description)
            { }
            column(Due_Date; "Due Date")
            { }
            column(Style_No; "Style Name")
            { }
            column(Sample_Bulk; "Sample/Bulk")
            { }
            column(PO; PO)
            { }
            column(Wash_Type; "Wash Type")
            { }
            column(Hydro_Extractor__Minutes_; "Hydro Extractor (Minutes)")
            { }
            column(Hot_Dryer__Temp__C_; "Hot Dryer (Temp 'C)")
            { }
            column(Cool_Dry; "Cool Dry")
            { }
            column(Color; Color)
            { }
            column(Fabric; Fabric)
            { }
            column(Gament_Type; "Gament Type")
            { }
            column(Machine_Type; "Machine Type")
            { }
            column(Load_Wght__Kg_; "Load Weight (Kg)")
            { }
            column(Piece_Wght__g_; "Piece Weight (g)")
            { }
            column(Remarks_Job_Card; "Remarks Job Card")
            { }
            column(Total_Water_Ltrs_; "Total Water Ltrs:")
            { }
            column(Process_Time_; "Process Time:")
            { }

            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                DataItemLinkReference = "Production Order";
                DataItemLink = "Prod. Order No." = field("No.");
                DataItemTableView = sorting(Status, "Prod. Order No.", "Line No.");

                column(Descriptionline; Description)
                { }
                column(Water; Water)
                { }
                column(Temp; Temp)
                { }
                column(Step; Step)
                { }
                column(Ph; Ph)
                { }
                column(Instruction; Instruction)
                { }
                column(Time_Min_; "Time(Min)")
                { }
                // column("Chemical Name")
                // { }
                column(Quantity; Quantity)
                { }

            }
            trigger OnPreDataItem()

            begin
                SetRange("No.", OrderNo);
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
                    field(OrderNo; OrderNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Production Order No';
                        TableRelation = "Production Order"."No.";

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
        OrderNo: Code[50];

}