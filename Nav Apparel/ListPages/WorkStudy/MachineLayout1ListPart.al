page 50485 "Machine Layout 1 Listpart"
{
    PageType = ListPart;
    SourceTable = "Machine Layout";
    SourceTableView = where(Type = filter(1));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("WP No."; "WP No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Wp No';
                }

                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';

                    trigger OnValidate()
                    var
                        MachineLayout1Rec: Record "Machine Layout Line1";
                        MachineLayoutRec: Record "Machine Layout";
                    begin

                        //Check for duplicates
                        MachineLayoutRec.Reset();
                        MachineLayoutRec.SetRange("No.", "No.");
                        MachineLayoutRec.SetRange("Line No.", "Line No.");

                        if not MachineLayoutRec.FindSet() then begin

                            MachineLayout1Rec.Reset();
                            MachineLayout1Rec.SetRange("No.", "No.");
                            MachineLayout1Rec.SetRange("Line No.", "Line No.");

                            if MachineLayout1Rec.FindSet() then begin

                                //Assign selected values
                                Code := MachineLayout1Rec.Code;
                                Description := MachineLayout1Rec.Description;
                                "Machine No." := MachineLayout1Rec."Machine No.";
                                "Machine Name" := MachineLayout1Rec."Machine Name";
                                smv := MachineLayout1Rec.SMV;
                                Minutes := MachineLayout1Rec.Minutes;
                                Target := MachineLayout1Rec.Target;

                                //Delete from the top list
                                MachineLayout1Rec.ModifyAll("WP No", "WP No.");
                                CurrPage.Update();

                            end;
                        end
                        else
                            Error('Already assigned');
                    end;
                }

                field(Code; Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Op Code';
                }

                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Machine No."; "Machine No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Machine';
                }

                field(Minutes; Minutes)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Target; Target)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        MachineLayoutineRec: Record "Machine Layout Line1";
    begin

        MachineLayoutineRec.Reset();
        MachineLayoutineRec.SetRange("No.", "No.");
        MachineLayoutineRec.SetRange("Line No.", "Line No.");
        MachineLayoutineRec.FindSet();
        MachineLayoutineRec.ModifyAll("WP No", 0);
        CurrPage.Update();

    end;
}