page 50347 "Plan History List part"
{
    PageType = ListPart;
    SourceTable = "NavApp Planning Lines";
    SourceTableView = sorting("Style No.", "Lot No.", "Line No.") order(ascending);
    Editable = false;
    Caption = 'Plan THistory';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                }

                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sub PO No';
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                }

                field(StartDateTime; StartDateTime)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date/Time';
                }

                field(FinishDateTime; FinishDateTime)
                {
                    ApplicationArea = All;
                    Caption = 'Finish Date/Time';
                }

                field("Resource Name"; "Resource Name")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Line';
                }

                field(Carder; Carder)
                {
                    ApplicationArea = All;
                    Caption = 'No of Machines';
                }

                field(Eff; Eff)
                {
                    ApplicationArea = All;
                    Caption = 'Efficiency';
                }

                field(SMV; SMV)
                {
                    ApplicationArea = All;
                }
                field("Learning Curve No."; "Learning Curve No.")
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
        SetFilter("Style No.", StyleNo);
    end;


    procedure PassParameters(StyleNoPara: Text);
    var
    begin
        StyleNo := StyleNoPara;
    end;

    var
        StyleNo: Text;

}