page 50347 "Plan History List part"
{
    PageType = ListPart;
    SourceTable = "NavApp Planning Lines";
    SourceTableView = sorting("Style No.", "Lot No.", "Line No.") order(ascending);
    Editable = false;
    Caption = 'Plan History';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                }

                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sub PO No';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                }

                field(StartDateTime; rec.StartDateTime)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date/Time';
                }

                field(FinishDateTime; rec.FinishDateTime)
                {
                    ApplicationArea = All;
                    Caption = 'Finish Date/Time';
                }

                field("Resource Name"; rec."Resource Name")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Line';
                }

                field(Carder; rec.Carder)
                {
                    ApplicationArea = All;
                    Caption = 'No of Machines';
                }

                field(Eff; rec.Eff)
                {
                    ApplicationArea = All;
                    Caption = 'Efficiency';
                }

                field(SMV; rec.SMV)
                {
                    ApplicationArea = All;
                }
                field("Learning Curve No."; rec."Learning Curve No.")
                {
                    ApplicationArea = All;
                    Caption = 'Learning Curve';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
    begin
        rec.SetFilter("Style No.", StyleNo);
    end;


    procedure PassParameters(StyleNoPara: Text);
    var
    begin
        StyleNo := StyleNoPara;
    end;

    var
        StyleNo: Text;

}