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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'seq No';
                }

                field("Doc Type Name"; "Doc Type Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Doc Type';
                }

                field(FileType; FileType)
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
        SampleReqDocRec.SetRange("No.", "No.");
        SampleReqDocRec.SetRange("Line No.", "Line No.");

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