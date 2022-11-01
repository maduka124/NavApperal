page 50475 "Maning Level Card"
{
    PageType = Card;
    SourceTable = "Maning Level";
    Caption = 'Maning Level';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Maning No';

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
                        NewBR: Record "New Breakdown";
                        ManingLevelsLineRec: Record "Maning Levels Line";
                        NewBrOpLineRec: Record "New Breakdown Op Line2";
                        NewBrRec: Record "New Breakdown";
                        NewBRNo: Code[20];
                        LineNo: Integer;
                    begin

                        //Delete old records
                        ManingLevelsLineRec.Reset();
                        ManingLevelsLineRec.SetRange("No.", "No.");
                        ManingLevelsLineRec.DeleteAll();

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", "Style Name");
                        if StyleMasterRec.FindSet() then
                            "Style No." := StyleMasterRec."No.";

                        NewBR.Reset();
                        NewBR.SetRange("Style No.", StyleMasterRec."No.");
                        NewBR.FindSet();

                        "Total SMV" := NewBR."Total SMV";
                        "Sewing SMV" := newbr.Machine;
                        "Manual SMV" := NewBR.Manual;


                        //Load Line Items
                        NewBrRec.Reset();
                        NewBrRec.SetRange("Style No.", StyleMasterRec."No.");

                        if NewBrRec.FindSet() then begin

                            NewBRNo := NewBrRec."No.";

                            NewBrOpLineRec.Reset();
                            NewBrOpLineRec.SetRange("No.", NewBRNo);
                            NewBrOpLineRec.SetFilter(LineType, '=%1', 'L');

                            if NewBrOpLineRec.FindSet() then begin

                                //Get max line no
                                LineNo := 0;
                                ManingLevelsLineRec.Reset();
                                ManingLevelsLineRec.SetRange("No.", "No.");

                                if ManingLevelsLineRec.FindLast() then
                                    LineNo := ManingLevelsLineRec."Line No.";

                                repeat

                                    LineNo += 1;
                                    ManingLevelsLineRec.Init();
                                    ManingLevelsLineRec."No." := "No.";
                                    ManingLevelsLineRec."Line No." := LineNo;
                                    ManingLevelsLineRec.Code := NewBrOpLineRec.Code;
                                    ManingLevelsLineRec.Description := NewBrOpLineRec.Description;
                                    ManingLevelsLineRec."Machine No." := NewBrOpLineRec."Machine No.";
                                    ManingLevelsLineRec."Machine Name" := NewBrOpLineRec."Machine Name";
                                    ManingLevelsLineRec."Department No." := NewBrOpLineRec."Department No.";
                                    ManingLevelsLineRec."Department Name" := NewBrOpLineRec."Department Name";

                                    if NewBrOpLineRec.MachineType = 'Machine' then
                                        ManingLevelsLineRec."SMV Machine" := NewBrOpLineRec.SMV;

                                    if NewBrOpLineRec.MachineType = 'Helper' then
                                        ManingLevelsLineRec."SMV Manual" := NewBrOpLineRec.SMV;

                                    ManingLevelsLineRec."Target Per Hour" := NewBrOpLineRec."Target Per Hour";
                                    ManingLevelsLineRec."Created User" := UserId;
                                    ManingLevelsLineRec.Insert();

                                until NewBrOpLineRec.Next = 0;

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

                field(Type; Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Cal_Values();
                    end;
                }

                field(Val; Val)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Cal_Values();
                    end;
                }

                field(Eff; Eff)
                {
                    ApplicationArea = All;
                    Caption = 'Expected Eff %';

                    trigger OnValidate()
                    var
                    begin
                        Cal_Values();
                    end;
                }

                field("Total SMV"; "Total SMV")
                {
                    ApplicationArea = All;
                }

                field("Sewing SMV"; "Sewing SMV")
                {
                    ApplicationArea = All;
                }

                field("Manual SMV"; "Manual SMV")
                {
                    ApplicationArea = All;
                }

                part("Maning Levels Listpart1"; "Maning Levels Listpart1")
                {
                    ApplicationArea = All;
                    Caption = 'Planned Lines';
                    SubPageLink = "Style No." = field("Style No.");
                }
            }

            group("  ")
            {
                part("Maning Levels Listpart"; "Maning Levels Listpart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = field("No.");
                }
            }

            group("Hourly Figures")
            {
                field(BPT; BPT)
                {
                    ApplicationArea = All;
                }

                field("Mac Operator"; "Mac Operator")
                {
                    ApplicationArea = All;
                }

                field("Expected Target"; "Expected Target")
                {
                    ApplicationArea = All;
                }
            }


            group(" ")
            {
                grid("Sewing Dept")
                {
                    GridLayout = Rows;
                    group("Machine operator")
                    {
                        field(MOTheo; MOTheo)
                        {
                            ApplicationArea = All;
                            Caption = 'Theoretical';
                            Editable = false;
                        }

                        field(MOAct; MOAct)
                        {
                            ApplicationArea = All;
                            Caption = 'Actual';
                            Editable = false;
                        }

                        field(MODiff; MODiff)
                        {
                            ApplicationArea = All;
                            Caption = 'Difference';
                            Editable = false;
                        }

                        field(MOBil; MOBil)
                        {
                            ApplicationArea = All;
                            Caption = 'BL%';
                            Editable = false;
                        }
                    }

                    group("Helper")
                    {
                        field(HPTheo; HPTheo)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field(HPAct; HPAct)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field(HPODiff; HPODiff)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field(HPBil; HPBil)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Calculate)
            {
                ApplicationArea = All;
                Image = Calculate;

                trigger OnAction()
                begin

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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Manning Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;


    procedure Cal_Values()
    var
        ManingLevelsLineRec: Record "Maning Levels Line";
        TheoMOTotal: Decimal;
        TheoHPTotal: Decimal;
        ActMOTotal: Decimal;
        ActHPTotal: Decimal;
    begin

        //Calculate BPT
        if Type = Type::"Based on Machine Operator" then begin
            if Val <> 0 then
                BPT := "Sewing SMV" / Val
            else
                BPT := 0;
        end
        else begin
            if Type = Type::"Based on Output" then begin
                if Val <> 0 then
                    BPT := (60 / Val) / 100 * Eff
                else
                    BPT := 0;
            end;
        end;

        CurrPage.Update();


        //Calculate Line values
        ManingLevelsLineRec.Reset();
        ManingLevelsLineRec.SetRange("No.", "No.");

        if ManingLevelsLineRec.FindSet() then begin
            repeat

                //Calculate ""Theo MO" / "Theo HP"
                if BPT <> 0 then begin
                    ManingLevelsLineRec."Theo MO" := ManingLevelsLineRec."SMV Machine" / BPT;
                    TheoMOTotal += ManingLevelsLineRec."SMV Machine" / BPT;
                    ManingLevelsLineRec."Theo HP" := ManingLevelsLineRec."SMV Manual" / BPT;
                    TheoHPTotal += ManingLevelsLineRec."SMV Manual" / BPT
                end
                else begin
                    ManingLevelsLineRec."Theo MO" := 0;
                    ManingLevelsLineRec."Theo HP" := 0;
                end;

                ManingLevelsLineRec.Modify();

            until ManingLevelsLineRec.Next() = 0;
        end;

        //Calculate Hourly figures
        if Type = Type::"Based on Machine Operator" then begin
            if BPT <> 0 then
                "Mac Operator" := 60 / BPT
            else
                "Mac Operator" := 0;

            CurrPage.Update();

            if Eff <> 0 then
                "Expected Target" := "Mac Operator" / Eff
            else
                "Expected Target" := 0;
        end
        else begin
            if Type = Type::"Based on Output" then begin
                "Mac Operator" := TheoMOTotal;
                "Expected Target" := Val;
            end;
        end;

        CurrPage.Update();

        //Sewing dept vvalues
        MOTheo := TheoMOTotal;
        HPTheo := TheoHPTotal;

        //Calculate Actual values
        ManingLevelsLineRec.Reset();
        ManingLevelsLineRec.SetRange("No.", "No.");

        if ManingLevelsLineRec.FindSet() then begin
            repeat
                ActMOTotal += ManingLevelsLineRec."Act MO";
                ActHPTotal += ManingLevelsLineRec."Act HP";
            until ManingLevelsLineRec.Next() = 0;
        end;

        MOAct := ActMOTotal;
        HPAct := ActHPTotal;
        MODiff := ActMOTotal - TheoMOTotal;
        HPODiff := ActHPTotal - TheoHPTotal;

        if TheoMOTotal <> 0 then
            MOBil := ((ActMOTotal - TheoMOTotal) / TheoMOTotal) / 100
        else
            MOBil := 0;

        if TheoHPTotal <> 0 then
            HPBil := ((ActHPTotal - TheoHPTotal) / TheoHPTotal) / 100
        else
            HPBil := 0;

        CurrPage.Update();

    end;


    trigger OnDeleteRecord(): Boolean
    var
        ManingLevelsLineRec: Record "Maning Levels Line";
    begin

        ManingLevelsLineRec.Reset();
        ManingLevelsLineRec.SetRange("No.", "No.");
        ManingLevelsLineRec.DeleteAll();

    end;

}