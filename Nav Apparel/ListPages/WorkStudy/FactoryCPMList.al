page 50775 "Factory CPM List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Factory CPM";
    SourceTableView = sorting("Factory Code", "Line No");
    CardPageId = "Factory CPM Card";
    Caption = 'Factory Wise CPM List';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;
                }

                field(CPM; rec.CPM)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}