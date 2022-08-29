tableextension 71012615 "Location Extension" extends Location
{
    fields
    {
        field(71012581; "Plant Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Plant Type"."Plant Type No.";
        }

        field(71012582; "Plant Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Sewing Unit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    trigger OnBeforeDelete()
    var
        StyleRec: Record "Style Master";
    begin
        //Check for Exsistance
        StyleRec.Reset();
        StyleRec.SetRange("Factory Code", Code);
        if StyleRec.FindSet() then
            Error('Location : %1 already used in operations. Cannot delete.', Name);
    end;


}

