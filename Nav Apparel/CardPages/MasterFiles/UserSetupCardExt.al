pageextension 50979 UserSetupCardExt extends "User Setup"
{
    layout
    {
        addafter(Email)
        {
            field("Factory Code"; rec."Factory Code")
            {
                ApplicationArea = All;
                Caption = 'Factory';
                ShowMandatory = true;
            }

            field("Service Approval"; rec."Service Approval")
            {
                ApplicationArea = All;
            }

            field("GT Pass Approval"; rec."GT Pass Approve")
            {
                ApplicationArea = All;
            }

            field("Purchasing Approval"; rec."Purchasing Approval")
            {
                ApplicationArea = All;
            }

            field(UserRole; rec.UserRole)
            {
                ApplicationArea = All;
                Caption = 'User Role';
                ShowMandatory = true;
            }

            field("Global Dimension Code"; rec."Global Dimension Code")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }

            field("Merchandizer Head"; rec."Merchandizer Head")
            {
                Caption = 'Merchandiser Head';
                ApplicationArea = All;
            }

            field("Merchandizer Group Name"; rec."Merchandizer Group Name")
            {
                ApplicationArea = All;
                Caption = 'Merchandiser Group Name';
            }
        }

        addafter("Time Sheet Admin.")
        {
            field("Req. Worksheet Batch"; rec."Req. Worksheet Batch")
            {
                ApplicationArea = All;
            }
            field("Consump. Journal Qty. Approve"; rec."Consump. Journal Qty. Approve")
            {
                ApplicationArea = All;
            }
            field("Head of Department"; rec."Head of Department")
            {
                ApplicationArea = All;
            }
            field("Gen. Issueing Approve"; rec."Gen. Issueing Approve")
            {
                ApplicationArea = All;
            }
            field("Consumption Approve"; rec."Consumption Approve")
            {
                ApplicationArea = All;
            }
            field("Daily Requirement Approver"; rec."Daily Requirement Approver")
            {
                ApplicationArea = All;
            }
            field("Gen. Issueing Approver"; Rec."Gen. Issueing Approver")
            {
                ApplicationArea = All;
            }
            field("Requsting Department Name"; rec."Requsting Department Name")
            {
                ApplicationArea = All;
            }
        }
    }
}