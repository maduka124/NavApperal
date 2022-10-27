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
            column(WIDTH_Shrinkage; widthShrinkage)
            { }
            column(WIDTH_Shrinkage_Total_Rolls; WidthTotal)
            { }
            column(Pattern; Pattern)
            { }
            column(WIDTH_; Width)
            { }
            column(Length_; Length)
            { }
            column(Shade; Shade)
            { }
            column(Shade_TotalRolls; TotalRolls)
            { }
            column(Shade_TotalYDS; TotalYDS)
            { }
            column(Width; WidthLine2)
            { }
            column(Width_TotalRolls; TotalRollsLine2)
            { }
            column(Width_Total_YDS; TotalYDSLine2)
            { }
            column(Length_Shrinkage; LengthShrinkage)
            { }
            column(Length_Total_Rolls; LengthTotalRolls)
            { }


            // dataitem(FabShadeBandShriLine4; FabShadeBandShriLine4)
            // {
            //     DataItemLinkReference = FabShadeBandShriHeader;
            //     DataItemLink = "FabShadeNo." = field("FabShadeNo.");
            //     DataItemTableView = sorting("FabShadeNo.");
            //     column(WIDTH_Shrinkage; "WIDTH Shrinkage")
            //     { }
            //     column(WIDTH_Shrinkage_Total_Rolls; "Total Rolls")
            //     { }

            // }
            // dataitem(FabShadeBandShriLine5; FabShadeBandShriLine5)
            // {
            //     DataItemLinkReference = FabShadeBandShriHeader;
            //     DataItemLink = "FabShadeNo." = field("FabShadeNo.");
            //     DataItemTableView = sorting("FabShadeNo.");
            //     column(Pattern; Pattern)
            //     { }
            //     column(WIDTH_; "WIDTH%")
            //     { }
            //     column(Length_; "Length%")
            //     { }

            // }

            // dataitem(FabShadeBandShriLine1; FabShadeBandShriLine1)
            // {
            //     DataItemLinkReference = FabShadeBandShriHeader;
            //     DataItemLink = "FabShadeNo." = field("FabShadeNo.");
            //     DataItemTableView = sorting("FabShadeNo.");

            //     column(Shade; Shade)
            //     { }
            //     column(Shade_TotalRolls; "Total Rolls")
            //     { }
            //     column(Shade_TotalYDS; "Total YDS")
            //     { }
            //     // column(Width; FabShadeBandShriLine2Rec.Width)
            //     // { }

            // }

            // dataitem(FabShadeBandShriLine2; FabShadeBandShriLine2)
            // {
            //     DataItemLinkReference = FabShadeBandShriHeader;
            //     DataItemLink = "FabShadeNo." = field("FabShadeNo.");
            //     DataItemTableView = sorting("FabShadeNo.");

            //     column(Width; Width)
            //     { }
            //     column(Width_TotalRolls; "Total Rolls")
            //     { }
            //     column(Width_Total_YDS; "Total YDS")
            //     { }
            // }
            // dataitem(FabShadeBandShriLine3; FabShadeBandShriLine3)
            // {
            //     DataItemLinkReference = FabShadeBandShriHeader;
            //     DataItemLink = "FabShadeNo." = field("FabShadeNo.");
            //     DataItemTableView = sorting("FabShadeNo.");
            //     column(Length_Shrinkage; Shrinkage)
            //     { }
            //     column(Length_Total_Rolls; "Total Rolls")
            //     { }
            // }
            trigger OnPreDataItem()

            begin
                SetRange("FabShadeNo.", FilterFab);
            end;

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                FabShadeBandShriLine4Rec.Reset();
                FabShadeBandShriLine4Rec.SetRange("FabShadeNo.", "FabShadeNo.");
                if FabShadeBandShriLine4Rec.FindFirst() then begin
                    widthShrinkage := FabShadeBandShriLine4Rec."WIDTH Shrinkage";
                    WidthTotal := FabShadeBandShriLine4Rec."Total Rolls";
                end;

                FabShadebandSriline5Rec.Reset();
                FabShadebandSriline5Rec.SetRange("FabShadeNo.", "FabShadeNo.");
                if FabShadebandSriline5Rec.FindFirst() then begin
                    Pattern := FabShadebandSriline5Rec.Pattern;
                    Length := FabShadebandSriline5Rec."Length%";
                    Width := FabShadebandSriline5Rec."WIDTH%";
                end;
                FabShadeBandShriLine1Rec.Reset();
                FabShadeBandShriLine1Rec.SetRange("FabShadeNo.", "FabShadeNo.");
                if FabShadeBandShriLine1Rec.FindFirst() then begin
                    Shade := FabShadeBandShriLine1Rec.Shade;
                    TotalRolls := FabShadeBandShriLine1Rec."Total Rolls";
                    TotalYDS := FabShadeBandShriLine1Rec."Total YDS";
                end;
                FabShadeBandShriLine2Rec.Reset();
                FabShadeBandShriLine2Rec.SetRange("FabShadeNo.", "FabShadeNo.");
                if FabShadeBandShriLine2Rec.FindFirst() then begin
                    WidthLine2 := FabShadeBandShriLine2Rec.Width;
                    TotalRollsLine2 := FabShadeBandShriLine2Rec."Total Rolls";
                    TotalYDSLine2 := FabShadeBandShriLine2Rec."Total YDS";
                end;

                FabShadeBandShriLine3Rec.Reset();
                FabShadeBandShriLine3Rec.SetRange("FabShadeNo.", "FabShadeNo.");
                if FabShadeBandShriLine3Rec.FindFirst() then begin
                    LengthShrinkage := FabShadeBandShriLine3Rec.Shrinkage;
                    LengthTotalRolls := FabShadeBandShriLine3Rec."Total Rolls";
                end;
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
        Shade_TotalRolls_Tot: Integer;
        FabShadeBandShriLine1Rec: Record FabShadeBandShriLine1;
        FabShadeBandShriLine2Rec: Record FabShadeBandShriLine2;
        FabShadeBandShriLine3Rec: Record FabShadeBandShriLine3;
        FabShadeBandShriLine4Rec: Record FabShadeBandShriLine4;
        FabShadebandSriline5Rec: Record FabShadeBandShriLine5;
        FilterFab: code[20];
        comRec: Record "Company Information";

        widthShrinkage: Decimal;
        WidthTotal: Integer;
        Pattern: Code[20];
        Width: Text[50];
        Length: Text[50];
        Shade: Code[20];
        TotalRolls: Integer;
        TotalYDS: Decimal;
        WidthLine2: Decimal;
        TotalRollsLine2: Integer;
        TotalYDSLine2: Decimal;
        LengthShrinkage: Decimal;
        LengthTotalRolls: Integer;

}