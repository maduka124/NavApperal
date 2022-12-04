page 50691 "FabTwistListPart"
{
    PageType = ListPart;
    SourceTable = FabTwistLine;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Seq No';
                }

                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Color';
                }

                field(NoofRolls; rec.NoofRolls)
                {
                    ApplicationArea = All;
                    Caption = 'No of Rolls';
                    Editable = false;
                }

                field(RollID; rec.RollID)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Roll ID';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Qty (YDS)';
                    Editable = false;
                }

                field("BW Width CM"; rec."BW Width CM")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if rec."BW Width CM" > 0 then
                            rec."BW Twist%" := rec."BW Twist CM" / rec."BW Width CM"
                        else
                            rec."BW Twist%" := 0;
                    end;
                }

                field("BW Twist CM"; rec."BW Twist CM")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if rec."BW Width CM" > 0 then
                            rec."BW Twist%" := rec."BW Twist CM" / rec."BW Width CM"
                        else
                            rec."BW Twist%" := 0;
                    end;
                }

                field("BW Twist%"; rec."BW Twist%")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field("AW Width CM"; rec."AW Width CM")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin

                        if rec."AW Width CM" > 0 then begin
                            rec."AW Twist%" := rec."AW Twist CM" / rec."AW Width CM";
                            CurrPage.Update();
                            Cal_Avg();
                        end
                        else
                            rec."AW Twist%" := 0;
                    end;
                }

                field("AW Twist CM"; rec."AW Twist CM")
                {
                    ApplicationArea = All;


                    trigger OnValidate()
                    var
                    begin
                        if rec."AW Width CM" > 0 then begin
                            rec."AW Twist%" := rec."AW Twist CM" / rec."AW Width CM";
                            CurrPage.Update();
                            Cal_Avg();
                        end
                        else
                            rec."AW Twist%" := 0;
                    end;
                }

                field("AW Twist%"; rec."AW Twist%")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
        }
    }

    procedure Cal_Avg()
    var
        FabTwistLineRec: Record FabTwistLine;
        FabTwistHeadRec: Record FabTwistHeader;
        TempAvg: Decimal;
        Count: Integer;
    begin

        FabTwistLineRec.Reset();
        FabTwistLineRec.SetRange("FabTwistNo.", rec."FabTwistNo.");
        FabTwistLineRec.FindSet();

        repeat
            Count += 1;
            TempAvg += FabTwistLineRec."AW Twist%"
        until FabTwistLineRec.Next() = 0;

        if Count > 0 then
            TempAvg := TempAvg / Count
        else
            TempAvg := 0;

        FabTwistHeadRec.Reset();
        FabTwistHeadRec.SetRange("FabTwistNo.", rec."FabTwistNo.");
        FabTwistHeadRec.FindSet();
        FabTwistHeadRec.ModifyAll(Avg, TempAvg);
        CurrPage.Update();

    end;
}