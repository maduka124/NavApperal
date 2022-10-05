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

                field("Wash Sender"; "Wash Sender")
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


                field("Send Wash Date"; "Send Wash Date")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Send Date';

                    trigger OnValidate()
                    var
                    //RouterlineRec: Record "Routing Line";
                    begin
                        if "Wash Sender" = '' then
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
