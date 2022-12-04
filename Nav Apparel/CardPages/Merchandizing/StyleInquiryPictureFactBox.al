page 50603 "Style Picture FactBox"
{
    PageType = Cardpart;
    SourceTable = "Style Master";
    Caption = 'Upload Images';

    layout
    {
        area(Content)
        {
            field(Front; rec.Front)
            {
                ApplicationArea = All;
                Caption = 'Front View';
            }

            field(Back; rec.Back)
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
            Clear(rec.Front);
            rec.Front.ImportStream(PicInStream, FromFileName);
            rec.Modify(true);
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
            Clear(rec.Back);
            rec.Back.ImportStream(PicInStream, FromFileName);
            rec.Modify(true);
        end;
    end;


    // trigger OnOpenPage()
    // var
    //     StyleMasterRec: Record "Style Master";
    //     Client: HttpClient;
    //     Content: HttpContent;
    //     ResponseFront: HttpResponseMessage;
    //     ResponseBack: HttpResponseMessage;
    //     InStrFront: InStream;
    //     InStrBack: InStream;
    // begin

    //     StyleMasterRec.Reset();
    //     StyleMasterRec.SetRange("No.", "No.");

    //     if StyleMasterRec.FindSet() then begin

    //         Client.Get(StyleMasterRec.FrontURL, ResponseFront);
    //         ResponseFront.Content.ReadAs(InStrFront);
    //         Clear(StyleMasterRec.PictureFront);
    //         StyleMasterRec.PictureFront.ImportStream(InStrFront, 'Front picture ');

    //         Client.Get(StyleMasterRec.BackURL, ResponseBack);
    //         ResponseBack.Content.ReadAs(InStrBack);
    //         Clear(StyleMasterRec.PictureBack);
    //         StyleMasterRec.PictureBack.ImportStream(InStrBack, 'Back picture ');

    //         StyleMasterRec.Modify(true);
    //     end;

    // end;


    // trigger OnClosePage()
    // var
    //     StyleMasterRec: Record "Style Master";
    //     Client: HttpClient;
    //     Content: HttpContent;
    //     ResponseFront: HttpResponseMessage;
    //     ResponseBack: HttpResponseMessage;
    //     InStrFront: InStream;
    //     InStrBack: InStream;
    // begin

    //     StyleMasterRec.Reset();
    //     StyleMasterRec.SetRange("No.", "No.");

    //     if StyleMasterRec.FindSet() then begin

    //         Clear(StyleMasterRec.PictureFront);
    //         Clear(StyleMasterRec.PictureBack);
    //         StyleMasterRec.Modify(true);

    //     end;

    // end;

    // trigger OnQueryClosePage(CloseAction: Action): Boolean
    // var
    //     StyleMasterRec: Record "Style Master";
    //     Client: HttpClient;
    //     Content: HttpContent;
    //     ResponseFront: HttpResponseMessage;
    //     ResponseBack: HttpResponseMessage;
    //     InStrFront: InStream;
    //     InStrBack: InStream;
    // begin

    //     StyleMasterRec.Reset();
    //     StyleMasterRec.SetRange("No.", "No.");

    //     if StyleMasterRec.FindSet() then begin

    //         Clear(StyleMasterRec.PictureFront);
    //         Clear(StyleMasterRec.PictureBack);
    //         StyleMasterRec.Modify(true);

    //     end;

    // end;
}