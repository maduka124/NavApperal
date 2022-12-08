pageextension 50803 ReleasedProdOrderLine extends "Released Prod. Order Lines"
{
    layout
    {
        addafter("Cost Amount")
        {
            field(Step; rec.Step)
            {
                ApplicationArea = All;
            }

            field(Water; rec.Water)
            {
                ApplicationArea = All;
            }

            field(Temp; rec.Temp)
            {
                ApplicationArea = All;
            }

            field(Ph; rec.Ph)
            {
                ApplicationArea = All;
            }

            field(Instruction; rec.Instruction)
            {
                ApplicationArea = All;
            }

            field("Time(Min)"; rec."Time(Min)")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("Order &Tracking")
        {
            action("Calculate Totals")
            {
                Image = Calculate;
                ApplicationArea = all;

                trigger OnAction()
                var
                    ProdLne: Record "Prod. Order Line";
                    ProdHead: Record "Production Order";
                    TotalWaterLtrs: Decimal;
                    TotalTime: Decimal;
                begin
                    ProdLne.Reset();
                    ProdLne.SetRange("Prod. Order No.", rec."Prod. Order No.");
                    ProdLne.SetRange(Status, rec.Status);
                    if ProdLne.FindSet() then
                        repeat
                            TotalWaterLtrs += ProdLne.Water;
                            TotalTime += ProdLne."Time(Min)";
                        until ProdLne.Next() = 0;

                    ProdHead.Reset();
                    ProdHead.SetRange("No.", rec."Prod. Order No.");
                    ProdHead.SetRange(Status, rec.Status);
                    if ProdHead.FindSet() then begin
                        ProdHead."Total Water Ltrs:" := TotalWaterLtrs;
                        ProdHead."Process Time:" := TotalTime;
                        ProdHead.Modify();
                    end;

                    CurrPage.Update();

                end;
            }
        }
    }

}