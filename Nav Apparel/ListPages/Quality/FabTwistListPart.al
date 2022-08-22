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
                field("Line No."; "Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Seq No';
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Color';
                }

                field(NoofRolls; NoofRolls)
                {
                    ApplicationArea = All;
                    Caption = 'No of Rolls';
                    Editable = false;
                }

                field(RollID; RollID)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Roll ID';
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Qty (YDS)';
                    Editable = false;
                }

                field("BW Width CM"; "BW Width CM")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if "BW Width CM" > 0 then
                            "BW Twist%" := "BW Twist CM" / "BW Width CM"
                        else
                            "BW Twist%" := 0;
                    end;
                }

                field("BW Twist CM"; "BW Twist CM")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if "BW Width CM" > 0 then
                            "BW Twist%" := "BW Twist CM" / "BW Width CM"
                        else
                            "BW Twist%" := 0;
                    end;
                }

                field("BW Twist%"; "BW Twist%")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                field("AW Width CM"; "AW Width CM")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin

                        if "AW Width CM" > 0 then begin
                            "AW Twist%" := "AW Twist CM" / "AW Width CM";
                            CurrPage.Update();
                            Cal_Avg();
                        end
                        else
                            "AW Twist%" := 0;
                    end;
                }

                field("AW Twist CM"; "AW Twist CM")
                {
                    ApplicationArea = All;


                    trigger OnValidate()
                    var
                    begin
                        if "AW Width CM" > 0 then begin
                            "AW Twist%" := "AW Twist CM" / "AW Width CM";
                            CurrPage.Update();
                            Cal_Avg();
                        end
                        else
                            "AW Twist%" := 0;
                    end;
                }

                field("AW Twist%"; "AW Twist%")
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
        FabTwistLineRec.SetRange("FabTwistNo.", "FabTwistNo.");
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
        FabTwistHeadRec.SetRange("FabTwistNo.", "FabTwistNo.");
        FabTwistHeadRec.FindSet();
        FabTwistHeadRec.ModifyAll(Avg, TempAvg);
        CurrPage.Update();

    end;
}