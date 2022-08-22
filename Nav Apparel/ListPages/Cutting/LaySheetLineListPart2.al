page 50651 "Lay Sheet Line2"
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
                field("Pattern Version"; "Pattern Version")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("No of Plies"; "No of Plies")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(LayLength; LayLength)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Lay Length';
                }

                field("Cutting Wastage"; "Cutting Wastage")
                {
                    ApplicationArea = All;
                    Caption = 'Cutting Wastage (%)';
                }

                field("Fab. Req. For Lay"; "Fab. Req. For Lay")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Act. Width"; "Act. Width")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Revised Marker Length"; "Revised Marker Length")
                {
                    ApplicationArea = All;
                }

                field("Revised Tot. Fab. Req."; "Revised Tot. Fab. Req.")
                {
                    ApplicationArea = All;
                }

                field("Issued Qty(Meters)"; "Issued Qty(Meters)")
                {
                    ApplicationArea = All;
                }

                field("Retuned Qty(Meters)"; "Retuned Qty(Meters)")
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