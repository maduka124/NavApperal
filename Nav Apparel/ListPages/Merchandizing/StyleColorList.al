page 51065 StyleColorList
{
    PageType = List;
    SourceTable = StyleColor;
    //SourceTableView = where("User ID" = field(user));
    SourceTableView = sorting("User ID", "Color No.") order(descending);
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Color No."; rec."Color No.")
                {
                    ApplicationArea = All;
                    Caption = 'Color Code';
                }

                field(Color; rec.Color)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}