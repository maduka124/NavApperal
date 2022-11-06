page 50821 "Department Requisition Sheet"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DeptReqSheetHeader;
    CardPageId = DepReqSheetHeaderCard;
    SourceTableView = sorting("Req No") order(descending);
    //CardPageId = "Department Requisition Sheet Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Req No"; "Req No")
                {
                    ApplicationArea = All;
                    Caption = 'Requisition No';
                }

                field("Request Date"; "Request Date")
                {
                    ApplicationArea = All;
                }

                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                }

                field("Global Dimension Code"; "Global Dimension Code")
                {
                    ApplicationArea = All;
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
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


    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        UserRec.Reset();
        UserRec.SetRange("User ID", UserId);
        if UserRec.FindSet() then begin
            Rec.SetCurrentKey("Factory Code");
            Rec.SETFILTER("Factory Code", '%1', STRSUBSTNO('*%1*', UserRec."Factory Code"));
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        DeptReqSheetLine: Record DeptReqSheetLine;
    begin

        DeptReqSheetLine.Reset();
        DeptReqSheetLine.SetRange("Req No", "Req No");
        if DeptReqSheetLine.FindSet() then
            DeptReqSheetLine.DeleteAll();

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

}