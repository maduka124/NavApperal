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
                field("Service Item No"; rec."Service Item No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Service Item Name"; rec."Service Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Work Center Name"; rec."Work Center Name")
                {
                    ApplicationArea = All;
                    Caption = 'Work Center';
                    Editable = false;
                }

                field("Service Date"; rec."Service Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Standard Service Desc"; rec."Standard Service Desc")
                {
                    ApplicationArea = All;
                    Caption = 'Standard Service Code';
                    Editable = true;

                    trigger OnValidate()
                    var
                        StanSerCodeRec: Record "Standard Service Code";
                    begin
                        StanSerCodeRec.Reset();
                        StanSerCodeRec.SetRange(Description, rec."Standard Service Desc");
                        if StanSerCodeRec.FindSet() then
                            rec."Standard Service Code" := StanSerCodeRec.Code;
                    end;
                }

                field("Next Service Date"; rec."Next Service Date")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Doc No"; rec."Doc No")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field(Approval; rec.Approval)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }
}