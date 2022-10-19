report 50817 ManpowerBudgetReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Summary of Worker Manpower Report';
    RDLCLayout = 'Report_Layouts/Workstudy/ManpowerBudgetReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(FactoryManpowerBudgetLine; FactoryManpowerBudgetLine)
        {
            DataItemTableView = sorting(LineNo);

            column(Factory_Name; "Factory Name")
            { }
            column(Date; Date)
            { }
            column(Department_Name; "Department Name")
            { }
            column(Category_Name; "Category Name")
            { }
            column(Act_Budget; "Act Budget")
            { }
            column(Final_Budget_with_Absenteesm; "Final Budget with Absenteesm")
            { }
            column(Current_onrall; "Current onrall")
            { }
            column(Absent; Absent)
            { }
            column(Leave; Leave)
            { }
            column(Net_Present; "Net Present")
            { }
            column(Excess_Short; "Excess/Short")
            { }
            column(Remarks; Remarks)
            { }
            column(Type; Type)
            { }
            column(CompLogo; comRec.Picture)
            { }

            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Factory Code", FFactory);
                SetRange(Date, FDate);
                SetFilter("Show In Report", '=%1', true);
            end;
        }

        dataitem(ManpowBudSummary; ManpowBudSummary)
        {
            DataItemTableView = sorting(LineNo);

            column(CategoryNameSummary; "Category Name")
            { }
            column(ActBudgetSummary; "Act Budget")
            { }
            column(FinalBudgetSummary; "Final Budget with Absenteesm")
            { }

            trigger OnPreDataItem()
            begin
                SetRange("Factory Code", FFactory);
                SetRange(Date, FDate);
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
                    field(Factory; FFactory)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        //TableRelation = FactoryManpowerBudgetLine."Factory Name";
                    }

                    field(Date; FDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    var
        UserRec: Record "User Setup";
    begin
        UserRec.Reset();
        UserRec.SetRange("User ID", UserId);
        if UserRec.FindSet() then begin
            FFactory := UserRec."Factory Code";
        end;
    end;

    var
        FFactory: Text[20];
        FDate: date;
        comRec: Record "Company Information";
}