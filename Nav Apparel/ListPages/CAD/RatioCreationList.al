page 50605 "Ratio Creation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = RatioCreation;
    CardPageId = "Ratio Creation Card";
    SourceTableView = sorting(RatioCreNo) order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(RatioCreNo; RatioCreNo)
                {
                    ApplicationArea = All;
                    Caption = 'Ratio Creation No';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Group ID"; "Group ID")
                {
                    ApplicationArea = All;
                }
                field(UOM; UOM)
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        CurCreLineRec: Record CutCreationLine;
        RatioLineRec: Record RatioCreationLine;
        FabRec: Record FabricRequsition;
    begin

        //Get Ratio lines
        RatioLineRec.Reset();
        RatioLineRec.SetRange(RatioCreNo, RatioCreNo);
        RatioLineRec.SetFilter("Record Type", '=%1', 'R');

        if RatioLineRec.FindSet() then begin
            repeat

                //Check for cut creation
                CurCreLineRec.Reset();
                CurCreLineRec.SetRange("Marker Name", RatioLineRec."Marker Name");
                CurCreLineRec.SetRange("Style No.", RatioLineRec."Style No.");
                CurCreLineRec.SetRange("Colour No", RatioLineRec."Colour No");
                CurCreLineRec.SetRange("Group ID", RatioLineRec."Group ID");
                CurCreLineRec.SetRange("Component Group Code", RatioLineRec."Component Group Code");

                if CurCreLineRec.FindSet() then begin
                    Message('Cannot delete. Cut creation already created for this Marker %1', RatioLineRec."Marker Name");
                    exit(false);
                end;

                //Check for Fabric Requsition
                FabRec.Reset();
                FabRec.SetRange("Marker Name", RatioLineRec."Marker Name");
                FabRec.SetRange("Style No.", RatioLineRec."Style No.");
                FabRec.SetRange("Group ID", RatioLineRec."Group ID");
                FabRec.SetRange("Component Group Code", RatioLineRec."Component Group Code");

                if FabRec.FindSet() then begin
                    Message('Cannot delete. Fabric requsition has created for this Ratio');
                    exit(false);
                end;

            until RatioLineRec.Next() = 0;
        end;

        //Delete all Ratio lines
        RatioLineRec.Reset();
        RatioLineRec.SetRange(RatioCreNo, RatioCreNo);
        if RatioLineRec.FindSet() then
            RatioLineRec.DeleteAll();
    end;
}