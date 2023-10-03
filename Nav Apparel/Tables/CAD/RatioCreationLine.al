
table 50595 RatioCreationLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50001; "Group ID"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(50002; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50003; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50004; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master PO"."Lot No." where("Style No." = field("Style No."));
        }

        field(50005; "SubLotNo."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = SewingJobCreationLine3."SubLotNo." where("Style No." = field("Style No."), "Lot No." = field("Lot No."));
            ValidateTableRelation = false;
        }

        field(50006; "Sewing Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50007; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50008; "1"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50009; "2"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50010; "3"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50011; "4"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50012; "5"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50013; "6"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50014; "7"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50015; "8"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50016; "9"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50017; "10"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50018; "11"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50019; "12"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50020; "13"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50021; "14"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50022; "15"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50023; "16"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50024; "17"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50025; "18"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50026; "19"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50027; "20"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50028; "21"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50029; "22"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50030; "23"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50031; "24"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50032; "25"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50033; "26"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50034; "27"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50035; "28"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50036; "29"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50037; "30"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50038; "31"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50039; "32"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50040; "33"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50041; "34"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50042; "35"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50043; "36"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50044; "37"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50045; "38"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50046; "39"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50047; "40"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50048; "41"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50049; "42"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50050; "43"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50051; "44"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50052; "45"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50053; "46"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50054; "47"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50055; "48"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50056; "49"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50057; "50"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "51"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "52"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "53"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "54"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "55"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50063; "56"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "57"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50065; "58"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50066; "59"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50067; "60"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "61"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50069; "62"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50070; "63"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50071; "64"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50072; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50073; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50074; "Color Total"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50075; "Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50076; "ShipDate"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50077; "Colour No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = AssorColorSizeRatio."Colour No"
             where("Style No." = field("Style No."), "Lot No." = field("Lot No."));

            ValidateTableRelation = false;
        }

        field(50078; "Colour Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50079; "Record Type"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50080; "LineNo"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(50081; "Marker Name"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50082; "Plies"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(50083; "Ref"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(50084; "Length"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0.00;
        }

        field(50085; "Length Tollarance"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0.00;
        }

        field(50086; "Width"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0.00;
        }

        field(50087; "Width Tollarance"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0.00;
        }

        field(50088; "UOM Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
        }

        field(50089; UOM; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50090; "Efficiency"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0.00;
        }

        field(50091; "RatioCreNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50092; "Component Group Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50093; "Pattern Version"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "RatioCreNo", "Group ID", LineNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // fieldgroup(Dropdown; "Style Name", "Lot No.", "SubLotNo.", "Group ID")
        // {

        // }
        fieldgroup(DropDown; "Marker Name")
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
    begin

    end;

    trigger OnRename()
    begin

    end;

}
