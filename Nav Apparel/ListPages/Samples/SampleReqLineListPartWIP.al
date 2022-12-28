page 50431 SampleReqLineListPartWIP
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Seq No';
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

                    trigger OnValidate()
                    var
                    begin
                        if rec."Plan Start Date" < WorkDate() then
                            Error('Start date should be greater than todays date');
                    end;
                }

                field("Plan End Date"; rec."Plan End Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if rec."Plan Start Date" > rec."Plan End Date" then
                            Error('End date should be greater than Start date');

                    end;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Çomplete';
                }

                field("Complete Qty"; rec."Complete Qty")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if (rec.Status = rec.Status::Yes) and (rec."Complete Qty" = 0) then
                            Error('Enter complate qty');

                    end;
                }

                field("Reject Qty"; rec."Reject Qty")
                {
                    ApplicationArea = All;
                }

                field("Reject Comment"; rec."Reject Comment")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if (rec.Status = rec.Status::Reject) and (rec."Reject Qty" = 0) then
                            Error('Enter reject qty');

                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Change Status")
            {
                ApplicationArea = All;
                Image = Status;

                trigger OnAction()
                var
                    SampleReqHeaderRec: Record "Sample Requsition Header";
                    SampleReqLineRec: Record "Sample Requsition Line";
                    WipRec: Record WIP;
                begin

                    SampleReqLineRec.Reset();
                    SampleReqLineRec.SetRange("No.", rec."No.");
                    SampleReqLineRec.SetFilter(Status, '=%1', SampleReqLineRec.Status::No);

                    if not SampleReqLineRec.FindSet() then begin

                        SampleReqHeaderRec.Reset();
                        SampleReqHeaderRec.SetRange("No.", rec."No.");
                        SampleReqHeaderRec.FindSet();
                        SampleReqHeaderRec.ModifyAll(Status, SampleReqHeaderRec.Status::Posted);

                        WipRec.Reset();
                        WipRec.FindSet();
                        WipRec.ModifyAll("Req No.", '');
                    end;

                end;
            }
        }
    }
}