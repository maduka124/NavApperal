report 50620 FabricShadeBandShrinkageReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Fabrics Shade Band & Shrinkage Test Report';
    RDLCLayout = 'Report_Layouts/Quality/FabricShadeBandShrinkageTestReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(FabricProceHeader; FabricProceHeader)
        {
            DataItemTableView = sorting("FabricProceNo.");
            column(FabricProceNo_; "FabricProceNo.")
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
            column(No_of_Roll; "No of Roll")
            { }
            column(CompLogo; comRec.Picture)
            { }

            dataitem(FabricProceLine; FabricProceLine)
            {
                DataItemLinkReference = FabricProceHeader;
                DataItemLink = "FabricProceNo." = field("FabricProceNo.");
                DataItemTableView = sorting("FabricProceNo.");
                column(Roll_No; "Roll No")
                { }
                column(TagLength; YDS)
                { }
                column(Shade; Shade)
                { }
                column(TagWidth; Width)
                { }
                column(Act__Width; "Act. Width")
                { }
                column(MFShade; MFShade)
                { }
                column(BW__Length; "BW. Length")
                { }
                column(BW__Width; "BW. Width")
                { }
                column(AW__Length; "AW. Length")
                { }
                column(AW__Width; "AW. Width")
                { }
                column(Length_; "Length%")
                { }
                column(WiDth_; "WiDth%")
                { }
                column(PTTN_GRP; "PTTN GRP")
                { }
                column(Status; Status)
                { }
                //     column()
                // { }
            }
            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()

            begin
                SetRange("FabricProceNo.", FabShadeFilter);
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
                    field(FabShadeFilter; FabShadeFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Fabric Proc No';
                        TableRelation = FabricProceHeader."FabricProceNo.";

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
        FabShadeFilter: Code[30];
        comRec: Record "Company Information";
}