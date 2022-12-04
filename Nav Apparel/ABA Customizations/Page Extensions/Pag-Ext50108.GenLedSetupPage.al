pageextension 50108 GenLedSetupPage extends "General Ledger Setup"
{
    layout
    {
        addafter(General)
        {
            group("Budget Informations")
            {
                field("G/L Budget Name"; rec."G/L Budget Name")
                {
                    ApplicationArea = All;
                }
                field("Manufacturing Cost G/L"; Rec."Manufacturing Cost G/L")
                {
                    ApplicationArea = All;
                }
                field("Overhead Cost G/L"; Rec."Overhead Cost G/L")
                {
                    ApplicationArea = All;
                }
                field("Commission Cost G/L"; Rec."Commission Cost G/L")
                {
                    ApplicationArea = All;
                }
                field("Commercial Cost G/L"; Rec."Commercial Cost G/L")
                {
                    ApplicationArea = All;
                }
                field("Deferred Payment G/L"; Rec."Deferred Payment G/L")
                {
                    ApplicationArea = All;
                }
                field("Tax G/L"; Rec."Tax G/L")
                {
                    ApplicationArea = All;
                }
                field("Sourcing G/L"; Rec."Sourcing G/L")
                {
                    ApplicationArea = All;
                }
                field("Risk factor G/L"; Rec."Risk factor G/L")
                {
                    ApplicationArea = All;
                }
                field("Material Cost G/L"; rec."Material Cost G/L")
                {
                    ApplicationArea = All;
                }
                field("Total Sales G/L"; rec."Total Sales G/L")
                {
                    ApplicationArea = All;
                }

            }
            group("Item Charge Informations")
            {
                field("Bank Charge Template"; rec."Bank Charge Template")
                {
                    ApplicationArea = All;
                }
                field("Bank Charge Batch"; rec."Bank Charge Batch")
                {
                    ApplicationArea = All;
                }
                field("Bank Charge G/L"; rec."Bank Charge G/L")
                {
                    ApplicationArea = All;
                }
                field("Bank Charge Bank Account"; rec."Bank Charge Bank Account")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
