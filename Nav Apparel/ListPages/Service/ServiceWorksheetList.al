page 51236 "Service Wrks List"
{
    PageType = List;
    SourceTable = ServiceWorksheetHeaderNewNew;
    SourceTableView = sorting(Factory, "Work Center Name", ServiceType, StartDate) order(descending);
    CardPageId = "Service Worksheet Card";

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

                field(Factory; rec.Factory)
                {
                    ApplicationArea = All;
                }

                field("Work Center Name"; rec."Work Center Name")
                {
                    ApplicationArea = All;
                    Caption = 'Work Center';
                }

                field(ServiceType; rec.ServiceType)
                {
                    ApplicationArea = All;
                    Caption = 'Service Type';
                }

                field(StartDate; rec.StartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }

                field(EndDate; rec.EndDate)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        UserSetupRec: Record "User Setup";
    begin
        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);

        if UserSetupRec.FindSet() then
            rec.SetFilter("Factory No.", '=%1', UserSetupRec."Factory Code")
        else
            Error('Cannot find user details in user setup table');
    end;


    trigger OnDeleteRecord(): Boolean
    var
        ServiceWorkLineRec: Record ServiceWorksheetLineNew;
    begin
        //Delete old records
        ServiceWorkLineRec.Reset();
        ServiceWorkLineRec.SetRange("No.", rec."No.");
        if ServiceWorkLineRec.FindSet() then
            ServiceWorkLineRec.DeleteAll();

    end;
}