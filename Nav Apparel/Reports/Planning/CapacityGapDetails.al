report 50623 CapacityGapDetailsReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Capacity Gap Details Report';
    RDLCLayout = 'Report_Layouts/Planning/CapacityGapDetailsReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("NavApp Planning Lines"; "NavApp Planning Lines")
        {
            DataItemTableView = sorting("Style No.");
            column(Resource_No_; WorkCenterName)
            { }
            column(Start_Date; "Start Date")
            { }
            column(End_Date; "End Date")
            { }
            column(Qty; Qty)
            { }
            column(Factory_Name; Factory_Name)
            { }
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }
            // column(FirstDate; FirstDate)
            // { }
            column(LastDate; "End Date" - "Start Date")
            { }
            column(CompLogo; comRec.Picture)
            { }

            dataitem("NavApp Prod Plans Details"; "NavApp Prod Plans Details")
            {
                DataItemLinkReference = "NavApp Planning Lines";
                DataItemLink = "Line No." = field("Line No.");
                DataItemTableView = sorting("No.");
                column(OperHours; Carder * HoursPerDay)
                { }
                column(Line_No_; "Line No.")
                { }
                column(firDate; firDate)
                { }
                column(FirstDate; FirstDate)
                { }
                column(Lasdate; Lasdate)
                { }
                column(sumFirstDate; sumFirstDate)
                { }
                trigger OnAfterGetRecord()

                begin
                    NavAppLineRec.SetRange("Line No.", "NavApp Prod Plans Details"."Line No.");
                    if NavAppLineRec.FindFirst() then begin
                        firDate := NavAppLineRec."Start Date";
                        Lasdate := NavAppLineRec."End Date";
                        FirstDate := Lasdate - firDate;

                    end;
                    sumFirstDate += FirstDate;
                end;
                // trigger OnAfterGetRecord()
                // var
                //     Onecarder: Integer;
                //     OneHours: Decimal;
                //     Twocarder: Integer;
                //     TwoHours: Decimal;
                //     Threecarder: Decimal;
                //     ThreeHours: Decimal;
                //     Fourcarder: Decimal;
                //     FourHours: Decimal;
                // begin

                //     cardSum := 0;
                //     hourSum := 0;
                //     Onecarder := 0;
                //     OneHours := 0;
                //     Twocarder := 0;
                //     TwoHours := 0;
                //     OperHours := 0;


                // ProdPlanRec.Reset();
                // ProdPlanRec.SetRange("Line No.", "NavApp Planning Lines"."Line No.");
                // ProdPlanRec.SetRange("Resource No.", "NavApp Planning Lines"."Resource No.");
                // if ProdPlanRec.FindFirst() then begin

                //     if "Line No." = 1 then begin
                //         Onecarder := Carder;
                //         OneHours := HoursPerDay;
                //         One := Onecarder * OneHours;
                //     end
                //     else
                //         if "Line No." = 2 then begin
                //             Twocarder += Carder;
                //             TwoHours += HoursPerDay;
                //             Two := Onecarder * OneHours;
                //         end
                //         else
                //             if "Line No." = 3 then begin
                //                 Threecarder += Carder;
                //                 ThreeHours += HoursPerDay;
                //                 Three := Onecarder * OneHours;
                //             end;

                //     if "NavApp Planning Lines"."Line No." = 1 then begin
                //         OperHours := One;
                //     end
                //     else
                //         if "NavApp Planning Lines"."Line No." = 2 then begin
                //             OperHours := Two;
                //         end
                //         else

                //             if "NavApp Planning Lines"."Line No." = 3 then begin
                //                 OperHours := Three;
                //             end
                //             else
                //                 if "NavApp Planning Lines"."Line No." = 4 then begin
                //                     OperHours := Four;
                //                 end;

                // end;

                // Days := endDate - "Start Date";
                // Message('%1', Days);

                // LastDate := CALCDATE('1D', );
                // FirstDate := CALCDATE('1D', );



                // end;



            }
            trigger OnAfterGetRecord()

            begin
                StyleMasterRec.SetRange("No.", "NavApp Planning Lines"."Style No.");
                if StyleMasterRec.FindFirst() then begin
                    Factory_Name := StyleMasterRec."Factory Name";
                end;
                comRec.Get;
                comRec.CalcFields(Picture);

                WorkCenterRec.SetRange("No.", "Resource No.");
                if WorkCenterRec.FindFirst() then begin
                    WorkCenterName := WorkCenterRec.Name;
                end;

            end;

            trigger OnPreDataItem()
            begin
                SetRange("Start Date", stDate, endDate);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(stDate; stDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';

                    }
                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }


    var
        WorkCenterName: Text[100];
        StyleMasterRec: Record "Style Master";
        Factory_Name: Text[50];
        LastDate: Decimal;
        FirstDate: Integer;
        stDate: Date;
        endDate: Date;
        ProdPlanRec: Record "NavApp Prod Plans Details";
        OperHours: Decimal;
        cardSum: Integer;
        hourSum: Decimal;
        One: Decimal;
        Two: Decimal;
        Three: Decimal;
        Four: Decimal;
        NavAppLineRec: Record "NavApp Planning Lines";
        firDate: Date;
        Lasdate: Date;
        sumFirstDate: Integer;
        comRec: Record "Company Information";
        WorkCenterRec: Record "Work Center";


}