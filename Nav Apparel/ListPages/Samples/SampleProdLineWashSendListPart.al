page 50438 SampleProdLineSendWashListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Line";
    SourceTableView = where("Sewing Date" = filter(<> ''), "Send Wash Date" = filter(''));

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

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Çomplete';
                    Editable = false;
                }

                field("Pattern Date"; rec."Pattern Date")
                {
                    ApplicationArea = All;
                    Editable = false;
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

                field("Wash Sender"; rec."Wash Sender")
                {
                    ApplicationArea = All;
                }

                // field("wash send Hours"; "wash send Hours")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Wash Send Minutes';

                //     trigger OnValidate()
                //     var
                //     begin
                //         if "Wash Send Hours" < 0 then
                //             Error('Wash Send Minutes is less than zero.');
                //     end;
                // }

                // field("Wash Send Work center Name"; "Wash Send Work center Name")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Router/Work center';

                //     trigger OnValidate()
                //     var
                //         WorkCenterRec: Record "Work Center";
                //     begin
                //         WorkCenterRec.Reset();
                //         WorkCenterRec.SetRange(Name, "Wash Send Work center Name");

                //         if WorkCenterRec.FindSet() then
                //             "Wash Send Work center Code" := WorkCenterRec."No.";
                //     end;
                // }


                field("Send Wash Date"; rec."Send Wash Date")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Send Date';

                    trigger OnValidate()
                    var
                    //RouterlineRec: Record "Routing Line";
                    begin
                        if rec."Wash Sender" = '' then
                            Error('Select a wash sender name');

                        CurrPage.Update();

                        // if "Wash Send Hours" = 0 then
                        //     Error('Wash Send Minutes is zero');

                        // if "Wash Send Work center Name" = '' then
                        //     Error('Select a Router/Work Center');

                        // if format("Send Wash Date") <> '' then begin
                        //     RouterlineRec.Reset();
                        //     RouterlineRec.SetRange("Routing No.", "Routing Code");
                        //     RouterlineRec.SetRange("No.", "Wash Send Work center Code");
                        //     if RouterlineRec.FindSet() then begin
                        //         RouterlineRec."Run Time" := "Wash Send Hours";
                        //         RouterlineRec.Modify();
                        //         CurrPage.Update();
                        //     end
                        //     else
                        //         Error('Cannot find Routing details');
                        // end;
                    end;
                }
            }
        }
    }
}
