page 51362 StyleWiseMachineReqCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = MachineRequestListTble;
    Caption = 'Style Wise Machine Requerment';

    layout
    {
        area(Content)
        {
            group("Machine Details")
            {
                part(StyleWiseMachineReqListpart; StyleWiseMachineReqListpart)
                {
                    SubPageLink = No = field(No);
                    ApplicationArea = All;
                    Caption = '  ';
                }
            }
        }
    }
}