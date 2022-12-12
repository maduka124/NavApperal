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
                field("No."; rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Item Type Name"; rec."Item Type Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Item Type';

                    trigger OnValidate()
                    var
                        ItemRec: Record "Item Type";
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange("Item Type Name", rec."Item Type Name");
                        if ItemRec.FindSet() then
                            rec."Item Type No." := ItemRec."No.";
                    end;
                }

                field("Garment Part Name"; rec."Garment Part Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Garment Part';

                    trigger OnValidate()
                    var
                        GarmentPartRec: Record GarmentPart;
                    begin
                        GarmentPartRec.Reset();
                        GarmentPartRec.SetRange(Description, rec."Garment Part Name");
                        if GarmentPartRec.FindSet() then
                            rec."Garment Part No." := GarmentPartRec."No.";
                    end;
                }

                field(Code; rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field(SMV; rec.SMV)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if rec.SMV <> 0 then
                            rec."Target Per Hour" := 60 / rec.SMV;
                    end;
                }

                field("Target Per Hour"; rec."Target Per Hour")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Seam Length"; rec."Seam Length")
                {
                    ApplicationArea = All;
                }

                field(Grade; rec.Grade)
                {
                    ApplicationArea = All;
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Department';

                    trigger OnValidate()
                    var
                        DepartmentRec: Record "Department";
                    begin
                        DepartmentRec.Reset();
                        DepartmentRec.SetRange("Department Name", rec."Department Name");
                        if DepartmentRec.FindSet() then
                            rec."Department No." := DepartmentRec."No."
                    end;
                }

                field("Machine Name"; rec."Machine Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Machine';

                    trigger OnValidate()
                    var
                        MachineRec: Record "Machine Master";
                    begin
                        MachineRec.Reset();
                        MachineRec.SetRange("Machine Description", rec."Machine Name");
                        if MachineRec.FindSet() then
                            rec."Machine No." := MachineRec."Machine No.";
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Generate)
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    NewOperationRec: Record "New Operation";
                    NewOperation2Rec: Record "New Operation";
                    Temp: BigInteger;

                begin

                    NewOperation2Rec.Reset();
                    if NewOperation2Rec.FindSet() then begin
                        repeat

                            NewOperation2Rec.Code2 := 0;
                            Temp := 0;
                            NewOperation2Rec.Code1 := '';

                            if NewOperation2Rec."Item Type No." <> '' then
                                NewOperation2Rec.Code1 := NewOperation2Rec."Item Type Name".Substring(1, 2);

                            if NewOperation2Rec."Garment Part Name" <> '' then
                                NewOperation2Rec.Code1 := NewOperation2Rec.Code1 + NewOperation2Rec."Garment Part Name".Substring(1, 2);

                            if (NewOperation2Rec."Item Type No." <> '') and (NewOperation2Rec."Garment Part Name" <> '') then begin

                                NewOperationRec.Reset();
                                NewOperationRec.SetRange(Code1, NewOperation2Rec.Code1);

                                if NewOperationRec.FindLast() then
                                    temp := NewOperationRec.Code2;

                                NewOperation2Rec.Code2 := temp + 1;
                                NewOperation2Rec.Code := NewOperation2Rec.Code1 + format(NewOperation2Rec.Code2);
                                NewOperation2Rec.Modify();
                            end;

                        until NewOperation2Rec.Next() = 0;
                    end;
                end;
            }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."NEWOP Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;
}