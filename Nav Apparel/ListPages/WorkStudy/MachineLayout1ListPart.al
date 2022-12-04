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
                field("WP No."; rec."WP No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Wp No';
                }

                field("Line No."; rec."Line No.")
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
                        MachineLayoutRec.SetRange("No.", rec."No.");
                        MachineLayoutRec.SetRange("Line No.", rec."Line No.");

                        if not MachineLayoutRec.FindSet() then begin

                            MachineLayout1Rec.Reset();
                            MachineLayout1Rec.SetRange("No.", rec."No.");
                            MachineLayout1Rec.SetRange("Line No.", rec."Line No.");

                            if MachineLayout1Rec.FindSet() then begin

                                //Assign selected values
                                rec.Code := MachineLayout1Rec.Code;
                                rec.Description := MachineLayout1Rec.Description;
                                rec."Machine No." := MachineLayout1Rec."Machine No.";
                                rec."Machine Name" := MachineLayout1Rec."Machine Name";
                                rec.smv := MachineLayout1Rec.SMV;
                                rec.Minutes := MachineLayout1Rec.Minutes;
                                rec.Target := MachineLayout1Rec.Target;

                                //Delete from the top list
                                MachineLayout1Rec.ModifyAll("WP No", rec."WP No.");
                                CurrPage.Update();

                            end;
                        end
                        else
                            Error('Already assigned');
                    end;
                }

                field(Code; rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Op Code';
                }

                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Machine No."; rec."Machine No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Machine';
                }

                field(Minutes; rec.Minutes)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Target; rec.Target)
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
        MachineLayoutineRec.SetRange("No.", rec."No.");
        MachineLayoutineRec.SetRange("Line No.", rec."Line No.");
        MachineLayoutineRec.FindSet();
        MachineLayoutineRec.ModifyAll("WP No", 0);
        CurrPage.Update();

    end;
}