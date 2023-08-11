page 51389 "Daily Consumption List Appro"
{
    ApplicationArea = All;
    Caption = 'Raw Material Requisition List (Approved)';
    PageType = List;
    SourceTable = "Daily Consumption Header";
    SourceTableView = sorting("No.") order(descending) where(Status = filter(Approved));
    UsageCategory = Lists;
    //CardPageId = "Daily Consumption Card";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Buyer; Rec.Buyer)
                {
                    ApplicationArea = All;
                }
                field("Style No."; Rec."Style No.")
                {
                    ApplicationArea = All;
                }
                field(PO; rec.PO)
                {
                    ApplicationArea = All;
                }
                field("Colour Name"; rec."Colour Name")
                {
                    ApplicationArea = All;
                }
                field("Created UserID"; rec."Created UserID")
                {
                    Caption = 'User';
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved Date/Time"; rec."Approved Date/Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issued UserID"; rec."Issued UserID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issued Date/Time"; rec."Issued Date/Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }


    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if UserSetup.UserRole <> 'STORE USER' then BEGIN
            if not UserSetup."Consumption Approve" then
                Rec.SetRange("Created UserID", UserId);
        END;
    end;
}
