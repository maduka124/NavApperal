page 50474 "Maning Level List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Maning Level";
    CardPageId = "Maning Level Card";
    Caption = 'Maning Levels';
    SourceTableView = sorting("No.") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Maning No';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line';
                }

                field(Type; Type)
                {
                    ApplicationArea = All;
                }

                field(Val; Val)
                {
                    ApplicationArea = All;
                    Caption = 'Qty';
                }

                field(Eff; Eff)
                {
                    ApplicationArea = All;
                    Caption = 'Expected Eff %';
                }

                field("Total SMV"; "Total SMV")
                {
                    ApplicationArea = All;
                    Caption = 'Total Sewing SMV';
                }

                field("Sewing SMV"; "Sewing SMV")
                {
                    ApplicationArea = All;
                    Caption = 'Sewing SMV';
                }

                field("Manual SMV"; "Manual SMV")
                {
                    ApplicationArea = All;
                    Caption = 'Manual SMV';
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        ManingLevelsLineRec: Record "Maning Levels Line";
    begin

        ManingLevelsLineRec.Reset();
        ManingLevelsLineRec.SetRange("No.", "No.");
        ManingLevelsLineRec.DeleteAll();

    end;
}