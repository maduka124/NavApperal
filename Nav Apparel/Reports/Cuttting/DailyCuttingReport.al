report 50315 DailyCuttingReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Daily Cutting Production Report';
    RDLCLayout = 'Report_Layouts/Cutting/DailyCuttingReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(ProductionOutHeader; ProductionOutHeader)
        {
            DataItemTableView = where(Type = filter('Cut'));
            column(Style_Name; "Style Name")
            { }
            column(PO_No; "PO No")
            { }
            column(BuyerName; BuyerName)
            { }
            column(Output_Qty; "Output Qty")
            { }
            column(OrderQty; OrderQty)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(FactoryFilter; FactoryFilter)
            { }
            column(Stdate; Stdate)
            { }
            //  column()
            // {}
            //  column()
            // {}

            trigger OnAfterGetRecord()

            begin

                comRec.Get;
                comRec.CalcFields(Picture);

                StyleRec.Reset();
                StyleRec.SetRange("No.", "Style No.");
                if StyleRec.FindFirst() then begin
                    BuyerName := StyleRec."Buyer Name";
                    OrderQty := StyleRec."Order Qty";
                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

                if Stdate <> 0D then
                    SetRange("Prod Date", Stdate);

                if FactoryFilter <> '' then
                    SetRange("Factory Code", FactoryFilter);
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
                    Caption = 'Filter By';
                    field(FactoryFilter; FactoryFilter)
                    {
                        ApplicationArea = All;
                        // TableRelation = Location.Code;
                        Caption = 'Factory';

                        trigger OnLookup(var texts: text): Boolean
                        var
                            LocationRec: Record Location;
                            LocationRec2: Record Location;
                            UserRec: Record "User Setup";
                        begin
                            LocationRec.Reset();
                            UserRec.Reset();
                            UserRec.Get(UserId);

                            LocationRec2.Reset();
                            LocationRec.Reset();
                            LocationRec.SetRange(Code, UserRec."Factory Code");
                            if LocationRec.FindSet() then begin
                                if Page.RunModal(15, LocationRec) = Action::LookupOK then begin
                                    FactoryFilter := LocationRec.Code;
                                end;
                            end
                            else
                                if Page.RunModal(15, LocationRec2) = Action::LookupOK then begin
                                    FactoryFilter := LocationRec2.Code;
                                end;
                        end;

                    }
                    field(Stdate; Stdate)
                    {
                        ApplicationArea = All;
                        Caption = 'Production Date';
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
        FactoryFilter: Code[20];
        Stdate: Date;
        comRec: Record "Company Information";
        OrderQty: BigInteger;
        StyleRec: Record "Style Master";
        BuyerName: Text[200];

}