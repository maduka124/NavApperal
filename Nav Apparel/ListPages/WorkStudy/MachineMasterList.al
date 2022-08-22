page 50452 "Machine Master"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Machine Master";
    CardPageId = "Machine Master Card";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Machine No."; "Machine No.")
                {
                    ApplicationArea = All;
                    Caption = 'Machine No';
                }

                field("Machine Description"; "Machine Description")
                {
                    ApplicationArea = All;
                }

                field("Machine Category Name"; "Machine Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Category';
                }

                field("Needle Type Name"; "Needle Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Needle Type';
                }

                field("Machine Type"; "Machine Type")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Type';
                }

            }
        }
    }
}