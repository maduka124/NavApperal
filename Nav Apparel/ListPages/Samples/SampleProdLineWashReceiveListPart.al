page 50439 SampleProdLineReceWashListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Line";
    SourceTableView = where("Send Wash Date" = filter(<> ''), "Received Wash Date" = filter(''), Qty = filter(<> 0));

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

                field("Wash Receiver"; rec."Wash Receiver")
                {
                    ApplicationArea = All;
                }

                // field("Wash Receive Hours"; "Wash Receive Hours")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Wash Receive Minutes';

                //     trigger OnValidate()
                //     var
                //     begin
                //         if "Wash Receive Hours" < 0 then
                //             Error('Wash Receive Minutes is less than zero.');
                //     end;
                // }

                // field("Wash Receive Work center Name"; "Wash Receive Work center Name")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Router/Work center';

                //     trigger OnValidate()
                //     var
                //         WorkCenterRec: Record "Work Center";
                //     begin
                //         WorkCenterRec.Reset();
                //         WorkCenterRec.SetRange(Name, "Wash Receive Work center Name");

                //         if WorkCenterRec.FindSet() then
                //             "Wash Receive Work center Code" := WorkCenterRec."No.";
                //     end;
                // }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }

                field("Received Wash Date"; rec."Received Wash Date")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Received Date';

                    trigger OnValidate()
                    var
                    //RouterlineRec: Record "Routing Line";
                    begin

                        if rec."Wash Receiver" = '' then
                            Error('Select a wash Receiver name');

                        if Rec."Send Wash Date" > Rec."Received Wash Date" then
                            Error('Received Wash Date should be greater than Send Wash Date');

                        CurrPage.Update();

                        // if "Wash Receive Hours" = 0 then
                        //     Error('Wash Receive Minutes is zero');

                        // if "Wash Receive Work center Name" = '' then
                        //     Error('Select a Router/Work Center');

                        // if format("Received Wash Date") <> '' then begin
                        //     RouterlineRec.Reset();
                        //     RouterlineRec.SetRange("Routing No.", "Routing Code");
                        //     RouterlineRec.SetRange("No.", "Wash Receive Work center Code");
                        //     if RouterlineRec.FindSet() then begin
                        //         RouterlineRec."Run Time" := "Wash Receive Hours";
                        //         RouterlineRec.Modify();
                        //         CurrPage.Update();
                        //     end
                        //     else
                        //         Error('Cannot find Routing details');
                        // end;
                    end;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Çomplete';
                    // Editable = false;
                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                    end;
                }
            }
        }
    }
}
