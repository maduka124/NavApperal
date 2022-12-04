pageextension 50109 BOMEstCostCard extends "BOM Estimate Cost Card"
{
    layout
    {

    }
    actions
    {
        modify(Approve)
        {
            trigger onbeforeaction()
            var
                CustMangemnt: Codeunit "Customization Management";
            begin
                CustMangemnt.InsertTemp(Rec);
            end;
        }
        // addafter(Approve)
        // {
        //     action(test)
        //     {
        //         Image = TestFile;
        //         ApplicationArea = All;
        //         Promoted = true;
        //         trigger OnAction()
        //         var
        //             CustMangemnt: Codeunit "Customization Management";
        //         begin
        //             CustMangemnt.InsertTemp(Rec);
        //         end;
        //     }
        // }
    }
}
