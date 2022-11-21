report 50648 GrnFullReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'GRN Report';
    RDLCLayout = 'Report_Layouts/Merchandizing/GRN_ReportFull.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column("GRN_No"; "No.")
            { }
            column(Pay_to_Name; "Pay-to Name")
            { }
            column(Pay_to_Address; "Pay-to Address")
            { }
            column(Posting_Date; "Posting Date")
            { }
            column(Document_Date; "Document Date")
            { }
            column(country; "Pay-to City")
            { }
            column(PONo; "Order No.")
            { }
            column(CompLogo; comRec.Picture)
            { }

            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLinkReference = "Purch. Rcpt. Header";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.");
                RequestFilterFields = "No.";

                column(Order_No_; PONo)
                { }
                column(ItemNo; "No.")
                { }
                column(Description; Description)
                { }
                column(Location_Code; "Location Code")
                { }
                column(Quantity; Quantity)
                { }
                column(Unit_of_Measure; "Unit of Measure")
                { }
                column(StyleName; StyleName)
                { }
                column(Lot; Lot)
                { }

                trigger OnPreDataItem()

                begin
                    // SetRange("No.", ItemCode);

                end;
            }
            trigger OnPreDataItem()
            begin
                // SetRange("No.", CodeNo);
                // SetRange("Posting Date", stDate, endDate);

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
                    // field(CodeNo; CodeNo)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'GRN No';
                    //     TableRelation = "Purch. Rcpt. Header"."No.";

                    // }
                    // field(ItemCode; ItemCode)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Item No';
                    //     TableRelation = Item."No.";

                    // }
                    // field(stDate; stDate)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Start Date';

                    // }
                    // field(endDate; endDate)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'End Date';

                    // }

                }
                // date,item,vendor
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

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        ItemCode: Code[20];
        stDate: Date;
        endDate: Date;
        QT: Decimal;
        myInt: Integer;
        CodeNo: Code[50];
        comRec: Record "Company Information";

}