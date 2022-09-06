page 50481 "Machine Layout Card"
{
    PageType = Card;
    SourceTable = "Machine Layout Header";
    Caption = 'Machine Layout';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Layout No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                        ManLevelRec: Record "Maning Level";
                        ManLevelLineRec: Record "Maning Levels Line";
                        ManLevelNo: Code[20];
                        LineNo: Integer;
                        MachineLayoutLineRec: Record "Machine Layout Line1";
                        X: Decimal;
                        Nooftimes: Integer;
                        Balance: Decimal;
                        i: Integer;
                    begin

                        //Delete old records
                        MachineLayoutLineRec.Reset();
                        MachineLayoutLineRec.SetRange("No.", "No.");
                        MachineLayoutLineRec.DeleteAll();

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", "Style Name");
                        if StyleMasterRec.FindSet() then
                            "Style No." := StyleMasterRec."No.";

                        //Load Line Items
                        ManLevelRec.Reset();
                        ManLevelRec.SetRange("Style No.", StyleMasterRec."No.");

                        if ManLevelRec.FindSet() then begin

                            ManLevelNo := ManLevelRec."No.";

                            ManLevelLineRec.Reset();
                            ManLevelLineRec.SetRange("No.", ManLevelNo);

                            if ManLevelLineRec.FindSet() then begin

                                //Get max line no
                                LineNo := 0;
                                MachineLayoutLineRec.Reset();
                                MachineLayoutLineRec.SetRange("No.", "No.");

                                if MachineLayoutLineRec.FindLast() then
                                    LineNo := MachineLayoutLineRec."Line No.";

                                repeat

                                    if (ManLevelLineRec."Act MO" * 60) <= 60 then begin   //Less tan 60 minutes

                                        LineNo += 1;
                                        MachineLayoutLineRec.Init();
                                        MachineLayoutLineRec."No." := "No.";
                                        MachineLayoutLineRec."Line No." := LineNo;
                                        MachineLayoutLineRec.Code := ManLevelLineRec.Code;
                                        MachineLayoutLineRec.Description := ManLevelLineRec.Description;
                                        MachineLayoutLineRec."Machine No." := ManLevelLineRec."Machine No.";
                                        MachineLayoutLineRec."Machine Name" := ManLevelLineRec."Machine Name";

                                        if ManLevelLineRec."SMV Machine" > 0 then begin

                                            MachineLayoutLineRec.SMV := ManLevelLineRec."SMV Machine";
                                            MachineLayoutLineRec.Minutes := ManLevelLineRec."Act MO" * 60;
                                            MachineLayoutLineRec.Target := (ManLevelLineRec."Act MO" * 60) / ManLevelLineRec."SMV Machine";

                                        end
                                        else begin
                                            if ManLevelLineRec."SMV Manual" > 0 then begin

                                                MachineLayoutLineRec.SMV := ManLevelLineRec."SMV Manual";
                                                MachineLayoutLineRec.Minutes := ManLevelLineRec."Act MO" * 60;
                                                MachineLayoutLineRec.Target := (ManLevelLineRec."Act MO" * 60) / ManLevelLineRec."SMV Manual";

                                            end;
                                        end;

                                        MachineLayoutLineRec."Created User" := UserId;
                                        MachineLayoutLineRec.Insert();

                                    end
                                    else begin  //More tan 60 minutes

                                        Nooftimes := (ManLevelLineRec."Act MO" * 60) DIV 60;
                                        Balance := (ManLevelLineRec."Act MO" * 60) MOD 60;

                                        For i := 1 to Nooftimes DO BEGIN

                                            LineNo += 1;
                                            MachineLayoutLineRec.Init();
                                            MachineLayoutLineRec."No." := "No.";
                                            MachineLayoutLineRec."Line No." := LineNo;
                                            MachineLayoutLineRec.Code := ManLevelLineRec.Code;
                                            MachineLayoutLineRec.Description := ManLevelLineRec.Description;
                                            MachineLayoutLineRec."Machine No." := ManLevelLineRec."Machine No.";
                                            MachineLayoutLineRec."Machine Name" := ManLevelLineRec."Machine Name";
                                            MachineLayoutLineRec.Minutes := 60;

                                            if ManLevelLineRec."SMV Machine" > 0 then begin

                                                MachineLayoutLineRec.SMV := ManLevelLineRec."SMV Machine";
                                                MachineLayoutLineRec.Target := 60 / ManLevelLineRec."SMV Machine";

                                            end
                                            else begin
                                                if ManLevelLineRec."SMV Manual" > 0 then begin

                                                    MachineLayoutLineRec.SMV := ManLevelLineRec."SMV Manual";
                                                    MachineLayoutLineRec.Target := 60 / ManLevelLineRec."SMV Manual";

                                                end;
                                            end;

                                            MachineLayoutLineRec."Created User" := UserId;
                                            MachineLayoutLineRec.Insert();

                                        end;

                                        if Balance <> 0 then begin

                                            //Balance Minutes
                                            LineNo += 1;
                                            MachineLayoutLineRec.Init();
                                            MachineLayoutLineRec."No." := "No.";
                                            MachineLayoutLineRec."Line No." := LineNo;
                                            MachineLayoutLineRec.Code := ManLevelLineRec.Code;
                                            MachineLayoutLineRec.Description := ManLevelLineRec.Description;
                                            MachineLayoutLineRec."Machine No." := ManLevelLineRec."Machine No.";
                                            MachineLayoutLineRec."Machine Name" := ManLevelLineRec."Machine Name";
                                            MachineLayoutLineRec.Minutes := Balance;

                                            if ManLevelLineRec."SMV Machine" > 0 then begin

                                                MachineLayoutLineRec.SMV := ManLevelLineRec."SMV Machine";
                                                MachineLayoutLineRec.Target := Balance / ManLevelLineRec."SMV Machine";

                                            end
                                            else begin
                                                if ManLevelLineRec."SMV Manual" > 0 then begin

                                                    MachineLayoutLineRec.SMV := ManLevelLineRec."SMV Manual";
                                                    MachineLayoutLineRec.Target := Balance / ManLevelLineRec."SMV Manual";

                                                end;
                                            end;

                                            MachineLayoutLineRec."Created User" := UserId;
                                            MachineLayoutLineRec.Insert();

                                        end;

                                    end;

                                until ManLevelLineRec.Next = 0;

                                "Expected Target" := ManLevelRec."Expected Target";
                                "Expected Eff" := ManLevelRec.Eff;
                                "Garment Type" := StyleMasterRec."Garment Type Name";
                                "Garment Type No." := StyleMasterRec."Garment Type No.";

                            end;
                        end;
                    end;
                }

                field("Work Center Name"; "Work Center Name")
                {
                    ApplicationArea = All;
                    Caption = 'Line';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        WorkCenterRec: Record "Work Center";
                    begin
                        WorkCenterRec.Reset();
                        WorkCenterRec.SetRange(Name, "Work Center Name");
                        IF WorkCenterRec.FindSet() THEN
                            "Line No." := WorkCenterRec."No.";
                    end;
                }
                field("Expected Eff"; "Expected Eff")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expected Target"; "Expected Target")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Garment Type"; "Garment Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("No of Workstation"; "No of Workstation")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        MachineLayoutRec: Record "Machine Layout";
                        count: Integer;
                        count1: Integer;
                        PKey: BigInteger;
                    begin

                        if "No of Workstation" <> 0 then begin

                            MachineLayoutRec.Reset();
                            MachineLayoutRec.SetRange("No.", "No.");

                            if not MachineLayoutRec.FindSet() then begin

                                for count := 1 to "No of Workstation" DIV 2 do begin

                                    for count1 := 1 to 3 do begin
                                        //Type 1 
                                        PKey += 1;
                                        MachineLayoutRec.Init();
                                        MachineLayoutRec.PKey := PKey;
                                        MachineLayoutRec.Type := 1;
                                        MachineLayoutRec."No." := "No.";
                                        MachineLayoutRec."WP No." := count;
                                        MachineLayoutRec.Insert();
                                    end;

                                    count += 1;

                                    for count1 := 1 to 3 do begin
                                        //Type 2
                                        PKey += 1;
                                        MachineLayoutRec.Init();
                                        MachineLayoutRec.PKey := PKey;
                                        MachineLayoutRec.Type := 2;
                                        MachineLayoutRec."No." := "No.";
                                        MachineLayoutRec."WP No." := count;
                                        MachineLayoutRec.Insert();
                                    end;
                                end;

                            end;
                        end;

                    end;
                }
            }

            group("Maning Layout")
            {
                part("Machine Layout Listpart"; "Machine Layout Listpart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = field("No.");
                    Editable = false;
                }
            }

            group("Machine Layout")
            {
                grid("Machine Layout ")
                {
                    GridLayout = Rows;
                    part("Machine Layout 1"; "Machine Layout 1 Listpart")
                    {
                        ApplicationArea = All;
                        Caption = ' ';
                        SubPageLink = "No." = field("No.");
                    }

                    part("Machine Layout 2"; "Machine Layout 2 Listpart")
                    {
                        ApplicationArea = All;
                        Caption = ' ';
                        SubPageLink = "No." = field("No.");
                    }
                }
            }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Layout Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        MachineLayoutineRec: Record "Machine Layout Line1";
        MachineLayout1Rec: Record "Machine Layout";
    begin

        MachineLayoutineRec.Reset();
        MachineLayoutineRec.SetRange("No.", "No.");
        MachineLayoutineRec.DeleteAll();

        MachineLayout1Rec.Reset();
        MachineLayout1Rec.SetRange("No.", "No.");
        MachineLayout1Rec.DeleteAll();

    end;

}