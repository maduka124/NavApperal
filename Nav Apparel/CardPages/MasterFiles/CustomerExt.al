pageextension 50948 CustomerCardExt extends "Customer Card"
{
    layout
    {
        addafter("Disable Search by Name")
        {

            field("Fab Inspection Level"; rec."Fab Inspection Level")
            {
                ApplicationArea = All;
                Caption = 'Fabric Inspection Level (%)';
            }


            field("Group Id"; rec."Group Id")
            {
                ApplicationArea = All;
                Caption = 'Merchandiser Group';
            }
        }

        addafter(Shipping)
        {
            group("Samples Types")
            {
                part("Sample Type Buyer List part"; "Sample Type Buyer List part")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Buyer No." = FIELD("No.");
                }
            }
        }

        // modify("No.")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         LoginSessionsRec: Record LoginSessions;
        //         LoginRec: Page "Login Card";
        //     begin
        //         //Check whether user logged in or not
        //         LoginSessionsRec.Reset();
        //         LoginSessionsRec.SetRange(SessionID, SessionId());

        //         if not LoginSessionsRec.FindSet() then begin  //not logged in
        //             Clear(LoginRec);
        //             LoginRec.LookupMode(true);
        //             LoginRec.RunModal();

        //             // LoginSessionsRec.Reset();
        //             // LoginSessionsRec.SetRange(SessionID, SessionId());
        //             // LoginSessionsRec.FindSet();
        //             //   rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
        //         end
        //         else begin   //logged in
        //             //rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
        //         end;
        //     end;
        // }

    }

    actions
    {
        addlast("F&unctions")
        {
            action("Sample Types")
            {
                Caption = 'Sample Types';
                Image = Production;
                ApplicationArea = All;

                trigger OnAction();
                var
                    SampleList: Page "Sample Type List part";
                begin
                    Clear(SampleList);
                    SampleList.LookupMode(true);
                    SampleList.PassParameters(rec."No.");
                    SampleList.Run();
                end;
            }
        }
    }

}