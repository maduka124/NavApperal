page 50433 SampleReqDocListPartWIP
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Doc";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'seq No';
                }

                field("Doc Type Name"; rec."Doc Type Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Doc Type';
                }

                field(FileType; rec.FileType)
                {
                    ApplicationArea = All;
                    Caption = 'View File';
                    Editable = false;

                    trigger OnAssistEdit()
                    var
                    begin
                        DownloadFile();
                    end;
                }
            }
        }
    }


    procedure DownloadFile()
    var
        SampleReqDocRec: Record "Sample Requsition Doc";
        ResponseStream: InStream;
        Tempfilename: Text;
        ErrorAttachment: Label 'No file available';
    begin

        SampleReqDocRec.Reset();
        SampleReqDocRec.SetRange("No.", rec."No.");
        SampleReqDocRec.SetRange("Line No.", rec."Line No.");

        if SampleReqDocRec.FindSet() then begin
            if SampleReqDocRec.Path.HasValue then begin
                SampleReqDocRec.CalcFields(Path);
                SampleReqDocRec.Path.CreateInStream(ResponseStream);
                Tempfilename := 'File' + SampleReqDocRec.FileType;
                DownloadFromStream(ResponseStream, 'Export', '', 'All Files (*.*)|*.*', Tempfilename);
            end
            else
                Error(ErrorAttachment);
        end;
    end;
}