page 50799 "Workers Card"
{
    PageType = Card;
    SourceTable = Workers;
    Caption = 'Workers';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Worker Name"; rec."Worker Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
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
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;

                    end;
                }

                //Done By Sachith On 18/01/23
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DepartmentRec: Record Department;
                    begin
                        DepartmentRec.Reset();
                        DepartmentRec.SetRange("Department Name", rec."Department Name");
                        if DepartmentRec.FindSet() then
                            Rec."Department No" := DepartmentRec."No."
                        else
                            Error('Invalid Department.');
                    end;
                }

                field("Worker Type"; rec."Worker Type")
                {
                    ApplicationArea = All;

                    //Done By Sachith On 18/01/23
                    trigger OnValidate()
                    var
                        UserRoleRec: Record UserRoles;
                    begin
                        UserRoleRec.Reset();
                        UserRoleRec.SetRange(Description, Rec."Worker Type");
                        if UserRoleRec.FindSet() then
                            Rec."User Role Code" := UserRoleRec.Code
                        else
                            Error('Invalid Worker Type.');
                    end;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}