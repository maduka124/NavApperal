page 71012737 "Learning Curve Card"
{
    PageType = Card;
    SourceTable = "Learning Curve";
    Caption = 'Learning Curve';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Learning Curve No';
                    Editable = false;
                }

                field(Type; Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        SetStatus();
                        if (LCTypeDesc = NVTypeDesc) then
                            Active := true;

                        if (LCTypeDesc <> NVTypeDesc) then
                            Active := false;
                    end;
                }

                field(Day1; Day1)
                {
                    ApplicationArea = All;
                    Caption = 'Day 1';

                    trigger OnValidate()
                    var
                    begin
                        SetStatus();
                        if (LCTypeDesc = NVTypeDesc) then
                            Active := true;

                        if (LCTypeDesc <> NVTypeDesc) then
                            Active := false;
                    end;
                }

                field(Day2; Day2)
                {
                    ApplicationArea = All;
                    Caption = 'Day 2';

                    trigger OnValidate()
                    var
                    begin
                        SetStatus();
                        if (LCTypeDesc = NVTypeDesc) then
                            Active := true;

                        if (LCTypeDesc <> NVTypeDesc) then
                            Active := false;
                    end;
                }

                field(Day3; Day3)
                {
                    ApplicationArea = All;
                    Caption = 'Day 3';

                    trigger OnValidate()
                    var
                    begin
                        SetStatus();
                        if (LCTypeDesc = NVTypeDesc) then
                            Active := true;

                        if (LCTypeDesc <> NVTypeDesc) then
                            Active := false;
                    end;
                }

                field(Day4; Day4)
                {
                    ApplicationArea = All;
                    Caption = 'Day 4';

                    trigger OnValidate()
                    var
                    begin
                        SetStatus();
                        if (LCTypeDesc = NVTypeDesc) then
                            Active := true;

                        if (LCTypeDesc <> NVTypeDesc) then
                            Active := false;
                    end;
                }

                field(Day5; Day5)
                {
                    ApplicationArea = All;
                    Caption = 'Day 5';

                    trigger OnValidate()
                    var
                    begin
                        SetStatus();
                        if (LCTypeDesc = NVTypeDesc) then
                            Active := true;

                        if (LCTypeDesc <> NVTypeDesc) then
                            Active := false;
                    end;
                }

                field(Day6; Day6)
                {
                    ApplicationArea = All;
                    Caption = 'Day 6';

                    trigger OnValidate()
                    var
                    begin
                        SetStatus();
                        if (LCTypeDesc = NVTypeDesc) then
                            Active := true;

                        if (LCTypeDesc <> NVTypeDesc) then
                            Active := false;
                    end;
                }

                field(Day7; Day7)
                {
                    ApplicationArea = All;
                    Caption = 'Day 7';

                    trigger OnValidate()
                    var
                    begin
                        SetStatus();
                        if (LCTypeDesc = NVTypeDesc) then
                            Active := true;

                        if (LCTypeDesc <> NVTypeDesc) then
                            Active := false;
                    end;
                }

                field(Active; Active)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        SetStatus();

                        if (LCTypeDesc = NVTypeDesc) and (Active = false) then
                            Error('learning curve cannot mark as In-Active');

                        if (LCTypeDesc <> NVTypeDesc) and (Active = true) then
                            Error('learning curve cannot mark as Active');
                    end;
                }
            }
        }
    }

    procedure SetStatus()
    var
        NavAppSetupRec: Record "NavApp Setup";
    begin
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        if (NavAppSetupRec."Learning Curve Type" = NavAppSetupRec."Learning Curve Type"::"Efficiency Wise") then
            NVTypeDesc := 'Efficiency Wise';

        if (NavAppSetupRec."Learning Curve Type" = NavAppSetupRec."Learning Curve Type"::Hourly) then
            NVTypeDesc := 'Hourly';

        if (Type = Type::"Efficiency Wise") then
            LCTypeDesc := 'Efficiency Wise';

        if (Type = Type::Hourly) then
            LCTypeDesc := 'Hourly';
    end;


    var
        LCTypeDesc: Text[100];
        NVTypeDesc: Text[100];

}