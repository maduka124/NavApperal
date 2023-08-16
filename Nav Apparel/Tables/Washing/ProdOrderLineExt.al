tableextension 50665 ProductionOderLineExt extends "Prod. Order Line"
{
    fields
    {
        field(50001; Step; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = WashingStep.Description;
            ValidateTableRelation = false;
        }

        field(50002; Water; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                prodHead: Record "Production Order";
            begin
                prodHead.Get(Status, "Prod. Order No.");

                if (Water = 0) then
                    prodHead."Total Water Ltrs:" += Water
                else begin
                    prodHead."Total Water Ltrs:" := prodHead."Total Water Ltrs:" + Water - xRec.Water;
                end;

                prodHead.Modify(true);
            end;
        }

        field(50006; Temp; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50003; Ph; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50004; Instruction; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50005; "Time(Min)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                prodHead: Record "Production Order";
            begin
                prodHead.Get(Status, "Prod. Order No.");
                if ("Time(Min)" = 0) then
                    prodHead."Process Time:" += "Time(Min)"
                else begin
                    prodHead."Process Time:" := prodHead."Process Time:" + "Time(Min)" - xRec."Time(Min)";
                end;

                prodHead.Modify(true);
            end;
        }

        field(50008; "Step Code"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        // field(50009; "Item No Washing"; code[20])
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(50010; "Item Name Washing"; Text[100])
        // {
        //     DataClassification = ToBeClassified;
        // }
    }
}