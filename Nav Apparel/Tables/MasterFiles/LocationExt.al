tableextension 51099 "Location Extension" extends Location
{
    fields
    {
        field(50001; "Plant Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Plant Type"."Plant Type No.";
        }

        field(50002; "Plant Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50003; "Sewing Unit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50004; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }

        // field(50005; "Finish Time"; Time)
        // {
        //     DataClassification = ToBeClassified;
        // }

        field(50006; "Transfer-from Location"; Code[20])
        {
            Caption = 'Transfer-from Location';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }

        field(50007; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50008; "Bundle Guide Sequence"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Continue,"Start From 1";
            OptionCaption = 'Continue,Start From 1';
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

