page 50867 SAH_FactoryCapacityListPart
{
    PageType = ListPart;
    SourceTable = SAH_FactoryCapacity;
    SourceTableView = sorting("No.", Year, "Factory Name") order(ascending);
    Caption = ' ';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;
                    //Editable = JAN_EDITABLE;
                    StyleExpr = StyleExprTxt;
                }

                field(JAN; rec.JAN)
                {
                    ApplicationArea = All;
                    //Editable = JAN_EDITABLE;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(FEB; rec.FEB)
                {
                    ApplicationArea = All;
                    //Editable = FEB_EDITABLE;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(MAR; rec.MAR)
                {
                    ApplicationArea = All;
                    //Editable = MAR_EDITABLE;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(APR; rec.APR)
                {
                    ApplicationArea = All;
                    //Editable = APR_EDITABLE;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(MAY; rec.MAY)
                {
                    ApplicationArea = All;
                    //Editable = MAY_EDITABLE;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(JUN; rec.JUN)
                {
                    ApplicationArea = All;
                    //Editable = JUN_EDITABLE;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(JUL; rec.JUL)
                {
                    ApplicationArea = All;
                    //Editable = JUL_EDITABLE;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(AUG; rec.AUG)
                {
                    ApplicationArea = All;
                    //Editable = AUG_EDITABLE;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(SEP; rec.SEP)
                {
                    ApplicationArea = All;
                    //Editable = SEP_EDITABLE;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(OCT; rec.OCT)
                {
                    ApplicationArea = All;
                    //Editable = OCT_EDITABLE;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(NOV; rec.NOV)
                {
                    ApplicationArea = All;
                    //Editable = NOV_EDITABLE;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field(DEC; rec.DEC)
                {
                    ApplicationArea = All;
                    //Editable = DEC_EDITABLE;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }
            }
        }
    }

    // trigger OnAfterGetRecord()
    // var
    // begin
    //     evaluate(Month, copystr(Format(Today()), 4, 2));

    //     case Month of
    //         1:
    //             begin
    //                 JAN_EDITABLE := true;
    //                 FEB_EDITABLE := true;
    //                 MAR_EDITABLE := true;
    //                 APR_EDITABLE := true;
    //                 MAY_EDITABLE := true;
    //                 JUN_EDITABLE := true;
    //                 JUL_EDITABLE := true;
    //                 AUG_EDITABLE := true;
    //                 SEP_EDITABLE := true;
    //                 OCT_EDITABLE := true;
    //                 NOV_EDITABLE := true;
    //                 DEC_EDITABLE := true;
    //             end;
    //         2:
    //             begin
    //                 JAN_EDITABLE := false;
    //                 FEB_EDITABLE := true;
    //                 MAR_EDITABLE := true;
    //                 APR_EDITABLE := true;
    //                 MAY_EDITABLE := true;
    //                 JUN_EDITABLE := true;
    //                 JUL_EDITABLE := true;
    //                 AUG_EDITABLE := true;
    //                 SEP_EDITABLE := true;
    //                 OCT_EDITABLE := true;
    //                 NOV_EDITABLE := true;
    //                 DEC_EDITABLE := true;
    //             end;
    //         3:
    //             begin
    //                 JAN_EDITABLE := false;
    //                 FEB_EDITABLE := false;
    //                 MAR_EDITABLE := true;
    //                 APR_EDITABLE := true;
    //                 MAY_EDITABLE := true;
    //                 JUN_EDITABLE := true;
    //                 JUL_EDITABLE := true;
    //                 AUG_EDITABLE := true;
    //                 SEP_EDITABLE := true;
    //                 OCT_EDITABLE := true;
    //                 NOV_EDITABLE := true;
    //                 DEC_EDITABLE := true;
    //             end;
    //         4:
    //             begin
    //                 JAN_EDITABLE := false;
    //                 FEB_EDITABLE := false;
    //                 MAR_EDITABLE := false;
    //                 APR_EDITABLE := true;
    //                 MAY_EDITABLE := true;
    //                 JUN_EDITABLE := true;
    //                 JUL_EDITABLE := true;
    //                 AUG_EDITABLE := true;
    //                 SEP_EDITABLE := true;
    //                 OCT_EDITABLE := true;
    //                 NOV_EDITABLE := true;
    //                 DEC_EDITABLE := true;
    //             end;
    //         5:
    //             begin
    //                 JAN_EDITABLE := false;
    //                 FEB_EDITABLE := false;
    //                 MAR_EDITABLE := false;
    //                 APR_EDITABLE := false;
    //                 MAY_EDITABLE := true;
    //                 JUN_EDITABLE := true;
    //                 JUL_EDITABLE := true;
    //                 AUG_EDITABLE := true;
    //                 SEP_EDITABLE := true;
    //                 OCT_EDITABLE := true;
    //                 NOV_EDITABLE := true;
    //                 DEC_EDITABLE := true;
    //             end;
    //         6:
    //             begin
    //                 JAN_EDITABLE := false;
    //                 FEB_EDITABLE := false;
    //                 MAR_EDITABLE := false;
    //                 APR_EDITABLE := false;
    //                 MAY_EDITABLE := false;
    //                 JUN_EDITABLE := true;
    //                 JUL_EDITABLE := true;
    //                 AUG_EDITABLE := true;
    //                 SEP_EDITABLE := true;
    //                 OCT_EDITABLE := true;
    //                 NOV_EDITABLE := true;
    //                 DEC_EDITABLE := true;
    //             end;
    //         7:
    //             begin
    //                 JAN_EDITABLE := false;
    //                 FEB_EDITABLE := false;
    //                 MAR_EDITABLE := false;
    //                 APR_EDITABLE := false;
    //                 MAY_EDITABLE := false;
    //                 JUN_EDITABLE := false;
    //                 JUL_EDITABLE := true;
    //                 AUG_EDITABLE := true;
    //                 SEP_EDITABLE := true;
    //                 OCT_EDITABLE := true;
    //                 NOV_EDITABLE := true;
    //                 DEC_EDITABLE := true;
    //             end;
    //         8:
    //             begin
    //                 JAN_EDITABLE := false;
    //                 FEB_EDITABLE := false;
    //                 MAR_EDITABLE := false;
    //                 APR_EDITABLE := false;
    //                 MAY_EDITABLE := false;
    //                 JUN_EDITABLE := false;
    //                 JUL_EDITABLE := false;
    //                 AUG_EDITABLE := true;
    //                 SEP_EDITABLE := true;
    //                 OCT_EDITABLE := true;
    //                 NOV_EDITABLE := true;
    //                 DEC_EDITABLE := true;
    //             end;
    //         9:
    //             begin
    //                 JAN_EDITABLE := false;
    //                 FEB_EDITABLE := false;
    //                 MAR_EDITABLE := false;
    //                 APR_EDITABLE := false;
    //                 MAY_EDITABLE := false;
    //                 JUN_EDITABLE := false;
    //                 JUL_EDITABLE := false;
    //                 AUG_EDITABLE := false;
    //                 SEP_EDITABLE := true;
    //                 OCT_EDITABLE := true;
    //                 NOV_EDITABLE := true;
    //                 DEC_EDITABLE := true;
    //             end;

    //         10:
    //             begin
    //                 JAN_EDITABLE := false;
    //                 FEB_EDITABLE := false;
    //                 MAR_EDITABLE := false;
    //                 APR_EDITABLE := false;
    //                 MAY_EDITABLE := false;
    //                 JUN_EDITABLE := false;
    //                 JUL_EDITABLE := false;
    //                 AUG_EDITABLE := false;
    //                 SEP_EDITABLE := false;
    //                 OCT_EDITABLE := true;
    //                 NOV_EDITABLE := true;
    //                 DEC_EDITABLE := true;
    //             end;

    //         11:
    //             begin
    //                 JAN_EDITABLE := false;
    //                 FEB_EDITABLE := false;
    //                 MAR_EDITABLE := false;
    //                 APR_EDITABLE := false;
    //                 MAY_EDITABLE := false;
    //                 JUN_EDITABLE := false;
    //                 JUL_EDITABLE := false;
    //                 AUG_EDITABLE := false;
    //                 SEP_EDITABLE := false;
    //                 OCT_EDITABLE := false;
    //                 NOV_EDITABLE := true;
    //                 DEC_EDITABLE := true;
    //             end;

    //         12:
    //             begin
    //                 JAN_EDITABLE := false;
    //                 FEB_EDITABLE := false;
    //                 MAR_EDITABLE := false;
    //                 APR_EDITABLE := false;
    //                 MAY_EDITABLE := false;
    //                 JUN_EDITABLE := false;
    //                 JUL_EDITABLE := false;
    //                 AUG_EDITABLE := false;
    //                 SEP_EDITABLE := false;
    //                 OCT_EDITABLE := false;
    //                 NOV_EDITABLE := false;
    //                 DEC_EDITABLE := true;
    //             end;
    //     end;
    // end;


    var
        Month: Integer;
        JAN_EDITABLE: Boolean;
        FEB_EDITABLE: Boolean;
        MAR_EDITABLE: Boolean;
        APR_EDITABLE: Boolean;
        MAY_EDITABLE: Boolean;
        JUN_EDITABLE: Boolean;
        JUL_EDITABLE: Boolean;
        AUG_EDITABLE: Boolean;
        SEP_EDITABLE: Boolean;
        OCT_EDITABLE: Boolean;
        NOV_EDITABLE: Boolean;
        DEC_EDITABLE: Boolean;

    //Done By Sachith on 7/2/23
    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorBooking6(Rec);
    end;

    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
}