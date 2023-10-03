tableextension 50566 "SalesOrder Extension" extends "Sales Header"
{
    fields
    {
        field(50001; "Style No"; Code[20])
        {
        }

        field(50002; "Style Name"; text[50])
        {
        }

        field(50003; "PO No"; Code[20])
        {
        }

        field(50004; "Lot"; Code[20])
        {
        }

        field(50005; "EntryType"; Option)
        {
            OptionCaption = 'FG,Sample,Washing';
            OptionMembers = FG,Sample,Washing;
        }

        //Newly added by maduka on 17/1/2023
        field(50006; "BankRefNo"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50007; "AssignedBankRefNo"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50008; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50009; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50010; "Merchandizer Group Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(50011; "No of Cartons"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50012; "CBM"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50013; "Exp No"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(50014; "Exp Date"; date)
        {
            DataClassification = ToBeClassified;
        }

        field(50015; "UD No"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        //Done By Sachith On 15/03/23
        field(50016; "Contract No"; Text[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = LCMaster."LC No" where("Buyer No." = field("Sell-to Customer No."));  //Changed to LC Master table by maduka on 28/8/2023 
            TableRelation = "Contract/LCMaster"."Contract No" where("Buyer No." = field("Sell-to Customer No.")); // Change to Contract Table by Mihiranga on 02/10/2023
            ValidateTableRelation = false;
        }

        field(50017; "LC Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        modify("Your Reference")
        {
            Caption = 'Factory Inv. No';
        }

        //Done By Sachith On 15/03/23
        modify("External Document No.")
        {
            Caption = 'LC No';
            TableRelation = LCMaster."No." where(Buyer = field("Sell-to Customer Name"));

            trigger OnAfterValidate()
            var
                LCRec: Record LCMaster;
            begin
                LCRec.Reset();
                LCRec.SetRange("No.", Rec."External Document No.");
                if LCRec.FindSet() then begin
                    Rec."LC Name" := LCRec."LC No";
                end;
            end;

        }

    }
}


// trigger OnInsert()
// var
//     UserSetupRec: Record "User Setup";
// begin

//     UserSetupRec.Reset();
//     UserSetupRec.SetRange("User ID", UserId);
//     if UserSetupRec.FindSet() then begin

//         if UserSetupRec."Merchandizer Group Name" = '' then
//             Error('Merchandizer Group not setup in the User Setup.');

//         "Merchandizer Group Name" := UserSetupRec."Merchandizer Group Name";
//     end
//     else
//         Error('Merchandizer Group not setup in the User Setup.');
// end;



