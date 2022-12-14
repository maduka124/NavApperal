page 50449 "Needle Type List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = NeedleType;
    CardPageId = "Needle Type Card";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Needle Type No';
                }

                field("Needle Description";"Needle Description")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}