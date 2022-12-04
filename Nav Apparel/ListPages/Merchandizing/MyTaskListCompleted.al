page 51049 "My Task Completed"
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
                field("Action User"; rec."Action User")
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

                field("Style No."; rec."Style No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Garment Type';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Action Description"; rec."Action Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Plan Date"; rec."Plan Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Complete; rec.Complete)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("MK Critical"; rec."MK Critical")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Department; rec.Department)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Revise; rec.Revise)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        rec.SetRange("Action User", UserId);
    end;
}