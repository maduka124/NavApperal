page 50518 "Hourly Production List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Hourly Production Master";
    CardPageId = "Hourly Production Card";
    SourceTableView = sorting("No.") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Prod Date"; "Prod Date")
                {
                    ApplicationArea = All;
                }

                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                }

                field(Type; Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        HourlyProdLinesRec: Record "Hourly Production Lines";
    begin
        HourlyProdLinesRec.SetRange("No.", "No.");
        HourlyProdLinesRec.DeleteAll();
    end;
}