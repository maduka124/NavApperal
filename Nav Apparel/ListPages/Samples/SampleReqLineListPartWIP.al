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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Seq No';
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
                }

                field("Plan End Date"; "Plan End Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if "Plan Start Date" > "Plan End Date" then
                            Error('Start date is greater than end date');

                    end;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    Caption = 'Çomplete';
                }

                field("Complete Qty"; "Complete Qty")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if (Status = Status::Yes) and ("Complete Qty" = 0) then
                            Error('Enter complate qty');

                    end;
                }

                field("Reject Qty"; "Reject Qty")
                {
                    ApplicationArea = All;
                }

                field("Reject Comment"; "Reject Comment")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if (Status = Status::Reject) and ("Reject Qty" = 0) then
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
                    SampleReqLineRec.SetRange("No.", "No.");
                    SampleReqLineRec.SetFilter(Status, '=%1', SampleReqLineRec.Status::No);

                    if not SampleReqLineRec.FindSet() then begin

                        SampleReqHeaderRec.Reset();
                        SampleReqHeaderRec.SetRange("No.", "No.");
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