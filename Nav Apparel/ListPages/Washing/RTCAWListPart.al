page 50685 RTCAWListPart
{
    PageType = Listpart;
    ApplicationArea = All;
    AutoSplitKey = true;
    UsageCategory = Lists;
    SourceTable = RTCAWLine;
    Caption = 'RTCAWListPart1';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No"; "Line No")
                {
                    Caption = 'Seq No';
                    ApplicationArea = all;
                }

                field(Item; Item)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, Item);
                        if ItemRec.FindSet() then begin
                            UOM := ItemRec."Base Unit of Measure";
                            ItemCode := itemRec."No.";
                        end;
                    end;
                }

                field(UOM; UOM)
                {
                    ApplicationArea = all;
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        interMediRec: Record IntermediateTable;
                    begin
                        interMediRec.Reset();
                        interMediRec.SetRange(No, "Req No");
                        interMediRec.SetRange("Line No", "Header Line No ");
                        interMediRec.SetRange("Split No", "Split No");

                        if interMediRec.FindSet() then begin
                            if interMediRec."Split Qty" < Qty then
                                Error('Return qty cannot be greater than Job Card Qty.');
                        end;
                    end;
                }
            }
        }
    }
}