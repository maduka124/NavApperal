page 50840 "Plan Lines - Search List"
{
    PageType = list;
    SourceTable = "NavApp Planning Lines";
    SourceTableView = sorting("Style No.", "Lot No.", "Line No.") order(ascending);
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    Caption = 'Planned History - Search';

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

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                }

                field("Resource Name"; "Resource Name")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Line';
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
}