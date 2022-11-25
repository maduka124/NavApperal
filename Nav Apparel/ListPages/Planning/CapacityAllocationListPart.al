page 50854 CapacityAllocationListPart
{
    PageType = ListPart;
    SourceTable = CapacityAllocation;
    SourceTableView = sorting("No.") order(ascending);
    Caption = 'Capacity Allocation';

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
                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                }

                field("Line Name"; "Line Name")
                {
                    ApplicationArea = All;
                    Caption = 'Line';
                }

                field(JAN; JAN)
                {
                    ApplicationArea = All;
                }

                field(FEB; FEB)
                {
                    ApplicationArea = All;
                }

                field(MAR; MAR)
                {
                    ApplicationArea = All;
                }

                field(APR; APR)
                {
                    ApplicationArea = All;
                }

                field(MAY; MAY)
                {
                    ApplicationArea = All;
                }

                field(JUN; JUN)
                {
                    ApplicationArea = All;
                }

                field(JUL; JUL)
                {
                    ApplicationArea = All;
                }

                field(AUG; AUG)
                {
                    ApplicationArea = All;
                }

                field(SEP; SEP)
                {
                    ApplicationArea = All;
                }

                field(OCT; OCT)
                {
                    ApplicationArea = All;
                }

                field(NOV; NOV)
                {
                    ApplicationArea = All;
                }

                field(DEC; DEC)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    // var
    //     YearGB: Integer;

}