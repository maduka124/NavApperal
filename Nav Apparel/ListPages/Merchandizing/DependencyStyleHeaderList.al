page 71012778 "Dependency Style"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Dependency Style Header";
    CardPageId = "Dependency Style Header Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;

                field("Style Name."; "Style Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Store Name"; "Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                }

                field("Season Name"; "Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                }

                field("Brand Name"; "Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }

                field("Min X-Fac Date"; "Min X-Fac Date")
                {
                    ApplicationArea = All;
                }

                field(BPCD; BPCD)
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
        DepeStyleHeaderRec.SetRange("No.", "No.");
        DepeStyleHeaderRec.DeleteAll();

        DependencyStyleLineRec.Reset();
        DependencyStyleLineRec.SetRange("Style No.", "No.");
        DependencyStyleLineRec.DeleteAll();

    end;
}