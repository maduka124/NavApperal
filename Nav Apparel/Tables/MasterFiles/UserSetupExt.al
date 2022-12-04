tableextension 71012660 "User Setup Extension" extends "User Setup"
{
    fields
    {
        field(71012581; "Factory Code"; Code[20])
        {
            TableRelation = Location.Code;
        }

        field(71012582; "Service Approval"; Boolean)
        {

        }

        field(71012583; "GT Pass Approve"; Boolean)
        {

        }

        field(71012584; "UserRole"; Text[50])
        {

        }

        field(71012585; "Global Dimension Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }

        field(71012586; "Purchasing Approval"; Boolean)
        {

        }

        field(71012587; "Merchandizer Head"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50100; "Req. Worksheet Batch"; Code[10])
        {
            Caption = 'Req. Worksheet Batch';
            DataClassification = ToBeClassified;
            TableRelation = "Requisition Wksh. Name".Name where("Template Type" = filter("Req."));
        }
        field(50101; "Consump. Journal Qty. Approve"; Boolean)
        {
            Caption = 'Approve Over Quantity Issuing';
            DataClassification = ToBeClassified;
        }
        field(50102; "Head of Department"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Gen. Issueing Approve"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Consumption Approve"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "Requsting Department Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Department."Department Name";
            ValidateTableRelation = false;
        }
        field(50106; "Daily Requirement Approver"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(50107; "Gen. Issueing Approver"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
    }
}

