page 51196 SampleProdLineQCFinishListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Line";
    SourceTableView = where("Finishing Date" = filter(<> ''), Qty = filter(<> 0), Status = filter(0));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Request No';
                    Editable = false;
                }

                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Seq No';
                }

                field("Group Head"; rec."Group Head")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                // Done By Sachith On 09/02/23
                field("Brand Name"; Rec."Brand Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Brand';
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field("Garment Type"; rec."Garment Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sample Name"; rec."Sample Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Sample';
                }

                field("Fabrication Name"; rec."Fabrication Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Fabrication';
                }

                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Color';
                }

                field(Size; rec.Size)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Req Date"; rec."Req Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Comment; rec.Comment)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Plan Start Date"; rec."Plan Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Plan End Date"; rec."Plan End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Pattern Date"; rec."Pattern Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Pattern/Cutting Date"; rec."Pattern/Cutting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Pattern Cutting Date';
                }

                field("Cutting Date"; rec."Cutting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sewing Date"; rec."Sewing Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("QC Date"; rec."QC Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Send Wash Date"; rec."Send Wash Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Wash Send Date';
                }

                field("Received Wash Date"; rec."Received Wash Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Wash Received Date';
                }

                field("Finishing Date"; rec."Finishing Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Quality Finish Checker"; rec."Quality Finish Checker")
                {
                    ApplicationArea = All;
                    Caption = 'QC Finish Operator';
                }

                field("QC Finish Hours"; rec."QC Finish Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Production Minutes';

                    trigger OnValidate()
                    var
                    begin
                        if rec."QC Finish Hours" < 0 then
                            Error('QC Finish Minutes is less than zero.');
                    end;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }

                field("QC/Finishing Date"; rec."QC/Finishing Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if rec."Quality Finish Checker" = '' then
                            Error('Select a QC Finish Operator');

                        if rec."QC Finish Hours" = 0 then
                            Error('QC Finish Minutes is zero');

                        if Rec."Finishing Date" > Rec."QC/Finishing Date" then
                            Error('QC/Finishing Date should be greater than Finishing Date');

                        CurrPage.Update();
                    end;
                }

                field("Complete Qty"; rec."Complete Qty")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if Rec."Complete Qty" > Rec.Qty then
                            Error('Complete qty should be leass than req qty');

                        if Rec."Complete Qty" + Rec."Reject Qty" > Rec.Qty then
                            Error('Complete qty and reject qty total should be less than req Qty');

                        if (rec.Status = rec.Status::Yes) and (rec."Complete Qty" = 0) then
                            Error('Enter complate qty');
                    end;
                }

                field("Reject Qty"; rec."Reject Qty")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if Rec."Reject Qty" > Rec.Qty then
                            Error('Reject qty Should be less than req qty');

                        if Rec."Complete Qty" + Rec."Reject Qty" > Rec.Qty then
                            Error('Complete qty and reject qty total should be less than req qty');
                    end;
                }

                field("Reject Comment"; rec."Reject Comment")
                {
                    ApplicationArea = All;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Çomplete';
                    // Editable = false;

                    trigger OnValidate()
                    var
                    begin
                        if (rec.Status = rec.Status::Reject) and (rec."Reject Qty" = 0) then
                            Error('Enter reject qty.');

                        if (rec.Status = rec.Status::Yes) and (rec."Complete Qty" = 0) then
                            Error('Enter complete qty.');

                        if (rec.Status = rec.Status::Reject) and (rec."Reject Comment" = '') then
                            Error('Enter reject comment.');

                        CurrPage.Update();
                    end;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("Created Date", 20230723D, Today);
    end;
}
