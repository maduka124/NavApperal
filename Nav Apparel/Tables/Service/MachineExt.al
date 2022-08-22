tableextension 50736 "Machine Extension" extends "Machine Center"
{
    fields
    {
        field(100; "ASSERT NO"; Code[50])
        {
        }

        field(101; "BRAND Code"; code[20])
        {
        }

        field(102; "BRAND Desc"; text[50])
        {
            TableRelation = Brand."Brand Name";
            ValidateTableRelation = false;
        }

        field(103; "MODEL"; Text[50])
        {
        }

        field(104; "MACHINE CATEGORY"; code[50])
        {
        }

        field(105; "Head /Serial No"; Text[50])
        {
        }

        field(106; "MOTOR NO"; code[50])
        {
        }

        field(107; "PURCHASE YEAR"; code[20])
        {
        }

        field(108; "SUPPLIER CODE"; code[20])
        {
        }

        field(109; "SUPPLIER"; Text[100])
        {
            TableRelation = Vendor."Name";
            ValidateTableRelation = false;
        }

        field(110; "SERVICE PERIOD"; Option)
        {
            OptionCaption = ''',1 Week,2 Weeks,3 Weeks,1 Month,2 Months,3 Months';
            OptionMembers = "''","1 Week","2 Weeks","3 Weeks","1 Month","2 Months","3 Months";
        }

        field(111; "OWNER SHIP"; Code[20])
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

