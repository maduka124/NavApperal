page 50118 "Main Category Filter"
{
    Caption = 'Main Category Filter';
    PageType = List;
    SourceTable = "Main Category Filter";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
