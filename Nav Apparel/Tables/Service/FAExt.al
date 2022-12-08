tableextension 50734 "FA Extension" extends "Fixed Asset"
{
    fields
    {
        field(50001; "Machine category"; Text[50])
        {
        }

        field(50002; "Model number"; Text[50])
        {
        }

        field(50003; "RPM/Machine type"; text[50])
        {

        }

        field(50004; "Motor number"; Text[50])
        {

        }

        field(50005; "Features "; Text[100])
        {

        }

        field(50006; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }



    }
}

