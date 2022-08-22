page 71012709 "Dependency Parameters Card"
{
    PageType = Card;
    SourceTable = "Dependency Parameters";
    Caption = 'Dependency Parameters';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Dependency Group"; "Dependency Group")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DependencyGroupRec: Record "Dependency Group";
                    begin
                        DependencyGroupRec.Reset();
                        DependencyGroupRec.SetRange("Dependency Group", "Dependency Group");
                        if DependencyGroupRec.FindSet() then
                            "Dependency Group No." := DependencyGroupRec."No.";
                    end;
                }

                field("Action Type"; "Action Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ActionTypeRec: Record "Action Type";
                    begin
                        ActionTypeRec.Reset();
                        ActionTypeRec.SetRange("Action Type", "Action Type");
                        if ActionTypeRec.FindSet() then
                            "Action Type No." := ActionTypeRec."No.";
                    end;
                }

                field("Action Description"; "Action Description")
                {
                    ApplicationArea = All;
                }

                field("Gap Days"; "Gap Days")
                {
                    ApplicationArea = All;
                    Caption = 'Gap Days (Based on BPCD)';
                }

                field(Department; Department)
                {
                    ApplicationArea = All;
                    Caption = 'Action belongs to Department';

                    trigger OnValidate()
                    var
                        DepartmentRec: Record Department;
                    begin
                        DepartmentRec.Reset();
                        DepartmentRec.SetRange("Department Name", Department);
                        if DepartmentRec.FindSet() then
                            "Department No." := DepartmentRec."No.";
                    end;
                }
            }
        }
    }
}