table 50722 JobCreationLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(3; "Split No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(4; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Sample","Bulk";
            OptionCaption = 'Sample,Bulk';

        }
        field(5; "BuyerCode"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Style No"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Color Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Order Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Garment Type"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Sample Type"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Size"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Remark"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(13; Comment; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Option"; text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "wash Type"; Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Wash Type"."Wash Type Name";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                imidateTable: Record IntermediateTable;
            begin
                imidateTable.Reset();
                imidateTable.SetRange(No, No);
                imidateTable.SetRange("Line No", "Line No");
                imidateTable.SetRange("Split No", "Split No");
                if imidateTable.FindFirst() then begin
                    imidateTable."Wash Type" := "wash Type";
                    imidateTable.Modify();
                end;
            end;
        }

        field(16; QTY; Integer)
        {
            DataClassification = ToBeClassified;

            // trigger OnValidate()
            // var
            //     imidateTable: Record IntermediateTable;
            // begin

            //     imidateTable.Reset();
            //     imidateTable.SetRange(No, No);
            //     imidateTable.SetRange("Line No", "Line No");
            //     imidateTable.SetRange("Split No", "Split No");
            //     if imidateTable.FindFirst() then begin
            //         imidateTable."Split Qty" := QTY;
            //         imidateTable.Modify();
            //     end;
            // end;
        }

        field(17; "Reciepe (Prod BOM)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Production BOM Header"."No.";
        }

        field(18; "Job Card (Prod Order)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Production Order"."No." where(Status = filter("Firm Planned"));
            ValidateTableRelation = false;
        }

        field(19; "Req Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Seq No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        // field(22; "Split QTY"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        // }

        field(24; "Split Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "No","Yes";
            OptionCaption = 'No,Yes';
        }

        field(25; "Sample Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(26; "SO No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(27; "Wash Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(28; Editeble; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(29; "Style Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(30; "Color Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(31; "Unite Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(32; "BuyerName"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(pk; No, "Line No", "Split No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; No, "Split No", QTY, "Job Card (Prod Order)")
        {

        }
    }
}