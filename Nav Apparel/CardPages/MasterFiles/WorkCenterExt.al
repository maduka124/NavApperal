pageextension 51154 WorkcenterCardExt extends "Work Center Card"
{
    layout
    {

        addafter("Last Date Modified")
        {
            field("Linked To Service Item"; rec."Linked To Service Item")
            {
                ApplicationArea = All;
            }
        }
        addafter("Linked To Service Item")
        {
            field("Work Center Seq No"; Rec."Work Center Seq No")
            {
                ApplicationArea = All;
            }

            field("LV Days"; rec."LV Days")
            {
                ApplicationArea = All;
            }
        }

        addafter(Warehouse)
        {
            group("Planning")
            {
                field("Planning Line"; rec."Planning Line")
                {
                    ApplicationArea = All;
                }

                field(MO; rec.MO)
                {
                    ApplicationArea = All;
                    Caption = 'Machine Operators';

                    trigger OnValidate()
                    var
                    begin
                        rec."Carder" := rec.MO + rec.HP;
                    end;
                }

                field(HP; rec.HP)
                {
                    ApplicationArea = All;
                    Caption = 'Helpers';

                    trigger OnValidate()
                    var
                    begin
                        rec."Carder" := rec.MO + rec.HP;
                    end;
                }

                field(Carder; rec.Carder)
                {
                    ApplicationArea = All;
                    Caption = 'Total Carders';
                    Editable = false;
                }

                field(PlanEff; rec.PlanEff)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Efficiency (%)';
                }

                field("Department No"; rec."Department No")
                {
                    ApplicationArea = All;
                    TableRelation = "Department"."No.";

                    trigger OnValidate()
                    var
                        DepartmentRec: Record Department;
                    begin
                        DepartmentRec.get(rec."Department No");
                        rec."Department Name" := DepartmentRec."Department Name";
                    end;
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Supervisor Name"; rec."Supervisor Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supervisor';
                }

                field("Factory No."; rec."Factory No.")
                {
                    ApplicationArea = All;
                    TableRelation = Location.Code;

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                    begin
                        LocationRec.get(rec."Factory No.");
                        rec."Factory Name" := LocationRec.Name;
                    end;
                }

                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                    Editable = false;
                }

                field(Floor; rec.Floor)
                {
                    ApplicationArea = All;
                }
            }
        }


        modify(Name)
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