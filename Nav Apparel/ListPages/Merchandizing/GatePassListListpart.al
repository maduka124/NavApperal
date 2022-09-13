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

                    // trigger OnValidate()
                    // var
                    // begin
                    //     if ("Consignment Type" = "Consignment Type"::Other) then
                    //         Enabled := false
                    //     else
                    //         Enabled := true;

                    //     CurrPage.Update();
                    // end;
                }

                field(Description; Description)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                        FARec: Record "Fixed Asset";
                        UOMRec: Record "Unit of Measure";
                    begin

                        if ("Consignment Type" = "Consignment Type"::Inventory) then begin
                            ItemRec.Reset();
                            ItemRec.SetRange(Description, Description);
                            if ItemRec.FindSet() then begin
                                "Item No." := ItemRec."No.";
                                "UOM Code" := ItemRec."Base Unit of Measure";

                                UOMRec.Reset();
                                UOMRec.SetRange(Code, "UOM Code");
                                if UOMRec.FindSet() then
                                    UOM := UOMRec.Description;
                            end;
                        end
                        else
                            if ("Consignment Type" = "Consignment Type"::"Fixed Assets") then begin
                                FARec.Reset();
                                FARec.SetRange(Description, Description);
                                if FARec.FindSet() then
                                    "Item No." := FARec."No.";

                            end;

                        Enabled := true;
                    end;
                }

                field(UOM; UOM)
                {
                    ApplicationArea = All;
                }

                field(Qty; Qty)
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