page 51361 MachineRequestList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = MachineRequestListTble;
    Caption = 'Style Wise Machine Requerment';
    CardPageId = StyleWiseMachineReqCard;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                }

                field(Line; Rec.Line)
                {
                    ApplicationArea = all;
                }

                field(Buyer; Rec.Buyer)
                {
                    ApplicationArea = All;
                }

                field(Brand; Rec.Brand)
                {
                    ApplicationArea = All;
                }

                field(Factory; Rec.Factory)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        ManningLevlHeaderRec: Record "Maning Level";
        MachineReqRec: Record MachineRequestListTble;
        StyleMasterRec: Record "Style Master";
        StylePORec: Record "Style Master PO";
        ManingLevelsLineRec: Record "Maning Levels Line";
        ManingLevelsLine2Rec: Record "Maning Levels Line";
        NavAppPlanLineRec: Record "NavApp Planning Lines";
        StyleWiseMachineLineRec: Record StyleWiseMachineLine;
        LineNo: Integer;
        LineNo2: Integer;
        MachineCodeGB: Code[20];
        MachineCount: Integer;
    begin

        LineNo := 0;

        MachineReqRec.Reset();
        if MachineReqRec.FindSet() then
            MachineReqRec.DeleteAll();

        StyleWiseMachineLineRec.Reset();
        if StyleWiseMachineLineRec.findset() then
            StyleWiseMachineLineRec.DeleteAll();

        ManningLevlHeaderRec.Reset();
        ManningLevlHeaderRec.SetCurrentKey("Style No.");
        ManningLevlHeaderRec.Ascending(true);

        if ManningLevlHeaderRec.FindSet() then begin
            repeat
                if ManningLevlHeaderRec."Style Name" <> '' then begin
                    if ManningLevlHeaderRec."Line No." <> '' then begin

                        MachineReqRec.Reset();
                        MachineReqRec.SetRange("Style No", ManningLevlHeaderRec."Style No.");
                        MachineReqRec.SetRange(Line, ManningLevlHeaderRec."Line No.");

                        if not MachineReqRec.FindSet() then begin

                            LineNo += 1;

                            MachineReqRec.Init();
                            // MachineReqRec.N := LineNo;
                            MachineReqRec.No := ManningLevlHeaderRec."No.";
                            MachineReqRec."Style No" := ManningLevlHeaderRec."Style No.";
                            MachineReqRec."Style Name" := ManningLevlHeaderRec."Style Name";
                            MachineReqRec.Line := ManningLevlHeaderRec."Line No.";

                            StyleMasterRec.Reset();
                            StyleMasterRec.SetRange("No.", ManningLevlHeaderRec."Style No.");

                            if StyleMasterRec.FindSet() then begin
                                MachineReqRec.Buyer := StyleMasterRec."Buyer Name";
                                MachineReqRec."Order Qty" := StyleMasterRec."Order Qty";
                                MachineReqRec.Brand := StyleMasterRec."Brand Name";
                                MachineReqRec."Garment Type" := StyleMasterRec."Garment Type Name";
                            end;

                            NavAppPlanLineRec.Reset();
                            NavAppPlanLineRec.SetRange("Style No.", ManningLevlHeaderRec."Style No.");
                            NavAppPlanLineRec.SetRange("Resource No.", ManningLevlHeaderRec."Line No.");

                            if NavAppPlanLineRec.FindLast() then
                                MachineReqRec.Factory := NavAppPlanLineRec.Factory;

                            ManingLevelsLineRec.Reset();
                            ManingLevelsLineRec.SetRange("No.", ManningLevlHeaderRec."No.");
                            ManingLevelsLineRec.SetCurrentKey("Machine No.");
                            ManingLevelsLineRec.Ascending(true);

                            if ManingLevelsLineRec.FindSet() then begin
                                repeat
                                    if MachineCodeGB <> ManingLevelsLineRec."Machine No." then begin
                                        LineNo2 += 1;
                                        StyleWiseMachineLineRec.Init();
                                        StyleWiseMachineLineRec.No := ManningLevlHeaderRec."No.";
                                        StyleWiseMachineLineRec."Line No" := LineNo2;
                                        StyleWiseMachineLineRec."Machine No" := ManingLevelsLineRec."Machine No.";
                                        StyleWiseMachineLineRec."Machine Name" := ManingLevelsLineRec."Machine Name";
                                        MachineCodeGB := ManingLevelsLineRec."Machine No.";

                                        // ManingLevelsLine2Rec.Reset();
                                        ManingLevelsLine2Rec.SetRange("No.", ManningLevlHeaderRec."No.");
                                        ManingLevelsLine2Rec.SetRange("Machine No.", MachineCodeGB);

                                        if ManingLevelsLine2Rec.FindSet() then begin
                                            repeat
                                                MachineCount := ManingLevelsLine2Rec.Count;
                                            until ManingLevelsLine2Rec.Next() = 0;
                                            StyleWiseMachineLineRec."Machine Qty" := MachineCount;
                                        end;
                                        StyleWiseMachineLineRec.Insert();
                                    end;
                                // end;
                                until ManingLevelsLineRec.Next() = 0;
                            end;
                            MachineReqRec.Insert();
                        end;
                    end;
                end;
            until ManningLevlHeaderRec.Next() = 0;
        end;
    end;
}