page 51195 SampleProdLineQCListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Line";
    SourceTableView = where("Sewing Date" = filter(<> ''), "QC Date" = filter(''), Qty = filter(<> 0));

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

                field("Quality Checker"; rec."Quality Checker")
                {
                    ApplicationArea = All;
                    Caption = 'Quality Checker';
                }

                field("QC Hours"; rec."QC Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Production Minutes';

                    trigger OnValidate()
                    var
                    begin
                        if rec."QC Hours" < 0 then
                            Error('QC Minutes is less than zero.');
                    end;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }

                field("QC Date"; rec."QC Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin

                        if rec."Quality Checker" = '' then
                            Error('Select a Quality Checker');

                        if rec."QC Hours" = 0 then
                            Error('QC Minutes is zero');

                        if Rec."Sewing Date" > Rec."QC Date" then
                            Error('QC Date should be greater than Sewing Date');

                        CurrPage.Update();
                    end;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Çomplete';
                    Editable = false;
                }
            }
        }
    }
}
