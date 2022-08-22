page 71012783 "My Task Pending"
{
    PageType = ListPart;
    SourceTable = "Dependency Style Line";
    SourceTableView = where(Complete = filter(false));
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Action User"; "Action User")
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

                field("Style No."; "Style No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field("Garment Type Name"; "Garment Type Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Garment Type';
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Action Description"; "Action Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Plan Date"; "Plan Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Complete; Complete)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("MK Critical"; "MK Critical")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field(Department; Department)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Revise; Revise)
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnAssistEdit()
                    var
                        MyTaskRevise: Page "MyTask Revise Card";
                    begin

                        Clear(MyTaskRevise);
                        MyTaskRevise.LookupMode(true);
                        MyTaskRevise.PassParameters("Style No.", "Line No.", "Buyer No.");
                        MyTaskRevise.RunModal();

                    end;
                }

            }
        }
    }

    trigger OnOpenPage()
    begin
        SetRange("Action User", UserId);
    end;
}