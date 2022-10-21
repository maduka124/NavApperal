pageextension 50669 Jobcardline extends "Firm Planned Prod. Order Lines"
{
    layout
    {
        addafter("Cost Amount")
        {
            field(Step; Step)
            {
                ApplicationArea = All;
            }

            field(Water; Water)
            {
                ApplicationArea = All;
            }

            field(Temp; Temp)
            {
                ApplicationArea = All;
            }

            field(Ph; Ph)
            {
                ApplicationArea = All;
            }

            field(Instruction; Instruction)
            {
                ApplicationArea = All;
            }

            field("Time(Min)"; "Time(Min)")
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
                    ProdLne.SetRange("Prod. Order No.", "Prod. Order No.");
                    ProdLne.SetRange(Status, Status);
                    if ProdLne.FindSet() then
                        repeat
                            TotalWaterLtrs += ProdLne.Water;
                            TotalTime += ProdLne."Time(Min)";
                        until ProdLne.Next() = 0;

                    ProdHead.Reset();
                    ProdHead.SetRange("No.", "Prod. Order No.");
                    ProdHead.SetRange(Status, Status);
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