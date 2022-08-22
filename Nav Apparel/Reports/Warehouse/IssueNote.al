report 50605 IssueNoteReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Issue Note';
    RDLCLayout = 'Report_Layouts/Warehouse/IssueNote.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(RoleIssuingNoteHeader; RoleIssuingNoteHeader)
        {
            DataItemTableView = sorting("RoleIssuNo.");
            column(Req_No_; "Req No.")
            { }
            column(Item_No; "Item No")
            { }
            column(Item_Name; "Item Name")
            { }
            column(OnHandQty; OnHandQty)
            { }
            column(Required_Width; "Required Width")
            { }
            column(Required_Length; "Required Length")
            { }
            column(Selected_Qty; "Selected Qty")
            { }
            column(UOM; UOM)
            { }
            column(CompLogo; comRec.Picture)
            { }


            dataitem(RoleIssuingNoteLine; RoleIssuingNoteLine)
            {
                DataItemLinkReference = RoleIssuingNoteHeader;
                DataItemLink = "RoleIssuNo." = field("RoleIssuNo.");

                DataItemTableView = sorting("RoleIssuNo.");
                column(Role_ID; "Role ID")
                { }
                column(Supplier_Batch_No_; "Supplier Batch No.")
                { }
                column(Shade; Shade)
                { }
                column(Length_Tag; "Length Tag")
                { }
                column(Length_Act; "Length Act")
                { }
                column(Width_Act; "Width Act")
                { }
                column(Width_Tag; "Width Tag")
                { }
                column(Length_Allocated; "Length Allocated")
                { }


            }
            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()

            begin
                SetRange("RoleIssuNo.", RequistionNo);
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
                    field(RequistionNo; RequistionNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Requistion No';
                        TableRelation = RoleIssuingNoteHeader."RoleIssuNo.";


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
        RequistionNo: Code[20];
        Filename: Text;
        ReturnValue: Boolean;
        Report206: Report IssueNoteReport;
        comRec: Record "Company Information";



}