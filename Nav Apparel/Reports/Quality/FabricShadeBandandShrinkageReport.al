report 50616 FabricShadeBandandShrinkage
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Fabric Shade Band & Shrinkage Summary /Shrinkage';
    RDLCLayout = 'Report_Layouts/Quality/FabricShadeBandandShrinkageReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(FabShadeBandShriHeader; FabShadeBandShriHeader)
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
            column(Fab_Twist_Avg; "Fab Twist Avg")
            { }
            column(Approved_Shade; "Approved Shade")
            { }
            column(CompLogo; comRec.Picture)
            { }

            dataitem(FabShadeBandShriLine4; FabShadeBandShriLine4)
            {
                DataItemLinkReference = FabShadeBandShriHeader;
                DataItemLink = "FabShadeNo." = field("FabShadeNo.");
                DataItemTableView = sorting("FabShadeNo.");
                column(WIDTH_Shrinkage; "WIDTH Shrinkage")
                { }
                column(WIDTH_Shrinkage_Total_Rolls; "Total Rolls")
                { }

            }
            dataitem(FabShadeBandShriLine5; FabShadeBandShriLine5)
            {
                DataItemLinkReference = FabShadeBandShriHeader;
                DataItemLink = "FabShadeNo." = field("FabShadeNo.");
                DataItemTableView = sorting("FabShadeNo.");
                column(Pattern; Pattern)
                { }
                column(WIDTH_; "WIDTH%")
                { }
                column(Length_; "Length%")
                { }

            }

            dataitem(FabShadeBandShriLine1; FabShadeBandShriLine1)
            {
                DataItemLinkReference = FabShadeBandShriHeader;
                DataItemLink = "FabShadeNo." = field("FabShadeNo.");
                DataItemTableView = sorting("FabShadeNo.");

                column(Shade; Shade)
                { }
                column(Shade_TotalRolls; "Total Rolls")
                { }
                column(Shade_TotalYDS; "Total YDS")
                { }
                // column(Width; FabShadeBandShriLine2Rec.Width)
                // { }

            }

            dataitem(FabShadeBandShriLine2; FabShadeBandShriLine2)
            {
                DataItemLinkReference = FabShadeBandShriHeader;
                DataItemLink = "FabShadeNo." = field("FabShadeNo.");
                DataItemTableView = sorting("FabShadeNo.");

                column(Width; Width)
                { }
                column(Width_TotalRolls; "Total Rolls")
                { }
                column(Width_Total_YDS; "Total YDS")
                { }
            }
            dataitem(FabShadeBandShriLine3; FabShadeBandShriLine3)
            {
                DataItemLinkReference = FabShadeBandShriHeader;
                DataItemLink = "FabShadeNo." = field("FabShadeNo.");
                DataItemTableView = sorting("FabShadeNo.");
                column(Length_Shrinkage; Shrinkage)
                { }
                column(Length_Total_Rolls; "Total Rolls")
                { }
            }
            trigger OnPreDataItem()

            begin
                SetRange("FabShadeNo.", FilterFab);
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
                    field(FilterFab; FilterFab)
                    {
                        ApplicationArea = All;
                        Caption = 'Fabric Shade No';
                        TableRelation = FabShadeBandShriHeader."FabShadeNo.";

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
        // Shade_TotalRolls_Tot: Integer;
        // FabShadeBandShriLine1Rec: Record FabShadeBandShriLine1;
        // FabShadeBandShriLine2Rec: Record FabShadeBandShriLine2;
        // FabShadeBandShriLine3Rec: Record FabShadeBandShriLine3;
        // FabShadeBandShriLine4Rec: Record FabShadeBandShriLine4;
        FilterFab: code[20];
        comRec: Record "Company Information";
}