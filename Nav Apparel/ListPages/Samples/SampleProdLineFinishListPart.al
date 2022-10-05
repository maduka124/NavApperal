page 50800 SampleProdLineFinishListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Line";
    SourceTableView = where("Received Wash Date" = filter(<> ''), "Finishing Date" = filter(''));

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

                field("Received Wash Date"; "Received Wash Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Wash Received Date';
                }

                field("Finishing Operator"; "Finishing Operator")
                {
                    ApplicationArea = All;
                }

                field("Finishing Hours"; "Finishing Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Finishing Minutes';

                    trigger OnValidate()
                    var
                        WorkCenterRec: Record "Work Center";
                        RouterRec: Record "Routing Header";
                    begin
                        if "Finishing Hours" < 0 then
                            Error('Finishing Minutes is less than zero.');

                        //Asign Work center
                        WorkCenterRec.Reset();
                        WorkCenterRec.SetRange(Name, 'SM-FINISHING');

                        if WorkCenterRec.FindSet() then begin
                            "Finishing Work center Code" := WorkCenterRec."No.";
                            "Finishing Work center Name" := WorkCenterRec.Name;
                        end;

                        //Get Sample Router Name
                        RouterRec.Reset();
                        RouterRec.SetFilter("Sample Router", '=%1', true);

                        if RouterRec.FindSet() then
                            "Routing Code" := RouterRec."No.";

                    end;
                }


                field("Finishing Date"; "Finishing Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        RouterlineRec: Record "Routing Line";
                    begin
                        if "Finishing Operator" = '' then
                            Error('Select a  Finishing Operator');

                        if "Finishing Hours" = 0 then
                            Error('Finishing Minutes is zero');

                        if "Finishing Work center Name" = '' then
                            Error('Select a Router/Work Center');

                        if format("Finishing Date") <> '' then begin
                            RouterlineRec.Reset();
                            RouterlineRec.SetRange("Routing No.", "Routing Code");
                            RouterlineRec.SetRange("No.", "Finishing Work center Code");
                            if RouterlineRec.FindSet() then begin
                                RouterlineRec."Run Time" := "Finishing Hours";
                                RouterlineRec.Modify();
                                CurrPage.Update();
                            end
                            else
                                Error('Cannot find Routing details');
                        end;
                    end;
                }
            }
        }
    }
}
