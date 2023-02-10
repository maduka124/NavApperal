page 50436 SampleProdLineCutListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Line";
    SourceTableView = where("Pattern/Cutting Date" = filter(<> ''), "Cutting Date" = filter(''));

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

                // Done By Sachith On 09/02/23
                field("Brand Name"; Rec."Brand Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Brand';
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

                field(Cutter; rec.Cutter)
                {
                    ApplicationArea = All;
                }

                field("Cuting Hours"; rec."Cuting Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Cuting Minutes';

                    trigger OnValidate()
                    var
                        WorkCenterRec: Record "Work Center";
                        RouterRec: Record "Routing Header";
                    begin
                        if rec."Cuting Hours" < 0 then
                            Error('Cuting Minutes is less than zero.');

                        //Asign Work center
                        WorkCenterRec.Reset();
                        WorkCenterRec.SetRange(Name, 'SM-CUTTING');

                        if WorkCenterRec.FindSet() then begin
                            rec."Cut Work center Code" := WorkCenterRec."No.";
                            rec."Cut Work center Name" := WorkCenterRec.Name;
                        end;

                        //Get Sample Router Name
                        RouterRec.Reset();
                        RouterRec.SetFilter("Sample Router", '=%1', true);

                        if RouterRec.FindSet() then
                            rec."Routing Code" := RouterRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("Cutting Date"; rec."Cutting Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        RouterlineRec: Record "Routing Line";
                    begin
                        if rec.Cutter = '' then
                            Error('Select a cutter name');

                        if rec."Cuting Hours" = 0 then
                            Error('Cuting Minutes is zero');

                        if rec."Cut Work center Name" = '' then
                            Error('Select a Router/Work Center');

                        if format(rec."Cutting Date") <> '' then begin
                            RouterlineRec.Reset();
                            RouterlineRec.SetRange("Routing No.", rec."Routing Code");
                            RouterlineRec.SetRange("No.", rec."Cut Work center Code");
                            if RouterlineRec.FindSet() then begin
                                RouterlineRec."Run Time" := rec."Cuting Hours";
                                RouterlineRec.Modify();
                                CurrPage.Update();
                            end
                            else
                                Error('Cannot find Routing details');
                        end;
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
