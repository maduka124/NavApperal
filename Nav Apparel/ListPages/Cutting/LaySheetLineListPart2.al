page 50664 "Lay Sheet Line2"
{
    PageType = ListPart;
    SourceTable = LaySheetLine2;
    SourceTableView = sorting("LaySheetNo.", "Line No") order(ascending);
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Pattern Version"; Rec."Pattern Version")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("No of Plies"; Rec."No of Plies")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(LayLength; Rec.LayLength)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Lay Length';
                }

                field("Cutting Wastage"; Rec."Cutting Wastage")
                {
                    ApplicationArea = All;
                    Caption = 'Cutting Wastage (%)';
                }

                field("Fab. Req. For Lay"; Rec."Fab. Req. For Lay")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Act. Width"; Rec."Act. Width")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Revised Marker Length"; Rec."Revised Marker Length")
                {
                    ApplicationArea = All;
                }

                field("Revised Tot. Fab. Req."; Rec."Revised Tot. Fab. Req.")
                {
                    ApplicationArea = All;
                }

                field("Issued Qty(Meters)"; Rec."Issued Qty(Meters)")
                {
                    ApplicationArea = All;
                }

                field("Retuned Qty(Meters)"; Rec."Retuned Qty(Meters)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    // trigger OnAfterGetRecord()
    // var
    // begin
    //     StyleExprTxt := ChangeColor.ChangeColorCutCreation(Rec);

    //     // if ("Record Type" = 'R') then begin
    //     //     Clear(SetEdit1);
    //     //     SetEdit1 := true;
    //     // end
    //     // ELSE begin
    //     //     Clear(SetEdit1);
    //     //     SetEdit1 := false;
    //     // end;
    // end;


    // trigger OnAfterGetCurrRecord()
    // var
    // begin
    //     StyleExprTxt := ChangeColor.ChangeColorCutCreation(Rec);

    //     // if ("Record Type" = 'R') then begin
    //     //     Clear(SetEdit1);
    //     //     SetEdit1 := true;
    //     // end
    //     // ELSE begin
    //     //     Clear(SetEdit1);
    //     //     SetEdit1 := false;
    //     // end;
    // end;


    // var
    //     StyleExprTxt: Text[50];
    //     ChangeColor: Codeunit NavAppCodeUnit;
    //     SetEdit1: Boolean;

}