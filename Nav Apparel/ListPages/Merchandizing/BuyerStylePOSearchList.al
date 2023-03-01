page 51252 "Buyer Style PO Search List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BuyerStylePOSearchHeader";
    CardPageId = "Buyer Style PO Search";
    //DeleteAllowed = false;
    // InsertAllowed = false;
    // ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; rec."No.")
                {
                    ApplicationArea = All;
                }

                field("Buyer Code"; Rec."Buyer Code")
                {
                    ApplicationArea = all;
                }

                field("Buyer Name"; Rec."Buyer Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }



    trigger OnDeleteRecord(): Boolean
    var

    begin
        Error('Cannot delete this record.');
    end;

    trigger OnOpenPage()
    var
        CustomerRec: Record Customer;
        UsersetupRec: Record "User Setup";
        PosearchRec: Record BuyerStylePOSearchHeader;
        MaxNo: BigInteger;
    begin

        UsersetupRec.Reset();
        UsersetupRec.Get(UserId);

        CustomerRec.Reset();
        CustomerRec.SetRange("Group Name", UsersetupRec."Merchandizer Group Name");

        if CustomerRec.FindSet() then begin
            MaxNo := 0;
            repeat
                PosearchRec.Reset();
                PosearchRec.SetRange("Buyer Code", CustomerRec."No.");

                if PosearchRec.FindSet() then begin
                    MaxNo += 1;
                    PosearchRec.Init();
                    Rec."No." := MaxNo;
                    Rec."Buyer Code" := CustomerRec."No.";
                    Rec."Buyer Name" := CustomerRec.Name;
                    PosearchRec.Insert();
                end;
            until CustomerRec.Next() = 0;
        end;
    end;
}