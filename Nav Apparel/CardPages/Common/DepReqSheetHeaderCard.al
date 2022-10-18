page 50709 "DepReqSheetHeaderCard"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = DeptReqSheetHeader;
    Caption = 'Department Requisition Sheet Card';

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

                field("Factory Code"; "Factory Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                    Editable = false;
                }

                field("Department Code"; "Department Code")
                {
                    ApplicationArea = All;
                    Visible = false;
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

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;

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

    // trigger OnOpenPage()
    // var
    //     UserRec: Record "User Setup";
    // begin
    //     UserRec.Reset();
    //     UserRec.SetRange("User ID", UserId);
    //     if UserRec.FindSet() then begin
    //         Rec.SetCurrentKey("Factory Code");
    //         Rec.SETFILTER("Factory Code", '%1', STRSUBSTNO('*%1*', UserRec."Factory Code"));
    //     end;
    // end;
}