pageextension 50330 WorkCenterExt extends "Work Center Card"
{
    layout
    {
        addafter(Warehouse)
        {
            group("Planning")
            {
                field(MO; MO)
                {
                    ApplicationArea = All;
                    Caption = 'Machine Operators';

                    trigger OnValidate()
                    var

                    begin
                        "Carder" := MO + HP;
                    end;
                }

                field(HP; HP)
                {
                    ApplicationArea = All;
                    Caption = 'Helpers';

                    trigger OnValidate()
                    var

                    begin
                        "Carder" := MO + HP;
                    end;
                }

                field(Carder; Carder)
                {
                    ApplicationArea = All;
                    Caption = 'Total Carders';
                    Editable = false;
                }

                field(PlanEff; PlanEff)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Efficiency (%)';
                }

                field("Department No"; "Department No")
                {
                    ApplicationArea = All;
                    TableRelation = "Department"."No.";

                    trigger OnValidate()
                    var
                        DepartmentRec: Record Department;
                    begin
                        DepartmentRec.get("Department No");
                        "Department Name" := DepartmentRec."Department Name";
                    end;
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Supervisor Name"; "Supervisor Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supervisor';
                }

                field("Factory No."; "Factory No.")
                {
                    ApplicationArea = All;
                    TableRelation = Location.Code;

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                    begin
                        LocationRec.get("Factory No.");
                        "Factory Name" := LocationRec.Name;
                    end;
                }

                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                    Editable = false;
                }

                field(Floor; Floor)
                {
                    ApplicationArea = All;
                    //Caption = 'Supervisor';
                }
            }
        }
    }
}