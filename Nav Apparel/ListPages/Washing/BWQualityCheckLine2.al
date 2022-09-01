page 50744 BWQualityCheckLine2
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BWQualityLine2;

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
                    Editable = false;
                }

                field(Defect; Defect)
                {
                    ApplicationArea = all;
                }

                // field(Status; Status)
                // {
                //     ApplicationArea = all;

                //     trigger OnValidate()
                //     var
                //         BWQualityHeaderRec: Record BWQualityCheckHeader;
                //         BWQualityLine1Rec: Record BWQualityLine2;
                //         CountRec: Integer;
                //     begin

                //         BWQualityHeaderRec.Reset();
                //         BWQualityHeaderRec.SetRange("No.", No);

                //         if BWQualityHeaderRec.FindSet() then begin
                //             "Sample Req No" := BWQualityHeaderRec."Sample Req No";
                //             "Line No. Header" := BWQualityHeaderRec."Line No";
                //         end;

                //         CurrPage.Update();
                //         CountRec := 0;
                //         BWQualityLine1Rec.Reset();
                //         BWQualityLine1Rec.SetRange(No, No);
                //         BWQualityLine1Rec.SetRange("Line No. Header", "Line No. Header");
                //         BWQualityLine1Rec.SetFilter(Status, '%1', BWQualityLine1Rec.Status::Pass);

                //         if BWQualityLine1Rec.FindSet() then
                //             CountRec := BWQualityLine1Rec.Count;

                //         if CountRec > 1 then
                //             Error('Please select only one pass item');
                //     end;
                // }

                field(Qty; Qty)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        //WashSampleReqlineRec: Record "Washing Sample Requsition Line";
                        BWQualityHeaderRec: Record BWQualityCheckHeader;
                    //BWQualityLine2Rec: Record BWQualityLine2;
                    //Quantity: Integer;
                    begin
                        BWQualityHeaderRec.Reset();
                        BWQualityHeaderRec.SetRange("No.", No);

                        if BWQualityHeaderRec.FindSet() then begin
                            "Sample Req No" := BWQualityHeaderRec."Sample Req No";
                            "Line No. Header" := BWQualityHeaderRec."Line No";
                        end;

                        CurrPage.Update();
                        // WashSampleReqlineRec.Reset();
                        // WashSampleReqlineRec.SetRange("No.", "Sample Req No");
                        // WashSampleReqlineRec.SetRange("Line no.", "Line No. Header");

                        // if WashSampleReqlineRec.Findset() then begin

                        //     BWQualityLine2Rec.Reset();
                        //     BWQualityLine2Rec.SetRange("Sample Req No", WashSampleReqlineRec."No.");
                        //     BWQualityLine2Rec.SetRange("Line No. Header", WashSampleReqlineRec."Line no.");

                        //     if BWQualityLine2Rec.FindSet() then
                        //         repeat
                        //             Quantity += BWQualityLine2Rec.Qty;
                        //         until BWQualityLine2Rec.Next() = 0;

                        //     if Quantity > WashSampleReqlineRec."Req Qty" then
                        //         Error('Total Qty must be equal to requested Qty');

                        //     if Qty > WashSampleReqlineRec."Req Qty" then
                        //         Error('Qty must be less than or equal to requested Qty');
                        // end;
                    end;
                }

                field(Comment; Comment)
                {
                    ApplicationArea = all;
                }

                // field(State; State)
                // {
                //     ApplicationArea = all;
                //     Caption = 'State/Process';
                // }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        inx: Integer;
    begin
        "Line No" := xRec."Line No" + 1;
    end;
}