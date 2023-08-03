report 50632 ProcessLayoutReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Process Layout Report';
    RDLCLayout = 'Report_Layouts/Workstudy/ProcessLayoutReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Machine Layout Header"; "Maning Level")
        {
            DataItemTableView = sorting("No.");
            column(Style_No_; "Style Name")
            { }
            column(Expected_Eff; "Eff")
            { }
            column(Expected_Target; "Expected Target")
            { }
            column(Work_Center_Name; "Work Center Name")
            { }
            column(BuyerName; BuyerName)
            { }
            column(OrderQTY; OrderQTY)
            { }
            column(CompLogo; comRec.Picture)
            { }

            dataitem("Machine Layout Line1"; "Maning Levels Line")
            {
                DataItemLinkReference = "Machine Layout Header";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.");

                // column(Minutes; Minutes)
                // { }
                column(Garment_Type; RefGPartName)
                { }
                column(Machine_No_; "Machine No.")
                { }
                column(Description; Description)
                { }
                column(Machine_Name; "Machine Name")
                { }
                column(SMVMachine; "SMV Machine")
                { }
                column(SMVManual; "SMV Manual")
                { }
                column(Target; "Target Per Hour")
                { }
                // column(WP_No; "WP No")
                // { }
                column(Manual; "Act HP")
                { }
                column(Auto; "Act MC")
                { }
                column(Comments; Comments)
                { }

                // trigger OnAfterGetRecord()
                // begin
                //     Manual := 0;
                //     Auto := 0;

                //     if "Machine Name" = 'HELPER' then
                //         Manual := "Act HP"
                //     else
                //         Auto := "Act MO";
                // end;
            }

            trigger OnAfterGetRecord()
            var
            begin
                StyleRec.SetRange("Style No.", StyleFilter);
                if StyleRec.FindFirst() then begin
                    BuyerName := StyleRec."Buyer Name";
                    OrderQTY := StyleRec."Order Qty";
                end;

                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Style Name", StyleFilter);
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
                    field(StyleFilter; StyleFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Style';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ManingLevelRec: Record "Maning Level";
                        begin
                            ManingLevelRec.Reset();
                            ManingLevelRec.FindSet();
                            if Page.RunModal(51379, ManingLevelRec) = Action::LookupOK then
                                StyleFilter := ManingLevelRec."Style Name";
                        end;
                    }
                }
            }
        }
    }


    var
        Manual: Decimal;
        Auto: Decimal;
        StyleRec: Record "Style Master";
        StyleFilter: Text[50];
        comRec: Record "Company Information";
        BuyerName: Text[200];
        OrderQTY: BigInteger;
}