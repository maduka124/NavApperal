page 71012771 "Sample Request"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sample Requsition Header";
    CardPageId = "Sample Request Card";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Request No';
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field(Type; Type)
                {
                    ApplicationArea = All;
                }

                field("Wash Type Name"; "Wash Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Type';
                }

                // field("Wash Plant Name"; "Wash Plant Name")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Wash Plant';
                // }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        SampleReqLineRec: Record "Sample Requsition Line";
        SampleReqAcceRec: Record "Sample Requsition Acce";
        SampleReqDocRec: Record "Sample Requsition Doc";
    begin

        SampleReqLineRec.Reset();
        SampleReqLineRec.SetRange("No.", "No.");
        SampleReqLineRec.DeleteAll();

        SampleReqAcceRec.Reset();
        SampleReqAcceRec.SetRange("No.", "No.");
        SampleReqAcceRec.DeleteAll();

        SampleReqDocRec.Reset();
        SampleReqDocRec.SetRange("No.", "No.");
        SampleReqDocRec.DeleteAll();

    end;
}