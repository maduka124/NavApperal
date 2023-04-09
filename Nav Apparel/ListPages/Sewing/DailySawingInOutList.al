page 50356 "Daily Sewing In/Out"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ProductionOutHeader;
    SourceTableView = sorting("No.") order(descending) where(Type = filter('Saw'));
    CardPageId = "Daily Sewing In/Out Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                }

                field("Prod Date"; rec."Prod Date")
                {
                    ApplicationArea = All;
                    Caption = 'Production Date';
                }

                field("Resource Name"; rec."Resource Name")
                {
                    ApplicationArea = All;
                    Caption = 'Resource';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Input Style';
                }

                field("PO No"; rec."PO No")
                {
                    ApplicationArea = All;
                    Caption = 'Input PO No';
                }

                //Mihiranga 2023/02/26
                field("Input Qty"; Rec."Input Qty")
                {
                    ApplicationArea = All;
                }         
         
                field("Out Style Name"; Rec."Out Style Name")
                {
                    ApplicationArea = all;
                    Caption = 'Output Style';
                }

                field("OUT PO No"; Rec."OUT PO No")
                {
                    ApplicationArea = all;
                    Caption = 'Output PO No';
                }
                
                field("Output Qty"; rec."Output Qty")
                {
                    ApplicationArea = All;
                }

                field("Prod Updated"; rec."Prod Updated")
                {
                    ApplicationArea = All;
                    Caption = 'Prod. Updated Status';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
        UserRec: Record "User Setup";
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            // LoginSessionsRec.Reset();
            // LoginSessionsRec.SetRange(SessionID, SessionId());
            // if LoginSessionsRec.FindSet() then
            //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end
        else begin   //logged in
            //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end;

        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then
            rec.SetFilter("Factory Code", '=%1', UserRec."Factory Code");

    end;


    trigger OnDeleteRecord(): Boolean
    var
        NavAppCodeUnit: Codeunit NavAppCodeUnit;
        UserRec: Record "User Setup";
    begin
        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.')
            else begin
                if rec."Prod Updated" = 1 then
                    Error('Production updated against this entry. You cannot delete it.');
            end;
        end
        else
            Error('You are not authorized to delete records.');

        NavAppCodeUnit.Delete_Prod_Records(rec."No.", rec."Style No.", rec."PO No", 'IN', 'Saw', rec.Type::Saw);
        NavAppCodeUnit.Delete_Prod_Records(rec."No.", rec."Style No.", rec."PO No", 'OUT', 'Saw', rec.Type::Saw);
    end;
}