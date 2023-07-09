table 50407 "Order Shipping Export"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; StyleNO; code[20])
        {
            DataClassification = ToBeClassified;


        }
        field(2; "Style Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No." where(Status = filter(Confirmed));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                styleRec: Record "Style Master";
                ContractRec: Record "Contract/LCMaster";
            begin
                styleRec.Reset();
                styleRec.SetRange("Style No.", Rec."Style Name");
                if styleRec.FindSet() then begin
                    Rec.StyleNO := styleRec."No.";
                    Rec.Buyer := styleRec."Buyer No.";
                    rec."Buyer Name" := styleRec."Buyer Name";
                    rec."Contract No" := styleRec.AssignedContractNo;
                end;

                ContractRec.Reset();
                ContractRec.SetRange("No.", Rec."Contract No");
                if ContractRec.FindSet() then begin
                    Rec."Contract Lc/No" := ContractRec."Contract No";
                end;
            end;

        }
        field(3; "Buyer"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Buyer Name"; Text[100])
        {
            DataClassification = ToBeClassified;


        }
        field(5; "Contract No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Contract/LCMaster"."No.";
            ValidateTableRelation = false;

        }

        field(6; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Created User"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Contract Lc/No"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;

        }


    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("OrderShippingExport Nos.");
        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."OrderShippingExport Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    var
        myInt: Integer;


}