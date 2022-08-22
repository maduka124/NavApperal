tableextension 50665 ProductionOderLineExt extends "Prod. Order Line"
{
    fields
    {
        field(5001; Step; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = WashingStep.Description;
            ValidateTableRelation = false;
        }

        field(5002; Water; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                prodHead: Record "Production Order";
            begin
                prodHead.Get(Status::"Firm Planned", "Prod. Order No.");

                if (Water = 0) then
                    prodHead."Total Water Ltrs:" += Water
                else begin
                    prodHead."Total Water Ltrs:" := prodHead."Total Water Ltrs:" + Water - xRec.Water;
                end;

                prodHead.Modify(true);
            end;
        }

        field(5006; Temp; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(5003; Ph; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(5004; Instruction; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(5005; "Time(Min)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                prodHead: Record "Production Order";
            begin
                prodHead.Get(Status::"Firm Planned", "Prod. Order No.");
                if ("Time(Min)" = 0) then
                    prodHead."Process Time:" += "Time(Min)"
                else begin
                    prodHead."Process Time:" := prodHead."Process Time:" + "Time(Min)" - xRec."Time(Min)";
                end;

                prodHead.Modify(true);
            end;
        }

        // field(5007; DescriptionLine; Code[100])
        // {
        //     DataClassification = ToBeClassified;
        // }

        field(5008; "Step Code"; code[50])
        {
            DataClassification = ToBeClassified;
        }
    }


    trigger OnAfterDelete()
    var
        prodHead: Record "Production Order";
    begin
        prodHead.Get(Status::"Firm Planned", "Prod. Order No.");
        prodHead."Total Water Ltrs:" -= Water;
        prodHead.Modify(true);

        prodHead.Get(Status::"Firm Planned", "Prod. Order No.");
        prodHead."Process Time:" -= "Time(Min)";
        prodHead.Modify(true);
    end;

}