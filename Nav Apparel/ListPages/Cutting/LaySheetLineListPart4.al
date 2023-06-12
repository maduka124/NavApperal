page 50655 "Lay Sheet Line4"
{
    PageType = ListPart;
    SourceTable = LaySheetLine4;
    SourceTableView = sorting("LaySheetNo.", "Line No.");
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Color; rec.Color)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        colorRec: Record Colour;
                    begin
                        colorRec.Reset();
                        colorRec.SetRange("Colour Name", rec.Color);
                        colorRec.FindSet();
                        rec."Color No." := colorRec."No.";
                    end;
                }

                field(Shade; Rec.Shade)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ShadeRec: Record Shade;
                    begin
                        ShadeRec.Reset();
                        ShadeRec.SetRange(Shade, Rec.Shade);
                        if ShadeRec.FindSet() then
                            Rec."Shade No" := ShadeRec."No.";
                    end;
                }

                // field(Batch; Rec.Batch)
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }

                field("Role ID"; Rec."Role ID")
                {
                    ApplicationArea = All;
                    Caption = 'Roll No';
                }

                // field("Ticket Length"; Rec."Ticket Length")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }

                // field("Allocated Qty"; Rec."Allocated Qty")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }

                // field("Planned Plies"; Rec."Planned Plies")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Plies';
                // }

                field("Actual Plies"; Rec."Actual Plies")
                {
                    ApplicationArea = All;
                    Caption = 'Plies';
                }

                // field(Damages; Rec.Damages)
                // {
                //     ApplicationArea = All;
                // }

                // field(Joints; Rec.Joints)
                // {
                //     ApplicationArea = All;
                // }

                // field(Ends; Rec.Ends)
                // {
                //     ApplicationArea = All;
                // }

                // field("Shortage +"; Rec."Shortage +")
                // {
                //     ApplicationArea = All;
                // }

                // field("Shortage -"; Rec."Shortage -")
                // {
                //     ApplicationArea = All;
                // }

                // field("Binding Length"; Rec."Binding Length")
                // {
                //     ApplicationArea = All;
                // }
                // field(Comments; Rec.Comments)
                // {
                //     ApplicationArea = All;
                // }
            }
        }
    }
}