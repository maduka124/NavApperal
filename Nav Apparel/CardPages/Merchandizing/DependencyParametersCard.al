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
                field("Dependency Group"; rec."Dependency Group")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DependencyGroupRec: Record "Dependency Group";
                    begin
                        DependencyGroupRec.Reset();
                        DependencyGroupRec.SetRange("Dependency Group", rec."Dependency Group");
                        if DependencyGroupRec.FindSet() then
                            rec."Dependency Group No." := DependencyGroupRec."No.";
                    end;
                }

                field("Action Type"; rec."Action Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ActionTypeRec: Record "Action Type";
                    begin
                        ActionTypeRec.Reset();
                        ActionTypeRec.SetRange("Action Type", rec."Action Type");
                        if ActionTypeRec.FindSet() then
                            rec."Action Type No." := ActionTypeRec."No.";
                    end;
                }

                field("Action Description"; rec."Action Description")
                {
                    ApplicationArea = All;
                }

                field("Gap Days"; rec."Gap Days")
                {
                    ApplicationArea = All;
                    Caption = 'Gap Days (Based on BPCD)';
                }

                field(Department; rec.Department)
                {
                    ApplicationArea = All;
                    Caption = 'Action belongs to Department';

                    trigger OnValidate()
                    var
                        DepartmentRec: Record Department;
                    begin
                        DepartmentRec.Reset();
                        DepartmentRec.SetRange("Department Name", rec.Department);
                        if DepartmentRec.FindSet() then
                            rec."Department No." := DepartmentRec."No.";
                    end;
                }
            }
        }
    }
}