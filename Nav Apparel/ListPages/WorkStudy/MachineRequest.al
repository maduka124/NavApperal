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
        // NavAppPlanLineRec: Record "NavApp Planning Lines";
        NavAppProdDetailRec: Record "NavApp Prod Plans Details";
        StyleWiseMachineLineRec: Record StyleWiseMachineLine;
        LineNo: Integer;
        LineNo2: Integer;
        MachineCodeGB: Code[20];
        MachineCount: Decimal;
        TotMachine: Decimal;
        Workcenter: Text[100];
    begin
        LineNo := 0;
        TotMachine := 0;

        MachineReqRec.Reset();
        if MachineReqRec.FindSet() then
            MachineReqRec.DeleteAll();

        // StyleWiseMachineLineRec.Reset();
        // if StyleWiseMachineLineRec.findset() then
        //     StyleWiseMachineLineRec.DeleteAll();

        ManningLevlHeaderRec.Reset();
        ManningLevlHeaderRec.SetCurrentKey("Style No.");
        ManningLevlHeaderRec.Ascending(true);
        if ManningLevlHeaderRec.FindSet() then begin
            repeat

                TotMachine := 0;
                if ManningLevlHeaderRec."Style Name" <> '' then begin
                    if ManningLevlHeaderRec."Line No." <> '' then begin

                        MachineReqRec.Reset();
                        MachineReqRec.SetRange("Style No", ManningLevlHeaderRec."Style No.");
                        MachineReqRec.SetRange(Line, ManningLevlHeaderRec."Line No.");
                        if not MachineReqRec.FindSet() then begin

                            LineNo += 1;

                            MachineReqRec.Init();
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

                            NavAppProdDetailRec.Reset();
                            NavAppProdDetailRec.SetRange("Style No.", ManningLevlHeaderRec."Style No.");
                            NavAppProdDetailRec.SetRange("Resource No.", ManningLevlHeaderRec."Line No.");
                            if NavAppProdDetailRec.FindLast() then
                                MachineReqRec.Factory := NavAppProdDetailRec."Factory No.";

                            // ManingLevelsLineRec.Reset();
                            // ManingLevelsLineRec.SetRange("No.", ManningLevlHeaderRec."No.");
                            // ManingLevelsLineRec.SetCurrentKey("Machine No.");
                            // ManingLevelsLineRec.Ascending(true);
                            // if ManingLevelsLineRec.FindSet() then begin
                            //     repeat
                            //         MachineCount := 0;
                            //         if MachineCodeGB <> ManingLevelsLineRec."Machine No." then begin
                            //             LineNo2 += 1;
                            //             StyleWiseMachineLineRec.Init();
                            //             StyleWiseMachineLineRec.No := ManningLevlHeaderRec."No.";
                            //             StyleWiseMachineLineRec."Line No" := LineNo2;
                            //             StyleWiseMachineLineRec."Machine No" := ManingLevelsLineRec."Machine No.";
                            //             StyleWiseMachineLineRec."Machine Name" := ManingLevelsLineRec."Machine Name";
                            //             StyleWiseMachineLineRec."Style Name" := ManningLevlHeaderRec."Style Name";
                            //             StyleWiseMachineLineRec."Style No" := ManningLevlHeaderRec."Style No.";
                            //             StyleWiseMachineLineRec."Work Center Name" := ManningLevlHeaderRec."Work Center Name";
                            //             StyleWiseMachineLineRec."Record Type" := 'L';
                            //             MachineCodeGB := ManingLevelsLineRec."Machine No.";
                            //             Workcenter := ManningLevlHeaderRec."Work Center Name";

                            //             // ManingLevelsLine2Rec.Reset();
                            //             ManingLevelsLine2Rec.SetRange("No.", ManningLevlHeaderRec."No.");
                            //             ManingLevelsLine2Rec.SetRange("Machine No.", MachineCodeGB);
                            //             if ManingLevelsLine2Rec.FindSet() then begin
                            //                 repeat
                            //                     if ManningLevlHeaderRec."Work Center Name" = Workcenter then begin
                            //                         if ManingLevelsLine2Rec."Act MO" > 0 then
                            //                             MachineCount := MachineCount + ManingLevelsLine2Rec."Act MO";
                            //                     end;
                            //                 until ManingLevelsLine2Rec.Next() = 0;
                            //                 StyleWiseMachineLineRec."Machine Qty" := MachineCount;
                            //             end;
                            //             StyleWiseMachineLineRec.Insert();
                            //             TotMachine += MachineCount;
                            //         end;
                            //     until ManingLevelsLineRec.Next() = 0;

                            // end;
                            MachineReqRec.Insert();

                            //Insert total
                            // StyleWiseMachineLineRec.Init();
                            // StyleWiseMachineLineRec.No := ManningLevlHeaderRec."No.";
                            // StyleWiseMachineLineRec."Line No" := LineNo2 + 1;
                            // StyleWiseMachineLineRec."Machine No" := 'Total';
                            // StyleWiseMachineLineRec."Record Type" := 'H';
                            // StyleWiseMachineLineRec."Machine Qty" := TotMachine;
                            // StyleWiseMachineLineRec.Insert();
                        end;

                    end;
                end;
            until ManningLevlHeaderRec.Next() = 0;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        StyleWiseMachineLineRec: Record StyleWiseMachineLine;
    begin

        StyleWiseMachineLineRec.Reset();
        StyleWiseMachineLineRec.SetRange(No, Rec.No);
        StyleWiseMachineLineRec.SetRange("Style No", rec."Style No");
        if StyleWiseMachineLineRec.FindSet() then
            StyleWiseMachineLineRec.DeleteAll();
    end;

}