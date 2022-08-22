page 71012601 "Department(Style) Card"
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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Department No';
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DepartmentRec: Record "Department Style";
                    begin
                        DepartmentRec.Reset();
                        DepartmentRec.SetRange("Department Name", "Department Name");
                        if DepartmentRec.FindSet() then
                            Error('Department name already exists.');
                    end;
                }
            }
        }
    }
}