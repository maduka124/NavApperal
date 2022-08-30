page 50750 WashSampleReqPictureFactBox
{
    PageType = Cardpart;
    Caption = 'Upload Sample Images';
    SourceTable = "Washing Sample Header";

    layout
    {
        area(Content)
        {
            field(Front; Front)
            {
                ApplicationArea = All;
                Caption = 'Front View';
            }

            field(Back; Back)
            {
                ApplicationArea = All;
                Caption = 'Back View';
            }

            // field(PictureFront; PictureFront)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Front View';
            // }

            // field(PictureBack; PictureBack)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Back View';
            // }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Front Picture")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    UploadFrontImage();
                end;
            }

            action("Back Picture")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    UploadBackImage();
                end;
            }
        }
    }

    procedure UploadFrontImage()
    var
        PicInStream: InStream;
        FromFileName: Text;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?', Locked = false, MaxLength = 250;
    begin
        if not Confirm(OverrideImageQst) then
            exit;
        if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, PicInStream) then begin
            Clear(Front);
            Front.ImportStream(PicInStream, FromFileName);
            Modify(true);
        end;
    end;

    procedure UploadBackImage()
    var
        PicInStream: InStream;
        FromFileName: Text;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?', Locked = false, MaxLength = 250;
    begin
        if not Confirm(OverrideImageQst) then
            exit;
        if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, PicInStream) then begin
            Clear(Back);
            Back.ImportStream(PicInStream, FromFileName);
            Modify(true);
        end;
    end;

    // trigger OnOpenPage()
    // var
    //     WashSampleReqHdrRec: Record "Washing Sample Header";
    //     Client: HttpClient;
    //     Content: HttpContent;
    //     ResponseFront: HttpResponseMessage;
    //     ResponseBack: HttpResponseMessage;
    //     InStrFront: InStream;
    //     InStrBack: InStream;
    // begin

    //     WashSampleReqHdrRec.Reset();
    //     WashSampleReqHdrRec.SetRange("No.", "No.");

    //     if WashSampleReqHdrRec.FindSet() then begin

    //         Client.Get(WashSampleReqHdrRec.FrontURL, ResponseFront);
    //         ResponseFront.Content.ReadAs(InStrFront);
    //         Clear(WashSampleReqHdrRec.PictureFront);
    //         WashSampleReqHdrRec.PictureFront.ImportStream(InStrFront, 'Front picture ');

    //         Client.Get(WashSampleReqHdrRec.BackURL, ResponseBack);
    //         ResponseBack.Content.ReadAs(InStrBack);
    //         Clear(WashSampleReqHdrRec.PictureBack);
    //         WashSampleReqHdrRec.PictureBack.ImportStream(InStrBack, 'Back picture ');

    //         WashSampleReqHdrRec.Modify(true);
    //     end;

    // end;


    // trigger OnClosePage()
    // var
    //     WashSampleReqHdrRec: Record "Washing Sample Header";
    // begin
    //     WashSampleReqHdrRec.Reset();
    //     WashSampleReqHdrRec.SetRange("No.", "No.");

    //     if WashSampleReqHdrRec.FindSet() then begin
    //         Clear(WashSampleReqHdrRec.PictureFront);
    //         Clear(WashSampleReqHdrRec.PictureBack);
    //         WashSampleReqHdrRec.Modify(true);
    //     end;
    // end;


    // trigger OnQueryClosePage(CloseAction: Action): Boolean
    // var
    //     WashSampleReqHdrRec: Record "Washing Sample Header";
    // begin
    //     WashSampleReqHdrRec.Reset();
    //     WashSampleReqHdrRec.SetRange("No.", "No.");

    //     if WashSampleReqHdrRec.FindSet() then begin
    //         Clear(WashSampleReqHdrRec.PictureFront);
    //         Clear(WashSampleReqHdrRec.PictureBack);
    //         WashSampleReqHdrRec.Modify(true);
    //     end;
    // end;
}