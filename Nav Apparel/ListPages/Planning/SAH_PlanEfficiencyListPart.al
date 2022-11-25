page 50864 SAH_PlanEfficiencyListPart
{
    PageType = ListPart;
    SourceTable = SAH_PlanEfficiency;
    SourceTableView = sorting(Year) order(ascending);
    Caption = ' ';
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(JAN; JAN)
                {
                    ApplicationArea = All;
                    Editable = JAN_EDITABLE;
                }

                field(FEB; FEB)
                {
                    ApplicationArea = All;
                    Editable = FEB_EDITABLE;
                }

                field(MAR; MAR)
                {
                    ApplicationArea = All;
                    Editable = MAR_EDITABLE;
                }

                field(APR; APR)
                {
                    ApplicationArea = All;
                    Editable = APR_EDITABLE;
                }

                field(MAY; MAY)
                {
                    ApplicationArea = All;
                    Editable = MAY_EDITABLE;
                }

                field(JUN; JUN)
                {
                    ApplicationArea = All;
                    Editable = JUN_EDITABLE;
                }

                field(JUL; JUL)
                {
                    ApplicationArea = All;
                    Editable = JUL_EDITABLE;
                }

                field(AUG; AUG)
                {
                    ApplicationArea = All;
                    Editable = AUG_EDITABLE;
                }

                field(SEP; SEP)
                {
                    ApplicationArea = All;
                    Editable = SEP_EDITABLE;
                }

                field(OCT; OCT)
                {
                    ApplicationArea = All;
                    Editable = OCT_EDITABLE;
                }

                field(NOV; NOV)
                {
                    ApplicationArea = All;
                    Editable = NOV_EDITABLE;
                }

                field(DEC; DEC)
                {
                    ApplicationArea = All;
                    Editable = DEC_EDITABLE;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
    begin
        evaluate(Month, copystr(Format(Today()), 4, 2));

        case Month of
            1:
                begin
                    JAN_EDITABLE := true;
                    FEB_EDITABLE := true;
                    MAR_EDITABLE := true;
                    APR_EDITABLE := true;
                    MAY_EDITABLE := true;
                    JUN_EDITABLE := true;
                    JUL_EDITABLE := true;
                    AUG_EDITABLE := true;
                    SEP_EDITABLE := true;
                    OCT_EDITABLE := true;
                    NOV_EDITABLE := true;
                    DEC_EDITABLE := true;
                end;
            2:
                begin
                    JAN_EDITABLE := false;
                    FEB_EDITABLE := true;
                    MAR_EDITABLE := true;
                    APR_EDITABLE := true;
                    MAY_EDITABLE := true;
                    JUN_EDITABLE := true;
                    JUL_EDITABLE := true;
                    AUG_EDITABLE := true;
                    SEP_EDITABLE := true;
                    OCT_EDITABLE := true;
                    NOV_EDITABLE := true;
                    DEC_EDITABLE := true;
                end;
            3:
                begin
                    JAN_EDITABLE := false;
                    FEB_EDITABLE := false;
                    MAR_EDITABLE := true;
                    APR_EDITABLE := true;
                    MAY_EDITABLE := true;
                    JUN_EDITABLE := true;
                    JUL_EDITABLE := true;
                    AUG_EDITABLE := true;
                    SEP_EDITABLE := true;
                    OCT_EDITABLE := true;
                    NOV_EDITABLE := true;
                    DEC_EDITABLE := true;
                end;
            4:
                begin
                    JAN_EDITABLE := false;
                    FEB_EDITABLE := false;
                    MAR_EDITABLE := false;
                    APR_EDITABLE := true;
                    MAY_EDITABLE := true;
                    JUN_EDITABLE := true;
                    JUL_EDITABLE := true;
                    AUG_EDITABLE := true;
                    SEP_EDITABLE := true;
                    OCT_EDITABLE := true;
                    NOV_EDITABLE := true;
                    DEC_EDITABLE := true;
                end;
            5:
                begin
                    JAN_EDITABLE := false;
                    FEB_EDITABLE := false;
                    MAR_EDITABLE := false;
                    APR_EDITABLE := false;
                    MAY_EDITABLE := true;
                    JUN_EDITABLE := true;
                    JUL_EDITABLE := true;
                    AUG_EDITABLE := true;
                    SEP_EDITABLE := true;
                    OCT_EDITABLE := true;
                    NOV_EDITABLE := true;
                    DEC_EDITABLE := true;
                end;
            6:
                begin
                    JAN_EDITABLE := false;
                    FEB_EDITABLE := false;
                    MAR_EDITABLE := false;
                    APR_EDITABLE := false;
                    MAY_EDITABLE := false;
                    JUN_EDITABLE := true;
                    JUL_EDITABLE := true;
                    AUG_EDITABLE := true;
                    SEP_EDITABLE := true;
                    OCT_EDITABLE := true;
                    NOV_EDITABLE := true;
                    DEC_EDITABLE := true;
                end;
            7:
                begin
                    JAN_EDITABLE := false;
                    FEB_EDITABLE := false;
                    MAR_EDITABLE := false;
                    APR_EDITABLE := false;
                    MAY_EDITABLE := false;
                    JUN_EDITABLE := false;
                    JUL_EDITABLE := true;
                    AUG_EDITABLE := true;
                    SEP_EDITABLE := true;
                    OCT_EDITABLE := true;
                    NOV_EDITABLE := true;
                    DEC_EDITABLE := true;
                end;
            8:
                begin
                    JAN_EDITABLE := false;
                    FEB_EDITABLE := false;
                    MAR_EDITABLE := false;
                    APR_EDITABLE := false;
                    MAY_EDITABLE := false;
                    JUN_EDITABLE := false;
                    JUL_EDITABLE := false;
                    AUG_EDITABLE := true;
                    SEP_EDITABLE := true;
                    OCT_EDITABLE := true;
                    NOV_EDITABLE := true;
                    DEC_EDITABLE := true;
                end;
            9:
                begin
                    JAN_EDITABLE := false;
                    FEB_EDITABLE := false;
                    MAR_EDITABLE := false;
                    APR_EDITABLE := false;
                    MAY_EDITABLE := false;
                    JUN_EDITABLE := false;
                    JUL_EDITABLE := false;
                    AUG_EDITABLE := false;
                    SEP_EDITABLE := true;
                    OCT_EDITABLE := true;
                    NOV_EDITABLE := true;
                    DEC_EDITABLE := true;
                end;

            10:
                begin
                    JAN_EDITABLE := false;
                    FEB_EDITABLE := false;
                    MAR_EDITABLE := false;
                    APR_EDITABLE := false;
                    MAY_EDITABLE := false;
                    JUN_EDITABLE := false;
                    JUL_EDITABLE := false;
                    AUG_EDITABLE := false;
                    SEP_EDITABLE := false;
                    OCT_EDITABLE := true;
                    NOV_EDITABLE := true;
                    DEC_EDITABLE := true;
                end;

            11:
                begin
                    JAN_EDITABLE := false;
                    FEB_EDITABLE := false;
                    MAR_EDITABLE := false;
                    APR_EDITABLE := false;
                    MAY_EDITABLE := false;
                    JUN_EDITABLE := false;
                    JUL_EDITABLE := false;
                    AUG_EDITABLE := false;
                    SEP_EDITABLE := false;
                    OCT_EDITABLE := false;
                    NOV_EDITABLE := true;
                    DEC_EDITABLE := true;
                end;

            12:
                begin
                    JAN_EDITABLE := false;
                    FEB_EDITABLE := false;
                    MAR_EDITABLE := false;
                    APR_EDITABLE := false;
                    MAY_EDITABLE := false;
                    JUN_EDITABLE := false;
                    JUL_EDITABLE := false;
                    AUG_EDITABLE := false;
                    SEP_EDITABLE := false;
                    OCT_EDITABLE := false;
                    NOV_EDITABLE := false;
                    DEC_EDITABLE := true;
                end;
        end;
    end;


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
}