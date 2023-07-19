page 51363 StyleWiseMachineReqListpart
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = StyleWiseMachineLine;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Machine No"; Rec."Machine No")
                {
                    ApplicationArea = All;
                }

                field("Machine Name"; Rec."Machine Name")
                {
                    ApplicationArea = All;
                }

                field("Machine Qty"; Rec."Machine Qty")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}