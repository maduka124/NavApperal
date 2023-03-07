report 50724 ContractExportStatus
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Contract Export Status Report';
    RDLCLayout = 'Report_Layouts/Commercial/ContractExportStatusReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = sorting("No.");
            column(Style_Name; "Style No.")
            { }
            column(Buyer; "Buyer Name")
            { }
            column(CompLogo; comRec.Picture)
            { }
            dataitem("Style Master PO"; "Style Master PO")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting("Style No.");
                column(PO_No_; "PO No.")
                { }
                column(Qty; Qty)
                { }
                column(RoundUnitPrice; RoundUnitPrice)
                { }
                column(RoundOrderValue; RoundOrderValue)
                { }
                column(Ship_Date; "Ship Date")
                { }
                column(Shipped_Qty; "Shipped Qty")
                { }
                column(RoundShip; RoundShip)
                { }

                // column()
                // {}

                trigger OnAfterGetRecord()
                begin
                    RoundUnitPrice := Round("Unit Price", 0.01, '=');
                    RoundOrderValue := Qty * RoundUnitPrice;
                    RoundShip := "Shipped Qty" * RoundUnitPrice;

                end;
            }
            trigger OnPreDataItem()

            begin
                SetRange("Buyer No.", FilterBuyer);
                SetRange(AssignedContractNo, LcNo);
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
                    field(FilterBuyer; FilterBuyer)
                    {
                        ApplicationArea = All;
                        Caption = 'Buyer No';
                        TableRelation = Customer."No.";
                    }
                    field(LcNo; LcNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Contract No';
                        TableRelation = "Contract/LCMaster"."No.";
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
        LcNo: Text[20];
        FilterBuyer: Code[20];
        RoundOrderValue: Decimal;
        RoundUnitPrice: Decimal;
        RoundShip: Decimal;
        comRec: Record "Company Information";

}