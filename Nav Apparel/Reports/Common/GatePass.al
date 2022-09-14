report 50785 GatePassReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Gate Pass Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/Common/GatePassReport.rdl';

    dataset
    {
        dataitem("Gate Pass Header"; "Gate Pass Header")
        {
            DataItemTableView = sorting("No.");

            column(No_; "No.")
            { }
            column(Barcode; Barcode)
            { }
            column(Transfer_From_Name; "Transfer From Name")
            { }
            column(Transfer_To_Name; "Transfer To Name")
            { }
            column(Vehicle_No_; "Vehicle No.")
            { }
            column(Type; Type)
            { }
            column(Transfer_Date; "Transfer Date")
            { }
            column(Expected_Return_Date; "Expected Return Date")
            { }
            column(Sent_By; "Sent By")
            { }
            column(Approved_By; "Approved By")
            { }
            column(Remarks; Remarks)
            { }
            column(CompLogo; comRec.Picture)
            { }


            dataitem("Gate Pass. Line"; "Gate Pass Line")
            {
                DataItemLinkReference = "Gate Pass Header";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("Seq No");

                column(Consignment_Type; "Inventory Type")
                { }
                column(Main_Category_Name; "Main Category Name")
                { }
                column(Description; Description)
                { }
                column(Item_No_; "Item No.")
                { }
                column(Qty; Qty)
                { }
                column(UOM; UOM)
                { }
                column(LineRemarks; Remarks)
                { }              
            }

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
                    field(FilterNo; FilterNoGB)
                    {
                        ApplicationArea = All;
                        Caption = 'Gate Pass No';
                        Editable = false;
                    }
                }
            }
        }
    }

    procedure Set_Value(FilterNoPara: Code[20])
    var
    begin
        FilterNoGB := FilterNoPara;
    end;


    var
        comRec: Record "Company Information";
        FilterNoGB: Code[30];
}