page 50436 SampleProdLineCutListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Line";
    SourceTableView = where("Pattern Date" = filter(<> ''), "Cutting Date" = filter(''));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Request No';
                    Editable = false;
                }

                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Seq No';
                }

                field("Group Head"; "Group Head")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field("Sample Name"; "Sample Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Sample';
                }

                field("Fabrication Name"; "Fabrication Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Fabrication';
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Color';
                }

                field(Size; Size)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Req Date"; "Req Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Comment; Comment)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Plan Start Date"; "Plan Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Plan End Date"; "Plan End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    Caption = 'Çomplete';
                    Editable = false;
                }

                field("Pattern Date"; "Pattern Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Cutting Date"; "Cutting Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var

                    begin
                        if format("Cutting Date") <> '' then
                            CurrPage.Update();
                    end;
                }

                field("Production Hours"; "Production Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Production Hours';

                    trigger OnValidate()
                    var
                    begin
                        if "Production Hours" < 0 then
                            Error('Production Hours is less than zero.');
                    end;
                }
            }
        }
    }
}
