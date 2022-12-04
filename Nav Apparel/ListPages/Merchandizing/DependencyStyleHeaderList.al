page 71012778 "Dependency Style"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Dependency Style Header";
    CardPageId = "Dependency Style Header Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;

                field("Style Name."; rec."Style Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }

                field("Min X-Fac Date"; rec."Min X-Fac Date")
                {
                    ApplicationArea = All;
                }

                field(BPCD; rec.BPCD)
                {
                    ApplicationArea = All;
                }
            }
        }

    }


    trigger OnDeleteRecord(): Boolean
    var
        DependencyStyleLineRec: Record "Dependency Style Line";
        DepeStyleHeaderRec: Record "Dependency Style Header";
    begin
        DepeStyleHeaderRec.Reset();
        DepeStyleHeaderRec.SetRange("No.", rec."No.");
        DepeStyleHeaderRec.DeleteAll();

        DependencyStyleLineRec.Reset();
        DependencyStyleLineRec.SetRange("Style No.", rec."No.");
        DependencyStyleLineRec.DeleteAll();

    end;
}