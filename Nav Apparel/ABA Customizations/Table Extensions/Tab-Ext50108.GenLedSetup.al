tableextension 50108 GenLedSetup extends "General Ledger Setup"
{
    fields
    {
        field(50100; "Manufacturing Cost G/L"; Code[20])
        {
            Caption = 'Manufacturing Cost G/L';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50101; "Overhead Cost G/L"; Code[20])
        {
            Caption = 'Overhead Cost G/L';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50102; "Commission Cost G/L"; Code[20])
        {
            Caption = 'Commission Cost G/L';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50103; "Commercial Cost G/L"; Code[20])
        {
            Caption = 'Commercial Cost G/L';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50104; "Deferred Payment G/L"; Code[20])
        {
            Caption = 'Deferred Payment G/L';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50105; "Tax G/L"; Code[20])
        {
            Caption = 'Tax G/L';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50106; "Sourcing G/L"; Code[20])
        {
            Caption = 'Sourcing G/L';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50107; "Risk factor G/L"; Code[20])
        {
            Caption = 'Risk factor G/L';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50108; "G/L Budget Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name";
        }
        field(50109; "Bank Charge G/L"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where(Blocked = filter(false), "Account Type" = filter(Posting));
        }
        field(50110; "Bank Charge Bank Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account" where(Blocked = filter(false));
        }
        field(50111; "Bank Charge Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(50112; "Bank Charge Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Bank Charge Template"));
        }
        field(50113; "Material Cost G/L"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where(Blocked = filter(false), "Account Type" = filter(Posting));
        }
        field(50114; "Total Sales G/L"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where(Blocked = filter(false), "Account Type" = filter(Posting));
        }
    }
}
