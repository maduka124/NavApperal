
table 50679 FabricCodeMaster
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; FabricCode; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; Composition; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(3; Construction; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Supplier No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Supplier Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor.Name;
            ValidateTableRelation = false;
        }

        field(6; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        //2023/03/09
        field(9; Reference; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'ABA-Reference';
        }
        //
    }

    keys
    {
        key(PK; FabricCode)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; FabricCode, Composition, Construction, "Supplier Name")
        {

        }
    }


    trigger OnInsert()
    var
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

   
    trigger OnDelete()
    var
        FabShadeHeaderRec: Record "FabShadeHeader";
        FabShadeBHeaderRec: Record "FabShadeBandShriHeader";
        FabShrRec: Record "FabShrinkageTestHeader";
        FabTwRec: Record "FabTwistHeader";
    begin
        //Check for Exsistance
        FabShadeHeaderRec.Reset();
        FabShadeHeaderRec.SetRange("Fabric Code", FabricCode);
        if FabShadeHeaderRec.FindSet() then
            Error('Fabric Code : %1 already used in operations. Cannot delete.', FabricCode);

        //Check for Exsistance
        FabShadeBHeaderRec.Reset();
        FabShadeBHeaderRec.SetRange("Fabric Code", FabricCode);
        if FabShadeBHeaderRec.FindSet() then
            Error('Fabric Code : %1 already used in operations. Cannot delete.', FabricCode);

        //Check for Exsistance
        FabShrRec.Reset();
        FabShrRec.SetRange("Fabric Code", FabricCode);
        if FabShrRec.FindSet() then
            Error('Fabric Code : %1 already used in operations. Cannot delete.', FabricCode);

        //Check for Exsistance
        FabTwRec.Reset();
        FabTwRec.SetRange("Fabric Code", FabricCode);
        if FabTwRec.FindSet() then
            Error('Fabric Code : %1 already used in operations. Cannot delete.', FabricCode);
    end;
}
