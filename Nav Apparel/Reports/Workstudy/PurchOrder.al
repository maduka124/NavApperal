report 50642 PurchOrder
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'PurchOrder';
    RDLCLayout = 'Report_Layouts/Workstudy/PurchOrder.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(SystemCreatedBy; SystemCreatedBy)
            { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.")
            { }
            column(Pay_to_Contact; "Pay-to Contact")
            { }
            column(Pay_to_Address; "Pay-to Address")
            { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            { }
            column(companyName; comrec.Name)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Due_Date;"Due Date")
            { }
            column(Payment_Terms_Code;"Payment Terms Code")
            { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLinkReference = "Purchase Header";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.");
                column(Unit_of_Measure; "Unit of Measure")
                { }
                column(SizeRangeNo; SizeRangeNo)
                { }
                column(Article; Article)
                { }
                column(DimenshionWidthNo; DimenshionWidthNo)
                { }
                column(color; color)
                { }
                column(Quantity; Quantity)
                { }
                column(Line_Amount; "Line Amount")
                { }
                column(Direct_Unit_Cost; "Direct Unit Cost")
                { }
                //     column(StyleNo;StyleNo)
                // { }
                //     column()
                // { }
                //     column()
                // { }
                trigger OnAfterGetRecord()
                begin
                    ItemRec.SetRange("No.", "Purchase Line"."No.");
                    if ItemRec.FindFirst() then begin
                        SizeRangeNo := ItemRec."Size Range No.";
                        Article := ItemRec."Article No.";
                        DimenshionWidthNo := ItemRec."Dimension Width No.";
                        color := ItemRec."Color Name"
                    end;
                end;

            }
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
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
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

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var

        color: Text[50];
        SizeRangeNo: Code[20];
        Article: Code[20];
        DimenshionWidthNo: Code[20];
        ItemRec: Record Item;
        comrec: Record "Company Information";
}