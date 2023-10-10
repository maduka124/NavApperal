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
            field("Cost Center"; Rec."Cost Center")
            {
                ApplicationArea = All;
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

                trigger OnValidate()
                var
                begin
                    if rec."Merchandizer Group Name" <> '' then
                        rec."Merchandizer All Group" := false;
                end;
            }

            field("Merchandizer All Group"; rec."Merchandizer All Group")
            {
                ApplicationArea = All;
                Caption = 'Merchandiser All Group';

                trigger OnValidate()
                var
                begin
                    if rec."Merchandizer All Group" = true then
                        rec."Merchandizer Group Name" := '';
                end;
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
            field("Estimate Costing Approve"; Rec."Estimate Costing Approve")
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
    trigger OnAfterGetCurrRecord()
    var
    begin
        if (UserId <> 'SSDEVELOPER') and (UserId <> 'SOLUTIONUSER') and (UserId <> 'SOFTSERVE') then begin
            Error('User Setup has not set up for the this user');
        end;
    end;
}