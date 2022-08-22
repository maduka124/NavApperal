
table 71012636 Shade
{
    DataClassification = ToBeClassified;
    LookupPageId = Shade;
    DrillDownPageId = Shade;

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Shade"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Shade)
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        FabShadeListPart2Rec: Record "FabShadeLine2";
        ItemLedRec: Record "Item Ledger Entry";
        AssorColorSizeRatioRec: Record AssorColorSizeRatio;
    begin
        //Check for Exsistance
        AssorColorSizeRatioRec.Reset();
        AssorColorSizeRatioRec.SetRange("SHID/LOT", "No.");
        if AssorColorSizeRatioRec.FindSet() then
            Error('Shade : %1 already used in operations. Cannot delete.', Shade);

        ItemLedRec.Reset();
        ItemLedRec.SetRange("Shade No", "No.");
        if ItemLedRec.FindSet() then
            Error('Shade : %1 already used in operations. Cannot delete.', Shade);

        FabShadeListPart2Rec.Reset();
        FabShadeListPart2Rec.SetRange("Shade No", "No.");
        if FabShadeListPart2Rec.FindSet() then
            Error('Shade : %1 already used in operations. Cannot delete.', Shade);
    end;

    trigger OnRename()
    begin

    end;

}
