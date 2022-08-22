report 50617 FabricShrinkageTestReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Fabric Shrinkage Test Report';
    RDLCLayout = 'Report_Layouts/Quality/FabricShrinkageTestReport.rdl';
DefaultLayout = RDLC; 

    dataset
    {
        dataitem(FabShrinkageTestHeader; FabShrinkageTestHeader)
        {
             DataItemTableView = sorting("FabShrTestNo.");
            column(FabShrTestNo_; "FabShrTestNo.")
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

            dataitem(FabShrinkageTestLine; FabShrinkageTestLine)
            {
                DataItemLinkReference = FabShrinkageTestHeader;
                DataItemLink = "FabShrTestNo." = field("FabShrTestNo.");
                 DataItemTableView = sorting("FabShrTestNo.");
                column(Pattern_Code; "Pattern Code")
                { }
                column(Pattern_Name; "Pattern Name")
                { }
                column(SHRINKAGE; SHRINKAGE)
                { }
                column(Length_; "Length%")
                { }
                column(PTN_VARI_Length; "PTN VARI Length")
                { }
                column(WiDth_; "WiDth%")
                { }
                column(PTN_VARI_WiDth; "PTN VARI WiDth")
                { }
                column(Avg_Pattern__Length; "Avg Pattern% Length")
                { }
                column(Avg_Pattern__Width; "Avg Pattern% Width")
                { }
            }
             trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;
            trigger OnPreDataItem()
            
            begin
                SetRange("FabShrTestNo.",Filterfab);
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
                    field(Filterfab;Filterfab)
                    {
                        ApplicationArea = All;
                        Caption='FabShrTestNo';
                        TableRelation=FabShrinkageTestHeader."FabShrTestNo.";

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
        Filterfab:code[20];
        comRec: Record "Company Information";
}