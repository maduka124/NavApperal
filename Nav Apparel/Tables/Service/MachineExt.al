tableextension 50736 "Machine Extension" extends "Machine Center"
{
    fields
    {
        field(50001; "ASSERT NO"; Code[50])
        {
        }

        field(50002; "BRAND Code"; code[20])
        {
        }

        field(50003; "BRAND Desc"; text[50])
        {
            TableRelation = Brand."Brand Name";
            ValidateTableRelation = false;
        }

        field(50004; "MODEL"; Text[50])
        {
        }

        field(50005; "MACHINE CATEGORY"; code[50])
        {
        }

        field(50006; "Head /Serial No"; Text[50])
        {
        }

        field(50007; "MOTOR NO"; code[50])
        {
        }

        field(50008; "PURCHASE YEAR"; code[20])
        {
        }

        field(50009; "SUPPLIER CODE"; code[20])
        {
        }

        field(50010; "SUPPLIER"; Text[100])
        {
            TableRelation = Vendor."Name";
            ValidateTableRelation = false;
        }

        field(50011; "SERVICE PERIOD"; Option)
        {
            OptionCaption = ''',1 Week,2 Weeks,3 Weeks,1 Month,2 Months,3 Months';
            OptionMembers = "''","1 Week","2 Weeks","3 Weeks","1 Month","2 Months","3 Months";
        }

        field(50012; "OWNER SHIP"; Code[20])
        {
        }
    }

    // trigger OnBeforeDelete()
    // var
    //     BOMestRec: Record "BOM Estimate Line";
    // begin
    //     //Check for Exsistance
    //     BOMestRec.Reset();
    //     BOMestRec.SetRange("Item No.", "No.");
    //     if BOMestRec.FindSet() then
    //         Error('Item : %1 already used in operations. Cannot delete.', Description);

    // end;
}

