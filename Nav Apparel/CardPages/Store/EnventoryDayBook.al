report 51385 EnventoryDayBook
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Item; Item)
        {
            column(Main_Category_Name; "Main Category Name")
            { }

            column(Unit_of_Measure_Id; "Unit of Measure Id")
            { }

            column(Description; Description)
            { }

            column(Unit_Cost; "Unit Cost")
            { }

            dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
            {
                // column()
            }

        }
    }

    requestpage
    {
        layout
        {
            // area(Content)
            // {
            //     group(GroupName)
            //     {
            //         field(Name; SourceExpression)
            //         {
            //             ApplicationArea = All;

            //         }
            //     }
            // }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }

    var
        myInt: Integer;
}