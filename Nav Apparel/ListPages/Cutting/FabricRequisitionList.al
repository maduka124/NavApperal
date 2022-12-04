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
                field(FabReqNo; Rec."FabReqNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Requsition No';
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Colour Name"; Rec."Colour Name")
                {
                    ApplicationArea = All;
                    Caption = 'Colour';
                }

                field("Group ID"; Rec."Group ID")
                {
                    ApplicationArea = All;
                }

                field("Component Group Code"; Rec."Component Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Component Group';
                }

                field("Marker Name"; Rec."Marker Name")
                {
                    ApplicationArea = All;
                    Caption = 'Marker';
                }

                field("Cut No"; Rec."Cut No")
                {
                    ApplicationArea = All;
                }

                field("Marker Width"; Rec."Marker Width")
                {
                    ApplicationArea = All;
                }

                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                }

                field("Required Length"; Rec."Required Length")
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
        LaySheetRec.SetRange("FabReqNo.", Rec."FabReqNo.");

        if LaySheetRec.FindSet() then begin
            Message('Cannot delete. Fabric Requsition No already used in the Laysheet No : %1', LaySheetRec."LaySheetNo.");
            exit(false);
        end;


        //Check in the Role Issuing
        RoleIssueRec.Reset();
        RoleIssueRec.SetRange("Req No.", Rec."FabReqNo.");

        if RoleIssueRec.FindSet() then begin
            Message('Cannot delete. Fabric Requsition No already used in the Role Issuing No : %1', RoleIssueRec."RoleIssuNo.");
            exit(false);
        end;


        FabricRequLine.Reset();
        FabricRequLine.SetRange("FabReqNo.", Rec."FabReqNo.");
        if FabricRequLine.FindSet() then
            FabricRequLine.DeleteAll();
    end;
}