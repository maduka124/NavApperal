page 50992 "Dependency Parameters Card"
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
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        DependencyGroupRec.Reset();
                        DependencyGroupRec.SetRange("Dependency Group", rec."Dependency Group");
                        if DependencyGroupRec.FindSet() then
                            rec."Dependency Group No." := DependencyGroupRec."No."
                        else
                            Error('Invalid Dependency Group');

                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;
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
                            rec."Action Type No." := ActionTypeRec."No."
                        else
                            Error('Invalid Action Type');
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
                            rec."Department No." := DepartmentRec."No."
                        else
                            Error('Invalid Department');
                    end;
                }
            }
        }
    }
}