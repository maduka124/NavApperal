tableextension 50925 "ReqLine Extension" extends "Requisition Line"
{
    fields
    {
        field(50001; "StyleNo"; Code[20])
        {
        }

        field(50002; "StyleName"; Text[50])
        {
        }

        field(50003; "PONo"; code[20])
        {
        }

        field(50004; "Lot"; Text[50])
        {
        }

        field(50005; "Color No."; Code[50])
        {
        }

        field(50006; "Color Name"; Text[50])
        {
        }

        field(50007; "EntryType"; Option)
        {
            OptionCaption = 'FG,Sample,"Central Purchasing"';
            OptionMembers = FG,Sample,"Central Purchasing";
        }

        field(50008; "Main Category"; Text[50])
        {
            TableRelation = "Main Category"."Main Category Name";
            ValidateTableRelation = false;
        }

        field(50009; "Department Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50010; "Department Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Department."Department Name";
            ValidateTableRelation = false;
        }

        field(50011; "CP Req Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50012; "CP Line"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(50013; "Global Dimension Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }

        field(50014; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50015; "Buyer Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(50016; "Purchase Order Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50017; "Created User Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50018; "Modified User Name"; Text[50])
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

