page 50480 "Machine Layout List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Machine Layout Header";
    CardPageId = "Machine Layout Card";
    Caption = 'Machine Layout';


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Layout No';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Work Center Name"; "Work Center Name")
                {
                    ApplicationArea = All;
                    Caption = 'Work Center';
                }

                field("Garment Type"; "Garment Type")
                {
                    ApplicationArea = All;
                }

                field("Expected Eff"; "Expected Eff")
                {
                    ApplicationArea = All;
                }

                field("Expected Target"; "Expected Target")
                {
                    ApplicationArea = All;
                }

                field("No of Workstation"; "No of Workstation")
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
        MachineLayoutineRec.SetRange("No.", "No.");
        MachineLayoutineRec.DeleteAll();

        MachineLayout1Rec.Reset();
        MachineLayout1Rec.SetRange("No.", "No.");
        MachineLayout1Rec.DeleteAll();

    end;
}