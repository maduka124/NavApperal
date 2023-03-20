tableextension 50917 "PO Extension" extends "Purchase Header"
{
    fields
    {
        field(50001; "PI No."; Code[20])
        {
        }

        field(50002; "Select"; Boolean)
        {
        }

        field(50003; "Assigned PI No."; Code[50])
        {
        }

        field(50406; "LC/Contract No."; Code[50])
        {
        }

        field(50407; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50408; "Merchandizer Group Name"; Text[200])
        {

        }

        field(50409; "Workflow User Group"; code[20])
        {
            TableRelation = "Workflow User Group".Code;
        }

        field(50410; "EntryType"; Option)
        {
            OptionCaption = 'FG,Sample,Washing,Central Purchasing';
            OptionMembers = FG,Sample,Washing,"Central Purchasing";
        }

        //Mihiranga 2023/03/01
        field(50411; "Cost Center"; code[20])
        {

        }
        // modify("Buy-from Vendor No.")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         UserRec: Record "User Setup";
        //     begin
        //         UserRec.Reset();
        //         UserRec.SetRange(SystemCreatedBy, SystemCreatedBy);
        //         if UserRec.FindSet() then begin
        //             Rec."Cost Center" := UserRec."Cost Center";
        //         end;
        //         UserRec.Reset();


        //     end;

        // }


    }


    trigger OnInsert()
    var
        UserSetupRec: Record "User Setup";
        WorkflowUserGroupRec: Record "Workflow User Group";
    begin

        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);
        if UserSetupRec.FindSet() then begin

            if UserSetupRec."Merchandizer Group Name" = '' then
                Error('Merchandizer Group not setup in the User Setup.');

            "Merchandizer Group Name" := UserSetupRec."Merchandizer Group Name";

            WorkflowUserGroupRec.Reset();
            WorkflowUserGroupRec.SetRange(Code, UserSetupRec."Merchandizer Group Name");

            if WorkflowUserGroupRec.FindSet() then
                "Workflow User Group" := WorkflowUserGroupRec.Code;
        end
        else
            Error('Merchandizer Group not setup in the User Setup.');

    end;
}

