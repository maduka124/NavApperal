report 50711 DepartmentRequisitionReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Department Requisition Report';
    RDLCLayout = 'Report_Layouts/Store/departmentReqReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(DeptReqSheetHeader; DeptReqSheetHeader)
        {
            DataItemTableView = sorting("Req No");
            column(Factory_Name; "Factory Name")
            { }

            column(Req_No; "Req No")
            { }

            column(Request_Date; "Request Date")
            { }

            column(Department_Name; "Department Name")
            { }

            column(Completely_Received; "Completely Received")
            { }

            column(Remarks; Remarks)
            { }

            column(CompLogo; comRec.Picture)
            { }

            column(stDate; stDate)
            { }

            column(endDate; endDate)
            { }

            dataitem(DeptReqSheetLine; DeptReqSheetLine)
            {
                DataItemLinkReference = DeptReqSheetHeader;
                DataItemLink = "Req No" = field("Req No");
                DataItemTableView = sorting("Req No", "Line No");
                column(Item_Name; "Item Name")
                { }

                column(Qty; Qty)
                { }

                column(UOM; UOM)
                { }

                column(Qty_Received; "Qty Received")
                { }

                column(Qty_to_Received; "Qty to Received")
                { }

                column(Remarksline; Remarks)
                { }

                column(PO_Raized; "PO Raized")
                { }

                column(Main_Category_Name; "Main Category Name")
                { }

                column(Sub_Category_Name; "Sub Category Name")
                { }

                column(Article; Article)
                { }

                column(Size_Range_No_; "Size Range No.")
                { }

                column(Color_Name; "Color Name")
                { }

                column(Dimension_Name_; "Dimension Name.")
                { }

                column(Other; Other)
                { }
            }
            trigger OnPreDataItem()

            begin
                SetRange("Factory Code", Factory);
                SetRange("Request Date", stDate, endDate);
            end;

            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);
                // Message('Req No. %1', "Req No");

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
                    field(Factory; Factory)
                    {
                        ApplicationArea = All;
                        Caption = 'Factory';
                        TableRelation = location.Code;
                    }

                    field(stDate; stDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }

                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
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
        myInt: Integer;

        // "PO Raized": Boolean;
        Factory: Code[50];
        comRec: Record "Company Information";
        stDate: Date;
        endDate: Date;
}