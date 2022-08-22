page 50717 "Washing Sample Picture URL"
{
    PageType = StandardDialog;
    Caption = ' Washing Sample Picture URL Dialog';

    layout
    {
        area(Content)
        {
            field(FrontPictureURL; FrontPictureURL)
            {
                ApplicationArea = All;
                Caption = 'Front Picture URL';
                ExtendedDatatype = URL;
            }

            field(BackPictureURL; BackPictureURL)
            {
                ApplicationArea = All;
                Caption = 'Back Picture URL';
                ExtendedDatatype = URL;
            }
        }

    }

    var

        FrontPictureURL: Text;
        BackPictureURL: Text;
        DocNoPara: Code[20];

    procedure SetItemInfo(DocNo: Code[20])
    begin
        DocNoPara := DocNo;
    end;

    procedure ImportItemPictureFromURL()
    var
        WashSampleReqHdrRec: Record "Washing Sample Header";

    begin

        WashSampleReqHdrRec.Reset();
        WashSampleReqHdrRec.SetRange("No.", DocNoPara);
        WashSampleReqHdrRec.FindSet();

        if FrontPictureURL <> '' then
            WashSampleReqHdrRec.FrontURL := FrontPictureURL;

        if BackPictureURL <> '' then
            WashSampleReqHdrRec.BackURL := BackPictureURL;

        WashSampleReqHdrRec.Modify();

    end;

}