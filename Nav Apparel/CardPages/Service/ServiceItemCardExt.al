pageextension 50730 ServiceItemCardExt extends "Service Item Card"
{
    layout
    {
        addafter("Preferred Resource")
        {
            field("Service due date"; "Service due date")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var

                begin
                    if "Service due date" < Today then
                        Error('Service due date is less than Todays date');
                end;
            }

            field("Work center Name"; "Work center Name")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    WorkCenterRec: Record "Work Center";
                begin
                    WorkCenterRec.Reset();
                    WorkCenterRec.SetRange(Name, "Work center Name");

                    if WorkCenterRec.FindSet() then
                        "Work center Code" := WorkCenterRec."No.";
                end;
            }

            field("Service Period"; "Service Period")
            {
                ApplicationArea = All;
            }

            field("Model"; "Model")
            {
                ApplicationArea = All;
            }

            field(Brand; Brand)
            {
                ApplicationArea = All;
            }

            field("Purchase Year"; "Purchase Year")
            {
                ApplicationArea = All;
            }

            field(Factory; Factory)
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    LocationRec: Record Location;
                begin
                    LocationRec.Reset();
                    LocationRec.SetRange(Name, "Factory");
                    if LocationRec.FindSet() then
                        "Factory Code" := LocationRec."code";
                end;
            }

            field(Location; Location)
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    DepartmentRec: Record Department;
                begin
                    DepartmentRec.Reset();
                    DepartmentRec.SetRange("Department Name", "Location");
                    if DepartmentRec.FindSet() then
                        "Location Code" := DepartmentRec."No.";
                end;
            }

            field("Machine Category"; "Machine Category")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    MachineRec: Record "Machine Master";
                begin
                    MachineRec.Reset();
                    MachineRec.SetRange("Machine Description", "Machine Category");
                    if MachineRec.FindSet() then
                        "Machine Category Code" := MachineRec."Machine No.";
                end;
            }

            field(Ownership; Ownership)
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    LocationRec: Record Location;
                begin
                    LocationRec.Reset();
                    LocationRec.SetRange(Name, "Ownership");
                    if LocationRec.FindSet() then
                        "Ownership Code" := LocationRec."code";
                end;
            }

            field("Global Dimension Code"; "Global Dimension Code")
            {
                ApplicationArea = All;
            }
        }
    }
}