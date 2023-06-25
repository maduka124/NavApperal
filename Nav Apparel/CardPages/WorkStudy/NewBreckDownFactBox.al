page 50181 NewBreackdownFactBox
{
    PageType = CardPart;
    SourceTable = "Style Master";
    Caption = 'Upload Images';

    layout
    {
        area(Content)
        {
            field(Front; rec.Front)
            {
                ApplicationArea = All;
                Caption = 'Front';
            }
            field(Back; rec.Back)
            {
                ApplicationArea = All;
                Caption = 'Back';
            }
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
}