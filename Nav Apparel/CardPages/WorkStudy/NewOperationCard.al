page 50456 "New Operation Card"
{
    PageType = Card;
    SourceTable = "New Operation";
    Caption = 'New Operation';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Item Type Name"; "Item Type Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Item Type';

                    trigger OnValidate()
                    var
                        ItemRec: Record "Item Type";
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange("Item Type Name", "Item Type Name");
                        if ItemRec.FindSet() then
                            "Item Type No." := ItemRec."No.";

                        GenCode();
                    end;
                }

                field("Garment Part Name"; "Garment Part Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Garment Part';

                    trigger OnValidate()
                    var
                        GarmentPartRec: Record GarmentPart;
                    begin
                        GarmentPartRec.Reset();
                        GarmentPartRec.SetRange(Description, "Garment Part Name");
                        if GarmentPartRec.FindSet() then
                            "Garment Part No." := GarmentPartRec."No.";

                        GenCode();
                    end;
                }

                field(Code; Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Description; Description)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field(SMV; SMV)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if SMV <> 0 then
                            "Target Per Hour" := 60 / SMV;
                    end;
                }

                field("Target Per Hour"; "Target Per Hour")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Seam Length"; "Seam Length")
                {
                    ApplicationArea = All;
                }

                field(Grade; Grade)
                {
                    ApplicationArea = All;
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Department';

                    trigger OnValidate()
                    var
                        DepartmentRec: Record "Department";
                    begin
                        DepartmentRec.Reset();
                        DepartmentRec.SetRange("Department Name", "Department Name");
                        if DepartmentRec.FindSet() then
                            "Department No." := DepartmentRec."No."
                    end;
                }
               
                field("Machine Name"; "Machine Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Machine';

                    trigger OnValidate()
                    var
                        MachineRec: Record "Machine Master";
                    begin
                        MachineRec.Reset();
                        MachineRec.SetRange("Machine Description", "Machine Name");
                        if MachineRec.FindSet() then
                            "Machine No." := MachineRec."Machine No.";
                    end;
                }
            }
        }
    }

    procedure GenCode()
    var
        NewOperationRec: Record "New Operation";
        Temp: BigInteger;
    begin

        Code2 := 0;
        Temp := 0;
        Code1 := '';

        if "Item Type No." <> '' then
            Code1 := "Item Type Name".Substring(1, 2);

        if "Garment Part Name" <> '' then
            Code1 := Code1 + "Garment Part Name".Substring(1, 2);

        if ("Item Type No." <> '') and ("Garment Part Name" <> '') then begin

            NewOperationRec.Reset();
            NewOperationRec.SetRange(Code1, Code1);

            if NewOperationRec.FindLast() then
                temp := NewOperationRec.Code2;

            Code2 := temp + 1;
            Code := code1 + format(Code2);
            CurrPage.Update();

        end;

    end;


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."NEWOP Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;
}