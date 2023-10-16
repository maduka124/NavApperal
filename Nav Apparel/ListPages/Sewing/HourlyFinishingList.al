page 51378 "Hourly Finishing List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    SourceTable = "Hourly Production Master";
    CardPageId = "Hourly Finishing Card";
    SourceTableView = sorting("No.") order(descending) where(Type = filter(Finishing));


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Prod Date"; rec."Prod Date")
                {
                    ApplicationArea = All;
                }

                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;
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
        end;

        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then
            rec.SetFilter("Factory No.", '=%1', UserRec."Factory Code");

    end;

    trigger OnDeleteRecord(): Boolean
    var
        HourlyProdLinesRec: Record "Hourly Production Lines";
        ProdOutHeaderRec: Record ProductionOutHeader;
        UserRec: Record "User Setup";
    begin

        //Check whether production updated or not
        if rec.Type = rec.Type::Finishing then begin
            ProdOutHeaderRec.Reset();
            ProdOutHeaderRec.SetRange("Prod Date", rec."Prod Date");
            ProdOutHeaderRec.SetRange("Factory Code", rec."Factory No.");
            ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Saw);
            ProdOutHeaderRec.SetFilter("Prod Updated", '=%1', 1);
            if ProdOutHeaderRec.FindSet() then
                Error('Production updated against Date : %1 , Factory : %2 has been updates. You cannot delete this entry.', rec."Prod Date", rec."Factory Name");
        end;


        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory No.") then
                Error('You are not authorized to delete this record.');
        end
        else
            Error('You are not authorized to delete records.');

        if Today > Rec."Prod Date" then
            Error('You Cannot delete previous Date records');

        HourlyProdLinesRec.Reset();
        HourlyProdLinesRec.SetRange("No.", rec."No.");
        if HourlyProdLinesRec.FindSet() then
            HourlyProdLinesRec.DeleteAll();
    end;
}