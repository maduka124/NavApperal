page 71012831 "Gate Pass ListPart"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Gate Pass Line";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Consignment Type"; "Consignment Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if ("Consignment Type" = "Consignment Type"::Other) then
                            Enabled := false
                        else
                            Enabled := true;
                    end;
                }

                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                    Editable = Enabled;
                }

                field(Description; Description)
                {
                    ApplicationArea = All;
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                }

                field(UOM; UOM)
                {
                    ApplicationArea = All;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        Enabled: Boolean;
}