page 50655 "Lay Sheet Line4"
{
    PageType = ListPart;
    SourceTable = LaySheetLine4;
    SourceTableView = sorting("LaySheetNo.", "Line No.");
    InsertAllowed = true;
    DeleteAllowed = true;
    ModifyAllowed = true;
    AutoSplitKey = true;

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
                        colorRec: Record LaySheetColor;
                    begin
                        colorRec.Reset();
                        colorRec.SetRange(Color, rec.Color);
                        colorRec.SetRange("LaySheetNo.", rec."LaySheetNo.");
                        if colorRec.FindSet() then
                            rec."Color No." := colorRec."Color No."
                        else
                            Error('Cannot find color in Laysheetcolor.');
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

                    trigger OnValidate()
                    var
                        LaysheetRec: Record LaySheetHeader;
                        LaysheetLine4Rec: Record LaySheetLine4;
                        Tot: Decimal;
                    begin
                        CurrPage.Update();
                        LaysheetLine4Rec.Reset();
                        LaysheetLine4Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
                        if LaysheetLine4Rec.FindSet() then begin
                            repeat
                                Tot += LaysheetLine4Rec."Actual Plies";
                            until LaysheetLine4Rec.Next() = 0;
                        end;

                        LaysheetRec.Reset();
                        LaysheetRec.SetRange("LaySheetNo.", rec."LaySheetNo.");
                        if LaysheetRec.FindSet() then
                            LaysheetRec.ModifyAll(TotalPies, Tot);
                    end;
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

    trigger OnDeleteRecord(): Boolean
    var
        LaysheetRec: Record LaySheetHeader;
        LaysheetLine4Rec: Record LaySheetLine4;
        Tot: Decimal;
    begin
        LaysheetLine4Rec.Reset();
        LaysheetLine4Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
        LaysheetLine4Rec.SetRange("Line No.", rec."Line No.");
        if LaysheetLine4Rec.FindSet() then
            LaysheetLine4Rec.Delete();

        CurrPage.Update();

        LaysheetLine4Rec.Reset();
        LaysheetLine4Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
        if LaysheetLine4Rec.FindSet() then begin
            repeat
                Tot += LaysheetLine4Rec."Actual Plies";
            until LaysheetLine4Rec.Next() = 0;
        end;

        LaysheetRec.Reset();
        LaysheetRec.SetRange("LaySheetNo.", rec."LaySheetNo.");
        if LaysheetRec.FindSet() then
            LaysheetRec.ModifyAll(TotalPies, Tot);

    end;
}