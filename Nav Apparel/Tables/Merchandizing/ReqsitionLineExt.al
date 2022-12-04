tableextension 50925 "ReqLine Extension" extends "Requisition Line"
{
    fields
    {
        field(71012581; "StyleNo"; Code[20])
        {
        }

        field(71012582; "StyleName"; Text[50])
        {
        }

        field(71012583; "PONo"; code[20])
        {
        }

        field(71012584; "Lot"; Text[50])
        {
        }

        field(71012585; "Color No."; Code[50])
        {
        }

        field(71012586; "Color Name"; Text[50])
        {
        }

        field(71012587; "EntryType"; Option)
        {
            OptionCaption = 'FG,Sample,"Central Purchasing"';
            OptionMembers = FG,Sample,"Central Purchasing";
        }

        field(71012588; "Main Category"; Text[50])
        {
            TableRelation = "Main Category"."Main Category Name";
            ValidateTableRelation = false;
        }

        field(71012589; "Department Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012590; "Department Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Department."Department Name";
            ValidateTableRelation = false;
        }

        field(71012591; "CP Req Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012592; "CP Line"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(71012593; "Global Dimension Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }

        field(71012594; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012595; "Buyer Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(50100; "Purchase Order Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50101; "Created User Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50102; "Modified User Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
                DimValues: Record "Dimension Value";
                GenLedSetup: Record "General Ledger Setup";
            begin
                if "Ref. Order Type" = "Ref. Order Type"::Purchase then begin
                    if "Shortcut Dimension 1 Code" <> '' then begin
                        GenLedSetup.Get();
                        DimValues.Get(GenLedSetup."Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                        DimValues.TestField("No. Series - PO");
                        "Purchase Order Nos." := DimValues."No. Series - PO";
                    end;
                end;
            end;
        }
    }

    // trigger OnAfterDelete()
    // var

    // begin
    //     Message('Deletedxx');
    // end;
}

