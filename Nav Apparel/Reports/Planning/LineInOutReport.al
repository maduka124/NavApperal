report 51256 lineinoutReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Line In & Out Report';
    RDLCLayout = 'Report_Layouts/Planning/LineIn&OutReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(ProductionOutHeader; ProductionOutHeader)
        {
            DataItemTableView = sorting("No.") where(Type = filter('Saw'));

            column(Resource_Name; "Resource Name")
            { }
            column(Buyer; Buyer)
            { }
            column(orderQty; orderQty)
            { }
            column(Style_Name; "Style Name")
            { }
            column(PO_No; "PO No")
            { }
            column(Input_Qty; "Input Qty")
            { }
            column(Output_Qty; "Output Qty")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(StDate; StDate)
            { }
            column(EndDate; EndDate)
            { }
            column(Factory_Name; "Factory Name")
            { }
            column(LocationRec; LocationRec.Name)
            { }
            column(Resource_No_; "Resource No.")
            { }

            trigger OnAfterGetRecord()
            begin

                Buyer := '';
                StyleRec.Reset();
                StyleRec.SetRange("No.", "Style No.");

                if StyleRec.FindSet() then
                    Buyer := StyleRec."Buyer Name";

                orderQty := 0;
                StyleMasterPORec.Reset();
                StyleMasterPORec.SetRange("Lot No.", "Lot No.");
                StyleMasterPORec.SetRange("PO No.", "PO No");
                StyleMasterPORec.SetRange("Style No.", "Style No.");

                if StyleMasterPORec.FindSet() then
                    orderQty := StyleMasterPORec.Qty;


                comRec.Get;
                comRec.CalcFields(Picture);

                LocationRec.Get(Factory);

            end;

            trigger OnPreDataItem()
            begin
                SetRange("Prod Date", StDate, EndDate);
                SetRange("Factory Code", Factory);
                if LineName <> '' then
                    SetRange("Resource Name", LineName);
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
                    field(StDate; StDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }

                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }

                    field(Factory; Factory)
                    {
                        ApplicationArea = All;
                        Caption = 'Factory';
                        TableRelation = Location.Code where("Sewing Unit" = filter(true));
                    }

                    field(LineName; LineName)
                    {
                        ApplicationArea = All;
                        Caption = 'Line';
                        //TableRelation = "Work Center".Name where("Factory No." = filter(Factory));

                        trigger OnLookup(var texts: text): Boolean
                        var
                            WorkCentrRec: Record "Work Center";
                        begin
                            WorkCentrRec.Reset();
                            WorkCentrRec.SetFilter(WorkCentrRec."Planning Line", '=%1', true);
                            WorkCentrRec.SetRange("Factory No.", Factory);
                            WorkCentrRec.FindSet();

                            if Page.RunModal(51159, WorkCentrRec) = Action::LookupOK then begin
                                LineNo := WorkCentrRec."No.";
                                LineName := WorkCentrRec.Name;
                            end;
                        end;
                    }
                }
            }
        }
    }

    var

        StyleMasterPORec: Record "Style Master PO";
        StyleRec: Record "Style Master";
        Buyer: Text[50];
        orderQty: BigInteger;
        StDate: Date;
        EndDate: Date;
        comRec: Record "Company Information";
        Factory: Code[10];
        LineName: Text[100];
        LineNo: code[20];
        LocationRec: Record Location;
        WorkCenterRec: Record "Work Center";
}