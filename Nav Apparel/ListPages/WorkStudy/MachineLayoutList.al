page 50480 "Machine Layout List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Machine Layout Header";
    CardPageId = "Machine Layout Card";
    Caption = 'Machine Layout';
    SourceTableView = sorting("No.", "Style No.", "Style Name") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Layout No';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Work Center Name"; rec."Work Center Name")
                {
                    ApplicationArea = All;
                    Caption = 'Work Center';
                }

                field("Garment Type"; rec."Garment Type")
                {
                    ApplicationArea = All;
                }

                field("Expected Eff"; rec."Expected Eff")
                {
                    ApplicationArea = All;
                }

                field("Expected Target"; rec."Expected Target")
                {
                    ApplicationArea = All;
                }

                field("No of Workstation"; rec."No of Workstation")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        MachineLayoutineRec: Record "Machine Layout Line1";
        MachineLayout1Rec: Record "Machine Layout";
    begin

        MachineLayoutineRec.Reset();
        MachineLayoutineRec.SetRange("No.", rec."No.");
        MachineLayoutineRec.DeleteAll();

        MachineLayout1Rec.Reset();
        MachineLayout1Rec.SetRange("No.", rec."No.");
        MachineLayout1Rec.DeleteAll();

    end;
}