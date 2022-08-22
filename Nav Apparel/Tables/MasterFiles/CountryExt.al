tableextension 71012815 "Country Extension" extends "Country/Region"
{
    trigger OnBeforeDelete()
    var
        AssorRec: Record AssortmentDetails;
    begin
        //Check for Exsistance
        AssorRec.Reset();
        AssorRec.SetRange("Country Name", Name);
        if AssorRec.FindSet() then
            Error('Country : %1 already used in operations. Cannot delete.', "Name");

    end;
}

