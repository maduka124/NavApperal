page 51362 StyleWiseMachineReqCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = MachineRequestListTble;
    Caption = 'Style Wise Machine Requerment';

    layout
    {
        area(Content)
        {
            group("Machine Details")
            {
                part(StyleWiseMachineReqListpart; StyleWiseMachineReqListpart)
                {
                    SubPageLink = No = field(No);
                    ApplicationArea = All;
                    Caption = '  ';
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
        // ManingLevelsLine2Rec: Record "Maning Levels Line";
        NavAppProdDetailRec: Record "NavApp Prod Plans Details";
        StyleWiseMachineLineRec: Record StyleWiseMachineLine;
        StyleWiseMachineLine2Rec: Record StyleWiseMachineLine;
        StyleWiseMachineLine3Rec: Record StyleWiseMachineLine;
        LineNo: Integer;
        LineNo2: Integer;
        MachineCodeGB: Code[20];
        MachineCount: Decimal;
        TotMachine: Decimal;
        TotalAll: Decimal;
        Workcenter: Text[100];
    begin

        LineNo2 := 0;
        TotMachine := 0;
        TotalAll := 0;

        StyleWiseMachineLineRec.Reset();
        StyleWiseMachineLineRec.SetRange(No, Rec.No);

        if StyleWiseMachineLineRec.findset() then
            StyleWiseMachineLineRec.DeleteAll();

        ManningLevlHeaderRec.Reset();
        ManningLevlHeaderRec.SetRange("Style No.", Rec."Style No");
        ManningLevlHeaderRec.SetRange("No.", Rec.No);
        ManningLevlHeaderRec.SetRange("Work Center Name", Rec.Line);

        if ManningLevlHeaderRec.FindSet() then begin
            repeat

                ManingLevelsLineRec.Reset();
                ManingLevelsLineRec.SetRange("No.", ManningLevlHeaderRec."No.");
                ManingLevelsLineRec.SetCurrentKey("Machine No.");
                ManingLevelsLineRec.Ascending(true);

                if ManingLevelsLineRec.FindSet() then begin
                    repeat

                        StyleWiseMachineLine3Rec.Reset();
                        StyleWiseMachineLine3Rec.SetRange(No, Rec.No);
                        StyleWiseMachineLine3Rec.SetRange("Machine No", ManingLevelsLineRec."Machine No.");

                        if not StyleWiseMachineLine3Rec.FindSet() then begin

                            LineNo2 += 1;
                            StyleWiseMachineLineRec.Init();
                            StyleWiseMachineLineRec.No := Rec.No;
                            StyleWiseMachineLineRec."Line No" := LineNo2;
                            StyleWiseMachineLineRec."Machine No" := ManingLevelsLineRec."Machine No.";
                            StyleWiseMachineLineRec."Machine Name" := ManingLevelsLineRec."Machine Name";
                            StyleWiseMachineLineRec."Style Name" := ManningLevlHeaderRec."Style Name";
                            StyleWiseMachineLineRec."Style No" := ManningLevlHeaderRec."Style No.";
                            StyleWiseMachineLineRec."Work Center Name" := ManningLevlHeaderRec."Work Center Name";
                            StyleWiseMachineLineRec."Record Type" := 'L';
                            MachineCodeGB := ManingLevelsLineRec."Machine No.";
                            Workcenter := ManningLevlHeaderRec."Work Center Name";

                            if ManingLevelsLineRec."Act MO" > 0 then
                                StyleWiseMachineLineRec."Machine Qty New" := ManingLevelsLineRec."Act MO";

                            TotMachine := TotMachine + ManingLevelsLineRec."Act MO";

                            StyleWiseMachineLineRec.Insert();

                        end
                        else begin

                            StyleWiseMachineLine2Rec.Reset();
                            StyleWiseMachineLine2Rec.SetRange(No, Rec.No);
                            StyleWiseMachineLine2Rec.SetRange("Machine No", StyleWiseMachineLine3Rec."Machine No");

                            if StyleWiseMachineLine2Rec.FindSet() then begin
                                if ManingLevelsLineRec."Act MO" > 0 then begin
                                    StyleWiseMachineLine2Rec."Machine Qty New" := StyleWiseMachineLine2Rec."Machine Qty New" + ManingLevelsLineRec."Act MO";
                                    StyleWiseMachineLine2Rec.Modify();
                                    TotMachine := TotMachine + ManingLevelsLineRec."Act MO";
                                end;
                            end;
                        end;

                    until ManingLevelsLineRec.Next() = 0;
                end;
            until ManningLevlHeaderRec.Next() = 0;

            //Insert total
            StyleWiseMachineLineRec.Init();
            StyleWiseMachineLineRec.No := Rec.No;
            StyleWiseMachineLineRec."Line No" := LineNo2 + 1;
            StyleWiseMachineLineRec."Machine No" := 'Total';
            StyleWiseMachineLineRec."Record Type" := 'H';
            StyleWiseMachineLineRec."Machine Qty New" := TotMachine;
            StyleWiseMachineLineRec.Insert();
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        StyleWiseMachineLineRec: Record StyleWiseMachineLine;
    begin

        StyleWiseMachineLineRec.Reset();
        StyleWiseMachineLineRec.SetRange(No, Rec.No);

        if StyleWiseMachineLineRec.FindSet() then
            StyleWiseMachineLineRec.DeleteAll();
    end;
}