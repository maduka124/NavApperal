page 50731 "Service Wrks Line List part"
{
    PageType = ListPart;
    SourceTable = ServiceWorksheet;
    Editable = true;
    ModifyAllowed = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTableView = sorting("Service Item No") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Service Item No"; "Service Item No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Service Item Name"; "Service Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Work Center Name"; "Work Center Name")
                {
                    ApplicationArea = All;
                    Caption = 'Work Center';
                    Editable = false;
                }

                field("Service Date"; "Service Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Standard Service Desc"; "Standard Service Desc")
                {
                    ApplicationArea = All;
                    Caption = 'Standard Service Code';
                    Editable = true;

                    trigger OnValidate()
                    var
                        StanSerCodeRec: Record "Standard Service Code";
                    begin
                        StanSerCodeRec.Reset();
                        StanSerCodeRec.SetRange(Description, "Standard Service Desc");
                        if StanSerCodeRec.FindSet() then
                            "Standard Service Code" := StanSerCodeRec.Code;
                    end;
                }

                field("Next Service Date"; "Next Service Date")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Doc No"; "Doc No")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field(Approval; Approval)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }
}