page 51196 SampleProdLineQCFinishListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Line";
    SourceTableView = where("Finishing Date" = filter(<> ''), "QC/Finishing Date" = filter(''));

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

                field("QC/Finishing Date"; rec."QC/Finishing Date")
                {
                    Caption = 'QC Finishing Date';
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
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
