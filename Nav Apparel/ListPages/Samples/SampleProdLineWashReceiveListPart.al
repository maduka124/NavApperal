page 50439 SampleProdLineReceWashListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Line";
    SourceTableView = where("Send Wash Date" = filter(<> ''), "Received Wash Date" = filter(''));

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
                    Editable = false;
                }

                field("Sewing Date"; "Sewing Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Send Wash Date"; "Send Wash Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Wash Send Date';
                }

                field("Wash Receiver"; "Wash Receiver")
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

                field("Received Wash Date"; "Received Wash Date")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Received Date';

                    trigger OnValidate()
                    var
                        RouterlineRec: Record "Routing Line";
                    begin

                        if "Wash Receiver" = '' then
                            Error('Select a wash Receiver name');

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
            }
        }
    }
}
