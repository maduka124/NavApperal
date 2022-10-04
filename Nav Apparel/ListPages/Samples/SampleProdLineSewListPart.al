page 50437 SampleProdLineSewListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Line";
    SourceTableView = where("Cutting Date" = filter(<> ''), "Sewing Date" = filter(''));

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

                field("Sewing Operator"; "Sewing Operator")
                {
                    ApplicationArea = All;
                }

                field("Sewing Hours"; "Sewing Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Sewing Minutes';

                    trigger OnValidate()
                    var
                        WorkCenterRec: Record "Work Center";
                        RouterRec: Record "Routing Header";
                    begin
                        if "Sewing Hours" < 0 then
                            Error('Sewing Minutes is less than zero.');

                        //Asign Work center
                        WorkCenterRec.Reset();
                        WorkCenterRec.SetRange(Name, 'SM-SEWING');

                        if WorkCenterRec.FindSet() then begin
                            "Sew Work center Code" := WorkCenterRec."No.";
                            "Sew Work center Name" := WorkCenterRec.Name;
                        end;

                        //Get Sample Router Name
                        RouterRec.Reset();
                        RouterRec.SetFilter("Sample Router", '=%1', true);

                        if RouterRec.FindSet() then
                            "Routing Code" := RouterRec."No.";

                    end;
                }


                field("Sewing Date"; "Sewing Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        RouterlineRec: Record "Routing Line";
                    begin
                        if "Sewing Operator" = '' then
                            Error('Select a  Sewing Operator');

                        if "Sewing Hours" = 0 then
                            Error('Sewing Minutes is zero');

                        if "Sew Work center Name" = '' then
                            Error('Select a Router/Work Center');

                        if format("Sewing Date") <> '' then begin
                            RouterlineRec.Reset();
                            RouterlineRec.SetRange("Routing No.", "Routing Code");
                            RouterlineRec.SetRange("No.", "Sew Work center Code");
                            if RouterlineRec.FindSet() then begin
                                RouterlineRec."Run Time" := "Sewing Hours";
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
