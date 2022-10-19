page 50709 "DepReqSheetHeaderCard"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = DeptReqSheetHeader;
    Caption = 'Department Requisition Sheet';

    layout
    {
        area(Content)
        {
            group(Genaral)
            {
                field("Req No"; "Req No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';

                    trigger OnValidate()
                    var
                        DepRec: Record Department;
                        userRec: Record "User Setup";
                        locationRec: Record Location;
                    begin

                        DepRec.Reset();
                        DepRec.SetRange("Department Name", "Department Name");

                        if DepRec.FindSet() then
                            "Department Code" := DepRec."No.";

                        userRec.Reset();
                        userRec.SetRange("User ID", UserId);

                        if userRec.FindSet() then
                            "Factory Code" := userRec."Factory Code";

                        locationRec.Reset();
                        locationRec.SetRange(Code, "Factory Code");

                        if locationRec.FindSet() then
                            "Factory Name" := locationRec.Name;
                    end;
                }

                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                    Editable = false;
                }

                field("Request Date"; "Request Date")
                {
                    ApplicationArea = All;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group("")
            {
                part(DepReqSheetListpart; DepReqSheetListpart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Req No" = field("Req No");
                }
            }
        }
    }

    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."DepReq No", xRec."Req No", "Req No") THEN BEGIN
            NoSeriesMngment.SetSeries("Req No");
            EXIT(TRUE);
        END;
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
}