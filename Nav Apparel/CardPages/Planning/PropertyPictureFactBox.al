page 50341 "Property Picture FactBox"
{
    PageType = Cardpart;
    SourceTable = "Planning Queue";

    layout
    {
        area(Content)
        {
            grid("")
            {
                GridLayout = Rows;
                group(" ")
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
    }
}