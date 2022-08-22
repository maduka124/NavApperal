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
}