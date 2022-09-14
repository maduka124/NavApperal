page 71012826 "Gate Pass List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Gate Pass Header";
    SourceTableView = sorting("No.") order(descending);
    CardPageId = "Gate Pass Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Gate Pass No';
                    StyleExpr = StyleExprTxt;
                }

                field("Transfer Date"; "Transfer Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Vehicle No."; "Vehicle No.")
                {
                    ApplicationArea = All;
                    Caption = 'Vehicle No';
                    StyleExpr = StyleExprTxt;
                }

                field(Type; Type)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Transfer From Name"; "Transfer From Name")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer From';
                    StyleExpr = StyleExprTxt;
                }

                field("Transfer To Name"; "Transfer To Name")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer To';
                    StyleExpr = StyleExprTxt;
                }

                field("Sent By"; "Sent By")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Approved/Rejected By"; "Approved By")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Approved/Rejected By';
                }

                field("Approved/Rejected Date"; "Approved Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Approved/Rejected Date';
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        GatePassLineRec: Record "Gate Pass Line";
    begin
        GatePassLineRec.SetRange("No.", "No.");
        GatePassLineRec.DeleteAll();
    end;


    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        UserRec.Reset();
        UserRec.SetRange("User ID", UserId);
        if UserRec.FindSet() then
            "FactoryGB" := UserRec."Factory Code";

        Rec.SetCurrentKey(FromToFactoryCodes);
        Rec.SETFILTER(FromToFactoryCodes, '%1', STRSUBSTNO('*%1*', FactoryGB));
        CurrPage.Editable(false);
    end;


    trigger OnAfterGetRecord()
    var
    begin
        if Status = Status::"Pending Approval" then
            StyleExprTxt := 'strongaccent'
        else
            StyleExprTxt := 'None';
    end;


    var
        StyleExprTxt: Text[50];
        FactoryGB: Code[20];
}