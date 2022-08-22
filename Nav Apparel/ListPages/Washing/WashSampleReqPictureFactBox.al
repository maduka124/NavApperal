page 50750 WashSampleReqPictureFactBox
{
    PageType = Cardpart;
    Caption = 'Upload Sample Images';
    SourceTable = "Washing Sample Header";

    layout
    {
        area(Content)
        {
            field(PictureFront; PictureFront)
            {
                ApplicationArea = All;
                Caption = 'Front View';
            }

            field(PictureBack; PictureBack)
            {
                ApplicationArea = All;
                Caption = 'Back View';
            }
        }
    }

    trigger OnOpenPage()
    var
        WashSampleReqHdrRec: Record "Washing Sample Header";
        Client: HttpClient;
        Content: HttpContent;
        ResponseFront: HttpResponseMessage;
        ResponseBack: HttpResponseMessage;
        InStrFront: InStream;
        InStrBack: InStream;
    begin

        WashSampleReqHdrRec.Reset();
        WashSampleReqHdrRec.SetRange("No.", "No.");

        if WashSampleReqHdrRec.FindSet() then begin

            Client.Get(WashSampleReqHdrRec.FrontURL, ResponseFront);
            ResponseFront.Content.ReadAs(InStrFront);
            Clear(WashSampleReqHdrRec.PictureFront);
            WashSampleReqHdrRec.PictureFront.ImportStream(InStrFront, 'Front picture ');

            Client.Get(WashSampleReqHdrRec.BackURL, ResponseBack);
            ResponseBack.Content.ReadAs(InStrBack);
            Clear(WashSampleReqHdrRec.PictureBack);
            WashSampleReqHdrRec.PictureBack.ImportStream(InStrBack, 'Back picture ');

            WashSampleReqHdrRec.Modify(true);
        end;

    end;


    trigger OnClosePage()
    var
        WashSampleReqHdrRec: Record "Washing Sample Header";
    begin
        WashSampleReqHdrRec.Reset();
        WashSampleReqHdrRec.SetRange("No.", "No.");

        if WashSampleReqHdrRec.FindSet() then begin

            Clear(WashSampleReqHdrRec.PictureFront);
            Clear(WashSampleReqHdrRec.PictureBack);
            WashSampleReqHdrRec.Modify(true);

        end;
    end;


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        WashSampleReqHdrRec: Record "Washing Sample Header";
    begin
        WashSampleReqHdrRec.Reset();
        WashSampleReqHdrRec.SetRange("No.", "No.");

        if WashSampleReqHdrRec.FindSet() then begin

            Clear(WashSampleReqHdrRec.PictureFront);
            Clear(WashSampleReqHdrRec.PictureBack);
            WashSampleReqHdrRec.Modify(true);

        end;
    end;

}