report 50636 ProductionStatus
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Production Status Report';
    RDLCLayout = 'Report_Layouts/Production/ProductionStatus.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Style Master"; "Style Master")
        {

            DataItemTableView = sorting("No.");
            column(Buyer_Name; "Buyer Name")
            { }
            column(Style_No_; "Style No.")
            { }
            column(Description; "No.")
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
                column(Cut_Qty; "Cut Out Qty")
                { }
                column(Sawing_In_Qty; "Sawing In Qty")
                { }
                column(Sawing_Out_Qty; "Sawing Out Qty")
                { }
                column(Shipped_Qty; "Shipped Qty")
                { }
                column(Created_Date; "Created Date")
                { }
                column(BalCut; "Cut Out Qty" - Qty)
                { }
                column(BalIn; "Sawing In Qty" - "Cut Out Qty")
                { }
                column(BalOut; "Sawing Out Qty" - "Sawing In Qty")
                { }
                column(BalShip; "Shipped Qty" - Qty)
                { }
                column(Ship_Date; "Ship Date")
                { }


            }
            trigger OnPreDataItem()
            begin
                SetRange("No.", FilterNo);

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
                    field(FilterNo; FilterNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Style No';
                        TableRelation = "Style Master"."No.";

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
        ItemRec: Record Item;
        Description: text[200];
        FilterNo: Code[50];
        comRec: Record "Company Information";


}