page 50181 NewBreackdownFactBox
{
    PageType = CardPart;
    SourceTable = "Style Master";
    InsertAllowed = false;
    DeleteAllowed = false;

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
}