report 50606 FabricRequisitionNote
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Fabric Requisition Note Report';
    RDLCLayout = 'Report_Layouts/Cutting/FabricRequisitionNote.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(FabricRequsition; FabricRequsition)
        {
            DataItemTableView = sorting("FabReqNo.");
            column(Style_No_; "Style No.")
            { }
            column(Colour_Name; "Colour Name")
            { }
            column(Group_ID; "Group ID")
            { }
            column(Component_Group_Code; "Component Group Code")
            { }
            column(Marker_Name; "Marker Name")
            { }
            column(Cut_No; "Cut No")
            { }
            column(Marker_Width; "Marker Width")
            { }
            column(UOM; UOM)
            { }
            column(Table_No_; "Table No.")
            { }
            column(Required_Length; "Required Length")
            { }
            column(FabReqNo_; "FabReqNo.")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Style_Name; "Style Name")
            { }
            column(Location_Name; "Location Name")
            { }

            dataitem(FabricRequsitionLine; FabricRequsitionLine)
            {
                DataItemLinkReference = FabricRequsition;
                DataItemLink = "FabReqNo." = field("FabReqNo.");
                DataItemTableView = sorting("FabReqNo.");
                column(Layering_Start_Date_Time; "Layering Start Date/Time")
                { }
                column(Cut_Start_Date_Time; "Cut Start Date/Time")
                { }
                column(ItemName; ItemRec."Item No.")
                { }
                column(Item_No_; itemNo)
                { }
                column(Item_Name; itemName)
                { }

                trigger OnAfterGetRecord()
                var
                begin


                    ItemRec.Reset();
                    ItemRec.SetRange("Style No.", FabricRequsition."Style No.");
                    ItemRec.SetRange("Colour No", FabricRequsition."Colour No");
                    if ItemRec.FindFirst() then begin
                        itemNo := ItemRec."Item No.";
                        itemName := ItemRec."Item Name";
                    end;
                end;


            }
            trigger OnPreDataItem()

            begin
                SetRange("FabReqNo.", RequistionNo);
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
                group("Fabric Requisition Note Report")
                {
                    Caption = 'Filter By';
                    field(RequistionNo; RequistionNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Requistion Number';
                        TableRelation = FabricRequsition."FabReqNo.";
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

        RequistionNo: Code[20];

        ItemRec: Record FabricMapping;
        itemName: Text;
        itemNo: Code[20];
        comRec: Record "Company Information";

}