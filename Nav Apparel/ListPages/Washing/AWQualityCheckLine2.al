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
                field("Line No"; "Line No")
                {
                    Caption = 'Seq No';
                    ApplicationArea = all;
                    Editable = false;
                }

                field(Status; Status)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        QCAWRec: Record AWQualityCheckHeader;
                        QCLine2tableAWRec: Record AWQualityCheckLine;
                        CountRec: Integer;
                    begin

                        QCAWRec.Reset();
                        QCAWRec.SetRange("No.", No);

                        if QCAWRec.FindSet() then begin
                            "Sample Req No" := QCAWRec."Sample Req No";
                            "Line No. Header" := QCAWRec."Line No";
                            "Split No" := QCAWRec."Split No";
                        end;

                        CurrPage.Update();
                        CountRec := 0;
                        QCLine2tableAWRec.Reset();
                        QCLine2tableAWRec.SetRange(No, No);
                        QCLine2tableAWRec.SetRange("Line No. Header", "Line No. Header");
                        QCLine2tableAWRec.SetFilter(Status, '%1', QCLine2tableAWRec.Status::Pass);

                        if QCLine2tableAWRec.FindSet() then
                            CountRec := QCLine2tableAWRec.Count;

                        if CountRec > 1 then
                            Error('Please select only one pass item');
                    end;
                }

                field(Qty; Qty)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        QCAWRec: Record AWQualityCheckHeader;
                        QCLine2tableAWRec: Record AWQualityCheckLine;
                        CountRec: Integer;
                        intermidiateRec: Record IntermediateTable;
                        Quantity: Integer;
                    begin

                        QCAWRec.Reset();
                        QCAWRec.SetRange("No.", No);

                        if QCAWRec.FindSet() then begin
                            "Sample Req No" := QCAWRec."Sample Req No";
                            "Line No. Header" := QCAWRec."Line No";
                            "Split No" := QCAWRec."Split No";
                        end;

                        CurrPage.Update();
                        intermidiateRec.Reset();
                        intermidiateRec.SetRange(No, "Sample Req No");
                        intermidiateRec.SetRange("Line no", "Line No. Header");
                        intermidiateRec.SetRange("Split No", "Split No");

                        if intermidiateRec.Findset() then begin

                            QCLine2tableAWRec.Reset();
                            QCLine2tableAWRec.SetRange("No", "No");
                            QCLine2tableAWRec.SetRange("Sample Req No", intermidiateRec."No");
                            QCLine2tableAWRec.SetRange("Line No. Header", intermidiateRec."Line No");
                            QCLine2tableAWRec.SetRange("Split No", intermidiateRec."Split No");

                            if QCLine2tableAWRec.FindSet() then
                                repeat
                                    Quantity += QCLine2tableAWRec.Qty;
                                until QCLine2tableAWRec.Next() = 0;

                            if Quantity > intermidiateRec."Split Qty" then
                                Error('Total Qty must be equal to Job Card Qty');

                            if Qty > intermidiateRec."Split Qty" then
                                Error('Qty must be less than or equal to Job Card Qty');
                        end;
                    end;
                }

                field(Defect; Defect)
                {
                    ApplicationArea = all;
                }

                field(Comment; Comment)
                {
                    ApplicationArea = all;
                }

                field(State; State)
                {
                    ApplicationArea = all;
                    Caption = 'State/Process';
                }
            }
        }
    }
}