page 50951 "Department(Style) Card"
{
    PageType = Card;
    SourceTable = "Department Style";
    Caption = 'Department(Style)';

    layout
    {

        area(Content)
        {
            group(General)
            {
                field("No.";rec. "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Department No';
                }

                field("Department Name";rec. "Department Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DepartmentRec: Record "Department Style";
                    begin
                        DepartmentRec.Reset();
                        DepartmentRec.SetRange("Department Name", rec."Department Name");
                        if DepartmentRec.FindSet() then
                            Error('Department name already exists.');
                    end;
                }
            }
        }
    }
}