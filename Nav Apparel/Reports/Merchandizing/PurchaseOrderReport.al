report 71012806 PurchaseOrderReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Purchase Order Report';
    RDLCLayout = 'Report_Layouts/Merchandizing/PurchaseOrderReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("No.");

            column(PoNo_; "No.")
            { }

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLinkReference = "Purchase Header";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.");
                column(No_; "No.")
                { }
                column(Description; Description)
                { }
                column(SizeRangeNo; SizeRangeNo)
                { }
                column(Article; Article)
                { }
                column(DimenshionWidthNo; DimenshionWidthNo)
                { }
                column(VendorName; VendorName)
                { }
                column(color; color)
                { }
                column(Quantity; Quantity)
                { }
                column(Unit_of_Measure; "Unit of Measure")
                { }
                column(Line_Amount; "Line Amount")
                { }
                column(Direct_Unit_Cost; "Direct Unit Cost")
                { }
                column(Address; Address)
                { }
                column(PhoneNo; PhoneNo)
                { }
                column(Order_Date; "Order Date")
                { }
                column(City; City)
                { }
                column(companyName; comrec.Name)
                { }
                column(companuCity; comrec.City)
                { }
                column(companyAddres; comrec.Address)
                { }
                column(companyPhone; comrec."Phone No.")
                { }
                column(CompLogo; comRec.Picture)
                { }
                // column(SystemCreatedBy; SystemCreatedBy)
                // { }
                // column()
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
                    VendorRec.SetRange("No.", "Purchase Header"."Buy-from Vendor No.");
                    if VendorRec.FindFirst() then begin
                        VendorName := VendorRec.Name;
                        Address := VendorRec.Address;
                        PhoneNo := VendorRec."Phone No.";
                        City := VendorRec.City;
                    end;
                    comrec.get;
                    //  comRec.Get;
                    comRec.CalcFields(Picture);
                end;
            }
            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()

            begin
                SetRange("No.", FilterNo);
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
                    Caption='Filter By';
                    field(FilterNo; FilterNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Purchase No';
                        TableRelation = "Purchase Header"."No.";

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
        VendorRec: Record Vendor;
        SizeRangeNo: Code[20];
        Article: Code[20];
        DimenshionWidthNo: Code[20];
        VendorName: Text[50];
        color: Text[50];
        Address: Text[50];
        PhoneNo: Text[30];
        City: Text[30];
        comrec: Record "Company Information";
        FilterNo: Code[30];
}