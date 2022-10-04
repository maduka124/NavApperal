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

                field(Cutter; Cutter)
                {
                    ApplicationArea = All;
                }

                field("Cuting Hours"; "Cuting Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Cuting Minutes';

                    trigger OnValidate()
                    var
                        WorkCenterRec: Record "Work Center";
                        RouterRec: Record "Routing Header";
                    begin
                        if "Cuting Hours" < 0 then
                            Error('Cuting Minutes is less than zero.');

                        //Asign Work center
                        WorkCenterRec.Reset();
                        WorkCenterRec.SetRange(Name, 'SM-CUTTING');

                        if WorkCenterRec.FindSet() then begin
                            "Cut Work center Code" := WorkCenterRec."No.";
                            "Cut Work center Name" := WorkCenterRec.Name;
                        end;

                        //Get Sample Router Name
                        RouterRec.Reset();
                        RouterRec.SetFilter("Sample Router", '=%1', true);

                        if RouterRec.FindSet() then
                            "Routing Code" := RouterRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("Cutting Date"; "Cutting Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        RouterlineRec: Record "Routing Line";
                    begin
                        if Cutter = '' then
                            Error('Select a cutter name');

                        if "Cuting Hours" = 0 then
                            Error('Cuting Minutes is zero');

                        if "Cut Work center Name" = '' then
                            Error('Select a Router/Work Center');

                        if format("Cutting Date") <> '' then begin
                            RouterlineRec.Reset();
                            RouterlineRec.SetRange("Routing No.", "Routing Code");
                            RouterlineRec.SetRange("No.", "Cut Work center Code");
                            if RouterlineRec.FindSet() then begin
                                RouterlineRec."Run Time" := "Cuting Hours";
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
