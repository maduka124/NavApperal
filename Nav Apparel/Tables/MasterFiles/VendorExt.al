tableextension 51149 "Vendor Extension" extends Vendor
{
    fields
    {
        field(50001; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        //Mihiranga 2023/02/24
        field(50002; "General Item Vendor"; Boolean)
        {
            Caption = 'General Item Vendor';
            DataClassification = ToBeClassified;
        }
    }


}

