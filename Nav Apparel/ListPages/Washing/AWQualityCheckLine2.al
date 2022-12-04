page 50745 aWQualityChecklist2
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    AutoSplitKey = true;
    SourceTable = AWQualityCheckLine;

    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("Line No"; rec."Line No")
                {
                    Caption = 'Seq No';
                    ApplicationArea = all;
                    Editable = false;
                }

                field(Defect; rec.Defect)
                {
                    ApplicationArea = all;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        QCAWRec: Record AWQualityCheckHeader;
                    //QCLine2tableAWRec: Record AWQualityCheckLine;
                    //CountRec: Integer;
                    //intermidiateRec: Record IntermediateTable;
                    //Quantity: Integer;
                    begin

                        QCAWRec.Reset();
                        QCAWRec.SetRange("No.", rec.No);

                        if QCAWRec.FindSet() then begin
                           rec. "Sample Req No" := QCAWRec."Sample Req No";
                           rec. "Line No. Header" := QCAWRec."Line No";
                            rec."Split No" := QCAWRec."Split No";
                        end;

                        CurrPage.Update();
                        // intermidiateRec.Reset();
                        // intermidiateRec.SetRange(No, "Sample Req No");
                        // intermidiateRec.SetRange("Line no", "Line No. Header");
                        // intermidiateRec.SetRange("Split No", "Split No");

                        // if intermidiateRec.Findset() then begin

                        // QCLine2tableAWRec.Reset();
                        // QCLine2tableAWRec.SetRange("No", "No");
                        // QCLine2tableAWRec.SetRange("Sample Req No", intermidiateRec."No");
                        // QCLine2tableAWRec.SetRange("Line No. Header", intermidiateRec."Line No");
                        // QCLine2tableAWRec.SetRange("Split No", intermidiateRec."Split No");

                        // if QCLine2tableAWRec.FindSet() then
                        //     repeat
                        //         Quantity += QCLine2tableAWRec.Qty;
                        //     until QCLine2tableAWRec.Next() = 0;

                        // if Quantity > intermidiateRec."Split Qty" then
                        //     Error('Total Qty must be equal to Job Card Qty');

                        // if Qty > intermidiateRec."Split Qty" then
                        //     Error('Qty must be less than or equal to Job Card Qty');
                        //end;
                    end;
                }

                field(Comment; rec.Comment)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}