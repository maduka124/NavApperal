report 50644 ProductionOrderReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
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

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        myInt: Integer;
}