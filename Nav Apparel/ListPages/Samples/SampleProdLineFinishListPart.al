page 50800 SampleProdLineFinishListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Line";
    SourceTableView = where("Received Wash Date" = filter(<> ''), "Finishing Date" = filter(''), Qty = filter(<> 0));

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

                field("Finishing Operator"; rec."Finishing Operator")
                {
                    ApplicationArea = All;
                }

                field("Finishing Hours"; rec."Finishing Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Finishing Minutes';

                    trigger OnValidate()
                    var
                        WorkCenterRec: Record "Work Center";
                        RouterRec: Record "Routing Header";
                    begin
                        if rec."Finishing Hours" < 0 then
                            Error('Finishing Minutes is less than zero.');

                        //Asign Work center
                        WorkCenterRec.Reset();
                        WorkCenterRec.SetRange(Name, 'SM-FINISHING');

                        if WorkCenterRec.FindSet() then begin
                            rec."Finishing Work center Code" := WorkCenterRec."No.";
                            rec."Finishing Work center Name" := WorkCenterRec.Name;
                        end;

                        //Get Sample Router Name
                        RouterRec.Reset();
                        RouterRec.SetFilter("Sample Router", '=%1', true);

                        if RouterRec.FindSet() then
                            rec."Routing Code" := RouterRec."No.";

                    end;
                }

                field("Finishing Date"; rec."Finishing Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        RouterlineRec: Record "Routing Line";
                    begin
                        if rec."Finishing Operator" = '' then
                            Error('Select a  Finishing Operator');

                        if rec."Finishing Hours" = 0 then
                            Error('Finishing Minutes is zero');

                        if rec."Finishing Work center Name" = '' then
                            Error('Select a Router/Work Center');

                        if Rec."Received Wash Date" > Rec."Finishing Date" then
                            Error('Finishing Date should be greater than Received Wash Date');

                        if format(rec."Finishing Date") <> '' then begin
                            RouterlineRec.Reset();
                            RouterlineRec.SetRange("Routing No.", rec."Routing Code");
                            RouterlineRec.SetRange("No.", rec."Finishing Work center Code");
                            if RouterlineRec.FindSet() then begin
                                RouterlineRec."Run Time" := rec."Finishing Hours";
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
