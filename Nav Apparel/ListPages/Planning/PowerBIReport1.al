page 50842 PowerBIReport1
{
    PageType = Card;

    layout
    {
        area(Content)
        {
            group("Items")
            {
                part(Control98; "Power BI Report Spinner Part")
                {
                    AccessByPermission = TableData "Power BI User Configuration" = I;
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }

                // part(Control99; "Power BI Report FactBox")
                // {
                //     AccessByPermission = TableData "Power BI User Configuration" = I;
                //     ApplicationArea = Basic, Suite;
                //     Enabled = false;
                // }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action("Refresh")
            {
                ApplicationArea = all;
                Image = Refresh;

                trigger OnAction()
                var
                begin

                end;
            }
        }
    }
}
