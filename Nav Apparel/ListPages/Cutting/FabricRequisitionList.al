page 50621 "FabricRequisitionList"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FabricRequsition;
    CardPageId = "Fabric Requisition Card";
    SourceTableView = sorting("FabReqNo.") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(FabReqNo; "FabReqNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Requsition No';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Colour Name"; "Colour Name")
                {
                    ApplicationArea = All;
                    Caption = 'Colour';
                }

                field("Group ID"; "Group ID")
                {
                    ApplicationArea = All;
                }

                field("Component Group Code"; "Component Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Component Group';
                }

                field("Marker Name"; "Marker Name")
                {
                    ApplicationArea = All;
                    Caption = 'Marker';
                }

                field("Cut No"; "Cut No")
                {
                    ApplicationArea = All;
                }

                field("Marker Width"; "Marker Width")
                {
                    ApplicationArea = All;
                }

                field(UOM; UOM)
                {
                    ApplicationArea = All;
                }

                field("Required Length"; "Required Length")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        FabricRequLine: Record FabricRequsitionLine;
        LaySheetRec: Record LaySheetHeader;
        RoleIssueRec: Record RoleIssuingNoteHeader;
    begin

        //Check in the laysheet
        LaySheetRec.Reset();
        LaySheetRec.SetRange("FabReqNo.", "FabReqNo.");

        if LaySheetRec.FindSet() then begin
            Message('Cannot delete. Fabric Requsition No already used in the Laysheet No : %1', LaySheetRec."LaySheetNo.");
            exit(false);
        end;


        //Check in the Role Issuing
        RoleIssueRec.Reset();
        RoleIssueRec.SetRange("Req No.", "FabReqNo.");

        if RoleIssueRec.FindSet() then begin
            Message('Cannot delete. Fabric Requsition No already used in the Role Issuing No : %1', RoleIssueRec."RoleIssuNo.");
            exit(false);
        end;


        FabricRequLine.Reset();
        FabricRequLine.SetRange("FabReqNo.", "FabReqNo.");
        if FabricRequLine.FindSet() then
            FabricRequLine.DeleteAll();
    end;
}