page 51252 "Buyer Style PO Search List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BuyerStylePOSearchHeader";
    CardPageId = "Buyer Style PO Search";  
    Editable = false;

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


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    begin
        Error('Cannot insert new record.');
    end;


    trigger OnModifyRecord(): Boolean
    var
    begin
        Error('Cannot modify this record.');
    end;


    trigger OnOpenPage()
    var
        CustomerRec: Record Customer;
        UsersetupRec: Record "User Setup";
        PosearchRec: Record BuyerStylePOSearchHeader;
        MaxNo: BigInteger;
    begin

        PosearchRec.Reset();
        PosearchRec.Ascending(true);
        if PosearchRec.Findlast() then
            MaxNo := PosearchRec."No.";

        CustomerRec.Reset();
        CustomerRec.SetCurrentKey(Name);
        CustomerRec.Ascending(true);

        if CustomerRec.FindSet() then begin
            repeat
                PosearchRec.Reset();
                PosearchRec.SetRange("Buyer Code", CustomerRec."No.");
                if not PosearchRec.FindSet() then begin
                    MaxNo += 1;
                    PosearchRec.Init();
                    PosearchRec."No." := MaxNo;
                    PosearchRec."Buyer Code" := CustomerRec."No.";
                    PosearchRec."Buyer Name" := CustomerRec.Name;
                    PosearchRec."Group Name" := CustomerRec."Group Name";
                    PosearchRec."Goup Code" := CustomerRec."Group Id";
                    PosearchRec.Insert();
                end;
            until CustomerRec.Next() = 0;
        end;
        //Get UserID
        UsersetupRec.Reset();
        UsersetupRec.Get(UserId);

        // All Merchandizer Group false
        if UsersetupRec."Merchandizer All Group" = false then begin

            if UsersetupRec."Merchandizer Group Name" = '' then
                Error('Merchandiser Group Name is not setup in user setup')
            else begin
                Rec.SetRange("Group Name", UsersetupRec."Merchandizer Group Name");
            end;
        end;
    end;
}