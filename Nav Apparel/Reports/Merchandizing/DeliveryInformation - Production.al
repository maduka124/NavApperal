report 51073 DeliveryInfoProductReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Delivery Details';
    RDLCLayout = 'Report_Layouts/Merchandizing/Delivery Details.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = where(Status = filter('Confirmed'));
            column(Season_Name; "Season Name")
            { }
            column(No_; "No.")
            { }
            column(Style_No_; "Style No.")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(SMV; SMV)
            { }
            column(Factory_Name; "Factory Name")
            { }
            column(Created_User; "Created User")
            { }
            // column(BPCD; BPCD)
            // { }
            column(CompLogo; comRec.Picture)
            { }
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }

            dataitem("Style Master PO"; "Style Master PO")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting("Lot No.");
                column(PO_No_; "PO No.")
                { }
                column(Qty; Qty)
                { }
                column(Mode; Mode)
                { }
                column(Sawing_Out_Qty; "Sawing Out Qty")
                { }
                column(Unit_Price; UnitPriceRound)
                { }
                column(Total; UnitPriceRound * Qty)
                { }
                column(Created_Date; "Created Date")
                { }
                column(Confirm_Date; "Confirm Date")
                { }
                column(BPCD; BPCD)
                { }



                trigger OnAfterGetRecord()
                begin
                    UnitPriceRound := Round("Unit Price", 0.01, '=')
                end;



            }
            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()

            begin
                SetRange("Created Date", stDate, endDate);
                SetRange("Buyer No.", Buyer);
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
                    field(stDate; stDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ShowMandatory = true;
                    }

                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ShowMandatory = true;
                    }

                    //Done By sachith On 14/02/23
                    field(Buyer; Buyer)
                    {
                        ApplicationArea = all;
                        Caption = 'Buyer';
                        ShowMandatory = true;
                        TableRelation = Customer."No.";
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

    var
        vendorRec: Record Vendor;
        comRec: Record "Company Information";
        item: Record Item;
        Inx: Integer;
        stDate: Date;
        endDate: Date;
        UnitPriceRound: Decimal;
        //Done By sachith On 14/02/23
        Buyer: Code[20];
}