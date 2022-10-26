page 50601 "Cut Creation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = CutCreation;
    CardPageId = "Cut Creation Card";
    SourceTableView = sorting(CutCreNo) order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(CutCreNo; CutCreNo)
                {
                    ApplicationArea = All;
                    Caption = 'Cut Creation No';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Colour Name"; "Colour Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                }

                field("Marker Name"; "Marker Name")
                {
                    ApplicationArea = All;
                    Caption = 'Marker';
                }

                field("Group ID"; "Group ID")
                {
                    ApplicationArea = All;
                }

                field("Component Group"; "Component Group")
                {
                    ApplicationArea = All;
                }

                field("Ply Height"; "Ply Height")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        CurCreLineRec: Record CutCreationLine;
        FabRec: Record FabricRequsition;
        TableRec: Record TableCreartionLine;
        LaySheetRec: Record LaySheetHeader;
    begin

        //Check fabric requsition
        CurCreLineRec.Reset();
        CurCreLineRec.SetRange("CutCreNo.", CutCreNo);
        CurCreLineRec.SetFilter("Cut No", '<>%1', 0);

        if CurCreLineRec.FindSet() then begin
            repeat

                //Check for cut creation
                FabRec.Reset();
                FabRec.SetRange("Marker Name", "Marker Name");
                FabRec.SetRange("Style No.", "Style No.");
                FabRec.SetRange("Colour No", "Colour No");
                FabRec.SetRange("Group ID", "Group ID");
                FabRec.SetRange("Component Group Code", "Component Group");
                FabRec.SetRange("Marker Name", "Marker Name");
                FabRec.SetRange("Cut No", CurCreLineRec."Cut No");

                if FabRec.FindSet() then begin
                    Message('Cannot delete. Cut No already used in the Fabric Requsition No : %1', FabRec."FabReqNo.");
                    exit(false);
                end;
            until CurCreLineRec.Next() = 0;
        end;


        //Check Table creation
        CurCreLineRec.Reset();
        CurCreLineRec.SetRange("CutCreNo.", CutCreNo);
        CurCreLineRec.SetFilter("Cut No", '<>%1', 0);

        if CurCreLineRec.FindSet() then begin
            repeat

                //Check for cut creation
                TableRec.Reset();
                TableRec.SetRange("Marker Name", "Marker Name");
                TableRec.SetRange("Style No.", "Style No.");
                TableRec.SetRange("Colour No", "Colour No");
                TableRec.SetRange("Group ID", "Group ID");
                TableRec.SetRange("Component Group", "Component Group");
                TableRec.SetRange("Marker Name", "Marker Name");
                TableRec.SetRange("Cut No", CurCreLineRec."Cut No");

                if TableRec.FindSet() then begin
                    Message('Cannot delete. Cut No already used in the Cutting Table Creation : %1', TableRec."TableCreNo.");
                    exit(false);
                end;
            until CurCreLineRec.Next() = 0;
        end;


        //Check LaySheet
        CurCreLineRec.Reset();
        CurCreLineRec.SetRange("CutCreNo.", CutCreNo);
        CurCreLineRec.SetFilter("Record Type", '=%1', 'R');

        if CurCreLineRec.FindSet() then begin
            repeat

                //Check for cut creation
                LaySheetRec.Reset();
                LaySheetRec.SetRange("Marker Name", "Marker Name");
                LaySheetRec.SetRange("Style No.", "Style No.");
                LaySheetRec.SetRange("Color No.", "Colour No");
                LaySheetRec.SetRange("Group ID", "Group ID");
                LaySheetRec.SetRange("Component Group Code", "Component Group");
                LaySheetRec.SetRange("Cut No.", CurCreLineRec."Cut No");

                if LaySheetRec.FindSet() then begin
                    Message('Cannot delete. Cut No already used in the Laysheet No : %1', LaySheetRec."LaySheetNo.");
                    exit(false);
                end;
            until CurCreLineRec.Next() = 0;
        end;


        CurCreLineRec.Reset();
        CurCreLineRec.SetRange("CutCreNo.", CutCreNo);
        if CurCreLineRec.FindSet() then
            CurCreLineRec.DeleteAll();
    end;
}