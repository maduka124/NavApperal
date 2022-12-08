pageextension 50730 ServiceItemCardExt extends "Service Item Card"
{
    layout
    {
        addafter("Preferred Resource")
        {
            field("Service due date"; rec."Service due date")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var

                begin
                    if rec."Service due date" < Today then
                        Error('Service due date is less than Todays date');
                end;
            }

            field("Work center Name"; rec."Work center Name")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    WorkCenterRec: Record "Work Center";
                begin
                    WorkCenterRec.Reset();
                    WorkCenterRec.SetRange(Name, rec."Work center Name");

                    if WorkCenterRec.FindSet() then
                        rec."Work center Code" := WorkCenterRec."No.";
                end;
            }

            field("Service Period"; rec."Service Period")
            {
                ApplicationArea = All;
            }

            field("Model"; rec."Model")
            {
                ApplicationArea = All;
            }

            field(Brand; rec.Brand)
            {
                ApplicationArea = All;
            }

            field("Purchase Year"; rec."Purchase Year")
            {
                ApplicationArea = All;
            }

            field(Factory; rec.Factory)
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    LocationRec: Record Location;
                begin
                    LocationRec.Reset();
                    LocationRec.SetRange(Name, rec."Factory");
                    if LocationRec.FindSet() then
                        rec."Factory Code" := LocationRec."code";
                end;
            }

            field(Location; rec.Location)
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    DepartmentRec: Record Department;
                begin
                    DepartmentRec.Reset();
                    DepartmentRec.SetRange("Department Name", rec."Location");
                    if DepartmentRec.FindSet() then
                        rec."Location Code" := DepartmentRec."No.";
                end;
            }

            field("Machine Category"; rec."Machine Category")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    MachineRec: Record "Machine Master";
                begin
                    MachineRec.Reset();
                    MachineRec.SetRange("Machine Description", rec."Machine Category");
                    if MachineRec.FindSet() then
                        rec."Machine Category Code" := MachineRec."Machine No.";
                end;
            }

            field(Ownership; rec.Ownership)
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    LocationRec: Record Location;
                begin
                    LocationRec.Reset();
                    LocationRec.SetRange(Name, rec."Ownership");
                    if LocationRec.FindSet() then
                        rec."Ownership Code" := LocationRec."code";
                end;
            }

            field("Global Dimension Code"; rec."Global Dimension Code")
            {
                ApplicationArea = All;
            }
        }

        addafter("Global Dimension Code")
        {
            field("Asset Number"; Rec."Asset Number")
            {
                ApplicationArea = All;
            }

            field("Motor Number"; Rec."Motor Number")
            {
                ApplicationArea = All;
            }
        }

        modify(Description)
        {
            trigger OnAfterValidate()
            var
                LoginSessionsRec: Record LoginSessions;
                LoginRec: Page "Login Card";
            begin
                //Check whether user logged in or not
                LoginSessionsRec.Reset();
                LoginSessionsRec.SetRange(SessionID, SessionId());

                if not LoginSessionsRec.FindSet() then begin  //not logged in
                    Clear(LoginRec);
                    LoginRec.LookupMode(true);
                    LoginRec.RunModal();

                    LoginSessionsRec.Reset();
                    LoginSessionsRec.SetRange(SessionID, SessionId());
                    LoginSessionsRec.FindSet();
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end
                else begin   //logged in
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end;
            end;
        }

    }
}