page 51240 "Export Reference List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ExportReferenceHeader;
    CardPageId = "Export Reference Card";
    Editable = false;
    Permissions = tabledata "Sales Invoice Header" = rm;
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                }

                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Buyer Name"; Rec."Buyer Name")
                {
                    ApplicationArea = All;

                }
                field("Contract No"; Rec."Contract No")
                {
                    ApplicationArea = All;
                }
                field("Order No"; Rec."Order No")
                {
                    ApplicationArea = All;
                }
                field("Factory Inv No"; Rec."Factory Inv No")
                {
                    ApplicationArea = All;
                }
                field("BL No"; Rec."BL No")
                {
                    ApplicationArea = All;
                }

                field("BL Date"; Rec."BL Date")
                {
                    ApplicationArea = All;
                }
                field("DOC Sub Bank Date"; Rec."DOC Sub Bank Date")
                {
                    ApplicationArea = All;
                }
                field("DOC Sub Buyer Date"; Rec."DOC Sub Buyer Date")
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
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();
        end;

    end;


    trigger OnDeleteRecord(): Boolean
    var
        SalesInvLineRec: Record "Sales Invoice Line";
        SalesInvRec: Record "Sales Invoice Header";
    begin
        SalesInvLineRec.Reset();
        SalesInvLineRec.SetRange("No.", rec."No.");
        if SalesInvLineRec.FindSet() then
            SalesInvLineRec.DeleteAll();

        SalesInvRec.Reset();
        SalesInvRec.SetRange("Export Ref No.", rec."No.");
        if SalesInvRec.FindSet() then begin
            SalesInvRec."Export Ref No." := '';
            SalesInvRec.Modify();
        end;
    end;

}