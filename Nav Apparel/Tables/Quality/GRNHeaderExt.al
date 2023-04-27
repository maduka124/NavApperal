tableextension 50569 "GRN Extension" extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50404; "Trim Inspected"; Boolean)
        {
        }

        field(50405; "Select"; Boolean)
        {
        }

        field(50406; "LC/Contract No."; Code[20])
        {
        }

        field(50407; "Merchandizer Group Name"; Text[200])
        {
        }
        field(50408; "Quality Inspector Name"; Text[150])
        {
        }

    }


    trigger OnInsert()
    var
        UserSetupRec: Record "User Setup";
    begin

        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);
        if UserSetupRec.FindSet() then
            rec."Merchandizer Group Name" := UserSetupRec."Merchandizer Group Name";
    end;
}

