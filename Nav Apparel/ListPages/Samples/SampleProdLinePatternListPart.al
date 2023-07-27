page 50435 SampleProdLinePatternListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Line";
    SourceTableView = where("Pattern Date" = filter(''), Qty = filter(<> 0), "Plan Start Date" = filter(<> 0D), "Plan End Date" = filter(<> 0D));

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

                field("Pattern Maker"; rec."Pattern Maker")
                {
                    ApplicationArea = All;
                }

                field("Pattern Hours"; rec."Pattern Hours")
                {
                    ApplicationArea = All;
                    Caption = 'Production Minutes';

                    trigger OnValidate()
                    var
                        WorkCenterRec: Record "Work Center";
                        RouterRec: Record "Routing Header";
                    begin
                        if rec."Pattern Hours" < 0 then
                            Error('Pattern Minutes is less than zero.');

                        //Asign Work center
                        WorkCenterRec.Reset();
                        WorkCenterRec.SetRange(Name, 'SM-PATTERN');
                        if WorkCenterRec.FindSet() then begin
                            rec."Pattern Work center Code" := WorkCenterRec."No.";
                            rec."Pattern Work center Name" := WorkCenterRec.Name;
                        end;

                        //Get Sample Router Name
                        RouterRec.Reset();
                        RouterRec.SetFilter("Sample Router", '=%1', true);
                        if RouterRec.FindSet() then
                            rec."Routing Code" := RouterRec."No.";

                        CurrPage.Update();
                    end;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }

                field("Pattern Date"; rec."Pattern Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        RouterlineRec: Record "Routing Line";
                    begin
                        if Rec."Plan Start Date" = 0D then
                            Error('Please Enter Plan Start Date');

                        if Rec."Plan End Date" = 0D then
                            Error('Please Enter Plan End Date');

                        if rec."Pattern Maker" = '' then
                            Error('Select a Pattern Maker');

                        if rec."Pattern Hours" = 0 then
                            Error('Pattern Minutes is zero');

                        if rec."Pattern Work center Name" = '' then
                            Error('Select a Router/Work Center');

                        if Rec."Plan Start Date" > Rec."Pattern Date" then
                            Error('Pattern Date should be greater than Start date');

                        if format(rec."Pattern Date") <> '' then begin
                            RouterlineRec.Reset();
                            RouterlineRec.SetRange("Routing No.", rec."Routing Code");
                            RouterlineRec.SetRange("No.", rec."Pattern Work center Code");
                            if RouterlineRec.FindSet() then begin
                                RouterlineRec."Run Time" := rec."Pattern Hours";
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

    trigger OnOpenPage()
    begin
        Rec.SetRange("Created Date", 20230723D, Today);
    end;
}