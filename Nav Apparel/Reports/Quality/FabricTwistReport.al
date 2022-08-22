report 50618 FabricTwistReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Fabric Twist/Skewness Test Report';
    RDLCLayout = 'Report_Layouts/Quality/FabricTwistReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(FabTwistHeader; FabTwistHeader)
        {
            DataItemTableView = sorting("FabTwistNo.");

            column(FabTwistNo_; "FabTwistNo.")
            { }
            column(Buyer_Name_; "Buyer Name.")
            { }
            column(Style_Name; "Style Name")
            { }
            column(GRN; GRN)
            { }
            column(PO_No_; "PO No.")
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
            column(Avg; Avg)
            { }
            column(CompLogo; comRec.Picture)
            { }
            // column()
            // {}

            dataitem(FabTwistLine; FabTwistLine)
            {
                DataItemLinkReference = FabTwistHeader;
                DataItemLink = "FabTwistNo." = field("FabTwistNo.");
                DataItemTableView = sorting("FabTwistNo.");

                column(Line_No_; "Line No.")
                { }
                column(Color_Name_Line; "Color Name")
                { }
                column(NoofRolls; NoofRolls)
                { }
                column(Qty; Qty)
                { }
                column(BW_Twist_CM; "BW Twist CM")
                { }
                column(BW_Width_CM; "BW Width CM")
                { }
                column(BW_Twist_; "BW Twist%")
                { }
                column(AW_Twist_CM; "AW Twist CM")
                { }
                column(AW_Width_CM; "AW Width CM")
                { }
                column(AW_Twist_; "AW Twist%")
                { }
                column(RollID; RollID)
                { }
                //         column()
                // { }
            }

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()

            begin
                SetRange("FabTwistNo.", FabTwistNo);
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
                    field(FabTwistNo; FabTwistNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Fabric Twist No';
                        TableRelation = FabTwistHeader."FabTwistNo.";

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
        FabTwistNo: Code[30];
        comRec: Record "Company Information";
}