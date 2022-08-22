page 71012775 SampleReqLineListPart
{
    PageType = ListPart;
    SourceTable = "Sample Requsition Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Seq No';
                }

                field("Fabrication Name"; "Fabrication Name")
                {
                    ApplicationArea = All;
                    Caption = 'Fabrication';

                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, "Fabrication Name");
                        if ItemRec.FindSet() then
                            "Fabrication No." := ItemRec."No.";

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field("Sample Name"; "Sample Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Type';

                    trigger OnValidate()
                    var
                        SampleRec: Record "Sample Type";
                    begin
                        SampleRec.Reset();
                        SampleRec.SetRange("Sample Type Name", "Sample Name");
                        if SampleRec.FindSet() then
                            "Sample No." := SampleRec."No.";

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';

                    trigger OnValidate()
                    var
                        ColourRec: Record Colour;
                    begin
                        ColourRec.Reset();
                        ColourRec.SetRange("Colour Name", "Color Name");
                        if ColourRec.FindSet() then
                            "Color No" := ColourRec."No.";

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field(Size; Size)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field(Qty; Qty)
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
                        SampleReqLine.SetRange("No.", "No.");

                        if SampleReqLine.FindSet() then begin
                            repeat
                                Total := Total + SampleReqLine.Qty;
                            until SampleReqLine.Next() = 0;
                        end;

                        SampleReqHeader.Reset();
                        SampleReqHeader.SetRange("No.", "No.");
                        SampleReqHeader.FindSet();
                        SampleReqHeader.Qty := Total;
                        SampleReqHeader.Modify();

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');

                    end;
                }

                field("Req Date"; "Req Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field(Comment; Comment)
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
        SampleReqLineRec.SetRange("No.", "No.");
        SampleReqLineRec.SetFilter("Line No.", '<>%1', "Line No.");
        if SampleReqLineRec.FindSet() then
            exit(SampleReqLineRec.Count)
        else
            exit(0);
    end;
}