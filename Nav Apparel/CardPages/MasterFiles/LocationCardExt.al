pageextension 50958 LocationCardExt extends "Location Card"
{
    layout
    {
        addlast(General)
        {
            field("Transfer-from Location"; rec."Transfer-from Location")
            {
                ApplicationArea = All;
            }

            field("Bundle Guide Sequence"; rec."Bundle Guide Sequence")
            {
                ApplicationArea = All;
            }
        }

        addafter("Use As In-Transit")
        {
            field("Plant Type No."; rec."Plant Type No.")
            {
                ApplicationArea = All;
                Caption = 'Plant Type No';
                TableRelation = "Plant Type"."Plant Type No.";

                trigger OnValidate()
                var
                    PlantTypeRec: Record "Plant Type";
                begin
                    PlantTypeRec.get(rec."Plant Type No.");
                    rec."Plant Type Name" := PlantTypeRec."Plant Type Name";
                end;
            }

            field("Plant Type Name"; rec."Plant Type Name")
            {
                ApplicationArea = All;
            }

            field("Sewing Unit"; rec."Sewing Unit")
            {
                ApplicationArea = All;
            }

            field("Start Time"; rec."Start Time")
            {
                ApplicationArea = ALL;
            }

            field("Finish Time"; rec."Finish Time")
            {
                ApplicationArea = ALL;
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