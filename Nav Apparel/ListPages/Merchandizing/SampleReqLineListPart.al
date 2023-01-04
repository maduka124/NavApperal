page 51062 SampleReqLineListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Seq No';
                }

                field("Fabrication Name"; rec."Fabrication Name")
                {
                    ApplicationArea = All;
                    Caption = 'Fabrication';

                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, rec."Fabrication Name");
                        if ItemRec.FindSet() then
                            rec."Fabrication No." := ItemRec."No.";

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field("Sample Name"; rec."Sample Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Type';

                    trigger OnValidate()
                    var
                        SampleRec: Record "Sample Type";
                    begin
                        SampleRec.Reset();
                        SampleRec.SetRange("Sample Type Name", rec."Sample Name");
                        if SampleRec.FindSet() then
                            rec."Sample No." := SampleRec."No.";

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';

                    trigger OnValidate()
                    var
                        ColourRec: Record Colour;
                    begin
                        ColourRec.Reset();
                        ColourRec.SetRange("Colour Name", rec."Color Name");
                        if ColourRec.FindSet() then
                            rec."Color No" := ColourRec."No.";

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field(Size; rec.Size)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        "SampleReqHeader": Record "Sample Requsition Header";
                        "SampleReqLine": Record "Sample Requsition Line";
                        Total: Integer;
                    begin

                        CurrPage.Update();
                        SampleReqLine.Reset();
                        SampleReqLine.SetRange("No.", rec."No.");

                        if SampleReqLine.FindSet() then begin
                            repeat
                                Total := Total + SampleReqLine.Qty;
                            until SampleReqLine.Next() = 0;
                        end;

                        SampleReqHeader.Reset();
                        SampleReqHeader.SetRange("No.", rec."No.");
                        SampleReqHeader.FindSet();
                        SampleReqHeader.Qty := Total;
                        SampleReqHeader.Modify();

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');

                    end;
                }

                field("Req Date"; rec."Req Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SampleReqLine: Record "Sample Requsition Line";
                    begin

                        //Done by Sachith 22/12/27
                        SampleReqLine.Reset();
                        SampleReqLine.SetRange("No.", Rec."No.");

                        if SampleReqLine.FindSet() then begin
                            if rec."Req Date" < WorkDate() then
                                Error('Req. Date should be greater than todays date.');
                        end;

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field(Comment; rec.Comment)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }
            }
        }
    }


    procedure Get_Count(): Integer
    var
        SampleReqLineRec: Record "Sample Requsition Line";
    begin
        SampleReqLineRec.Reset();
        SampleReqLineRec.SetRange("No.", rec."No.");
        SampleReqLineRec.SetFilter("Line No.", '<>%1', rec."Line No.");
        if SampleReqLineRec.FindSet() then
            exit(SampleReqLineRec.Count)
        else
            exit(0);
    end;
}