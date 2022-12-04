page 50854 SAH_CapacityAllocationListPart
{
    PageType = ListPart;
    SourceTable = SAH_CapacityAllocation;
    SourceTableView = sorting("No.") order(ascending);
    Caption = ' ';

    layout
    {
        area(Content)
        {
            // group(" ")
            // {
            //     field(YearGB; YearGB)
            //     {
            //         ApplicationArea = all;
            //         TableRelation = YearTable.Year;
            //         Caption = 'Year';

            //         trigger OnValidate()
            //         var
            //         begin
            //             SetFilter(Year, '=%1', YearGB);
            //         end;
            //     }
            // }

            repeater(General)
            {
                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                }

                field("Line Name"; rec."Line Name")
                {
                    ApplicationArea = All;
                    Caption = 'Line';
                }

                field(JAN; rec.JAN)
                {
                    ApplicationArea = All;
                }

                field(FEB; rec.FEB)
                {
                    ApplicationArea = All;
                }

                field(MAR; rec.MAR)
                {
                    ApplicationArea = All;
                }

                field(APR; rec.APR)
                {
                    ApplicationArea = All;
                }

                field(MAY; rec.MAY)
                {
                    ApplicationArea = All;
                }

                field(JUN; rec.JUN)
                {
                    ApplicationArea = All;
                }

                field(JUL; rec.JUL)
                {
                    ApplicationArea = All;
                }

                field(AUG; rec.AUG)
                {
                    ApplicationArea = All;
                }

                field(SEP; rec.SEP)
                {
                    ApplicationArea = All;
                }

                field(OCT; rec.OCT)
                {
                    ApplicationArea = All;
                }

                field(NOV; rec.NOV)
                {
                    ApplicationArea = All;
                }

                field(DEC; rec.DEC)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    // var
    //     YearGB: Integer;

}