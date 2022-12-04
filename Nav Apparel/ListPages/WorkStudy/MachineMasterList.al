page 50452 "Machine Master"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Machine Master";
    CardPageId = "Machine Master Card";
    SourceTableView = sorting("Machine No.") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Machine No."; rec."Machine No.")
                {
                    ApplicationArea = All;
                    Caption = 'Machine No';
                }

                field("Machine Description"; rec."Machine Description")
                {
                    ApplicationArea = All;
                }

                field("Machine Category Name"; rec."Machine Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Category';
                }

                field("Needle Type Name"; rec."Needle Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Needle Type';
                }

                field("Machine Type"; rec."Machine Type")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Type';
                }

            }
        }
    }
}