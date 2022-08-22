page 71012796 "Picture URL Dialog"
{
    PageType = StandardDialog;
    Caption = 'Picture URL Dialog';

    layout
    {
        area(content)
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
        StyleNoPara: Code[20];
        FrontPictureURL: Text;
        BackPictureURL: Text;

    procedure SetItemInfo(StyleNo: Code[20])
    begin
        StyleNoPara := StyleNo;
    end;

    procedure ImportItemPictureFromURL()
    var
        StyleRec: Record "Style Master";
        Client: HttpClient;
        Content: HttpContent;
        Response: HttpResponseMessage;
        InStr: InStream;
    begin

        //Client.Get(PictureURL, Response);
        //Response.Content.ReadAs(InStr);

        StyleRec.Reset();
        StyleRec.SetRange("No.", StyleNoPara);
        StyleRec.FindSet();

        if FrontPictureURL <> '' then
            StyleRec.FrontURL := FrontPictureURL;

        if BackPictureURL <> '' then
            StyleRec.BackURL := BackPictureURL;

        StyleRec.Modify();

        //if StyleRec.Get(StyleNoPara) then begin
        //Clear(Item.Picture);
        //Item.Picture.ImportStream(InStr, 'Demo picture for item ' + Format(Item."No."));
        // StyleRec.FrontURL := PictureURL;
        // StyleRec.Modify(true);
        //end;
    end;

}