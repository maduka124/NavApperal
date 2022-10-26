page 71012840 StyleColorList
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
                field("Color No."; "Color No.")
                {
                    ApplicationArea = All;
                    Caption = 'Color Code';
                }

                field(Color; Color)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}