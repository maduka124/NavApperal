pageextension 50658 WashinBOMList extends "Production BOM Lines"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field(Step; Step)
            {
                ApplicationArea = All;
            }

            field("Water(L)"; "Water(L)")
            {
                ApplicationArea = All;
            }

            field(Temperature; Temperature)
            {
                ApplicationArea = All;
            }

            field(Time; Time)
            {
                ApplicationArea = All;
            }

            field("Weight(Kg)"; "Weight(Kg)")
            {
                ApplicationArea = All;
            }

            field(Remark; Remark)
            {
                ApplicationArea = All;
            }
        }
    }
}