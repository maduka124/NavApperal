report 50619 FabricShadeReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Fabric Shade Report';
    RDLCLayout = 'Report_Layouts/Quality/FabricShadeReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(FabShadeHeader; FabShadeHeader)
        {
            DataItemTableView = sorting("FabShadeNo.");
            column(FabShadeNo_; "FabShadeNo.")
            { }
            column(Buyer_Name_; "Buyer Name.")
            { }
            column(Style_Name; "Style Name")
            { }
            column(PO_No_; "PO No.")
            { }
            column(GRN; GRN)
            { }
            column(Color_Name; "Color Name")
            { }
            column(Item_Name; "Item Name")
            { }
            column(Fabric_Code; "Fabric Code")
            { }
            column(Composition; Composition)
            { }
            column(Construction; Construction)
            { }
            column(No_of_Roll; "No of Roll")
            { }

            column(CompLogo; comRec.Picture)
            { }
            // column()
            // {}
            dataitem(FabShadeLine3; FabShadeLine3)
            {
                DataItemLinkReference = FabShadeHeader;
                DataItemLink = "FabShadeNo." = field("FabShadeNo.");

                DataItemTableView = sorting("FabShadeNo.");
                column(Pattern; Pattern)
                { }
                column(Total_YDSLine3; "Total YDS")
                { }
                column(Total_RollsLine3; "Total Rolls")
                { }

            }
            dataitem(FabShadeLine; FabShadeLine1)
            {
                DataItemLinkReference = FabShadeHeader;
                DataItemLink = "FabShadeNo." = field("FabShadeNo.");

                DataItemTableView = sorting("FabShadeNo.");
                column(Roll_No; "Roll No")
                { }
                column(YDS; YDS)
                { }
                column(Shade; Shade)
                { }
                column(PTTN_GRP; "PTTN GRP")
                { }
            }
            dataitem(FabShadeLine2; FabShadeLine2)
            {
                DataItemLinkReference = FabShadeHeader;
                DataItemLink = "FabShadeNo." = field("FabShadeNo.");

                DataItemTableView = sorting("FabShadeNo.");
                column(ShadeLine2; Shade)
                { }
                column(Total_Rolls; "Total Rolls")
                { }
                column(Total_YDS; "Total YDS")
                { }
                // column()
                // { }
            }

            trigger OnPreDataItem()

            begin
                SetRange("FabShadeNo.", FilterFabNo);
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
                    field(FilterFabNo; FilterFabNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Fabric Shade No';
                        TableRelation = FabShadeHeader."FabShadeNo.";

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
        FilterFabNo: Code[30];
        comRec: Record "Company Information";
}