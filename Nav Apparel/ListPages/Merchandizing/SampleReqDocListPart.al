page 71012776 SampleReqDocListPart
{
    PageType = ListPart;
    SourceTable = "Sample Requsition Doc";

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

                field("Doc Type Name"; rec."Doc Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Doc Type';

                    trigger OnValidate()
                    var
                        UploadDocRec: Record "Upload Document Type";
                    begin
                        UploadDocRec.Reset();
                        UploadDocRec.SetRange("Doc Name", rec."Doc Type Name");
                        if UploadDocRec.FindSet() then
                            rec."Doc Type No." := UploadDocRec."Doc No.";
                    end;
                }

                field(Path; rec.Path)
                {
                    ApplicationArea = All;
                    Caption = 'Upload File';
                    Editable = false;

                    trigger OnAssistEdit()
                    var
                        RecRef: RecordRef;
                        DocumentAttachmentDetails: page "Document Attachment Details";
                    begin
                        UploadFile(rec."No.", rec."Line No.");
                    end;
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

    procedure UploadFile(No: Code[20]; LineNo: BigInteger)
    var
        outstr: OutStream;
        SampleReqDocRec: Record "Sample Requsition Doc";
        Instr: InStream;
        Tempfilename: Text;
        Index: Integer;
        FileType: Text;
    begin
        UploadIntoStream('Please select a file....', '', 'All Files (*.*)|*.*', Tempfilename, Instr);

        if not (Tempfilename = '') then begin
            // Message(No);
            // Message(format(LineNo));
            Index := Tempfilename.LastIndexOf('.');
            //FileType := Tempfilename.Substring(index, StrLen(Tempfilename) - (index - 1));
            FileType := Tempfilename;
            SampleReqDocRec.Reset();
            SampleReqDocRec.SetRange("No.", No);
            SampleReqDocRec.SetRange("Line No.", LineNo);
            SampleReqDocRec.FindSet();
            SampleReqDocRec.Path.CreateOutStream(outstr);
            SampleReqDocRec.FileType := FileType;
            CopyStream(outstr, Instr);
            SampleReqDocRec.Modify();
            CurrPage.Update();

        end;

    end;

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
                Tempfilename := SampleReqDocRec.FileType;
                //Tempfilename := 'File' + SampleReqDocRec.FileType;
                DownloadFromStream(ResponseStream, 'Export', '', 'All Files (*.*)|*.*', Tempfilename);
            end
            else
                Error(ErrorAttachment);

        end;
    end;
}