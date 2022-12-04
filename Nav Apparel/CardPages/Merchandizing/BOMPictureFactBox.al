page 50987 "BOM Picture FactBox"
{
    PageType = Cardpart;
    SourceTable = "Style Master";

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