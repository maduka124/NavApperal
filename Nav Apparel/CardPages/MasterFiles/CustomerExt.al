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

                trigger OnValidate()
                var
                    MerchGRRec: Record MerchandizingGroupTable;
                begin
                    MerchGRRec.Reset();
                    MerchGRRec.SetRange("Group Id", rec."Group Id");
                    MerchGRRec.FindSet();
                    rec."Group Name" := MerchGRRec."Group Name";
                end;
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

        modify(Name)
        {
            trigger OnAfterValidate()
            var
                CustomerRec: Record Customer;
            begin
                //Check customer name already exists                
                CustomerRec.Reset();
                CustomerRec.SetRange(Name, rec.Name);
                CustomerRec.SetFilter("No.", '<>%1', rec."No.");

                if CustomerRec.FindSet() then
                    Error('Customer Name already exists in Customer No : %1', CustomerRec."No.");
            end;
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
                    SampleList.RunModal();
                end;
            }

            // action("ABCD")
            // {
            //     Caption = 'Group name';
            //     Image = Production;
            //     ApplicationArea = All;

            //     trigger OnAction();
            //     var
            //         MerchGroupPage: Record MerchandizingGroupTable;
            //         cust: Record Customer;
            //     begin
            //         cust.Reset();
            //         cust.FindSet();

            //         repeat

            //             MerchGroupPage.Reset();
            //             MerchGroupPage.SetRange("Group Id", cust."Group Id");
            //             if MerchGroupPage.FindSet() then begin
            //                 cust."Group Name" := MerchGroupPage."Group Name";
            //                 cust.Modify();

            //             end;
            //         until cust.Next() = 0;

            //     end;
            // }
        }
    }

}