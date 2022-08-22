page 71012784 "My Task Completed"
{
    PageType = ListPart;
    SourceTable = "Dependency Style Line";
    SourceTableView = where(Complete = filter(true));
    UsageCategory = Lists;
    Editable = false;

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
                    Editable = false;
                }

                field("MK Critical"; "MK Critical")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                    Editable = false;
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
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetRange("Action User", UserId);
    end;
}