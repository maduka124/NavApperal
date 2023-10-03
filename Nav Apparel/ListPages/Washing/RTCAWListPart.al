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
                field("Line No"; rec."Line No")
                {
                    Caption = 'Seq No';
                    ApplicationArea = all;
                }

                field(Item; rec.Item)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, rec.Item);
                        if ItemRec.FindSet() then begin
                            rec.UOM := ItemRec."Base Unit of Measure";
                            rec.ItemCode := itemRec."No.";
                        end;
                    end;
                }

                field(UOM; rec.UOM)
                {
                    ApplicationArea = all;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        interMediRec: Record IntermediateTable;
                    begin
                        interMediRec.Reset();
                        interMediRec.SetRange(No, rec."Req No");
                        interMediRec.SetRange("Line No", rec."Header Line No");
                        interMediRec.SetRange("Split No", rec."Split No");

                        if interMediRec.FindSet() then begin
                            if interMediRec."Split Qty" < rec.Qty then
                                Error('Return qty cannot be greater than Job Card Qty.');
                        end;
                    end;
                }
            }
        }
    }
}