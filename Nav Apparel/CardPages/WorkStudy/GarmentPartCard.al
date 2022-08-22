page 50444 "Garment Part Card"
{
    PageType = Card;
    SourceTable = GarmentPart;
    Caption = 'Garment Part';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Part No';
                }

                field(Description; Description)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Item Type Name"; "Item Type Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Item Type';

                    trigger OnValidate()
                    var
                        ItemRec: Record "Item Type";
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange("Item Type Name", "Item Type Name");
                        if ItemRec.FindSet() then
                            "Item Type No." := ItemRec."No.";
                    end;

                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Department';

                    trigger OnValidate()
                    var
                        DepartmentRec: Record "Department";
                    begin
                        DepartmentRec.Reset();
                        DepartmentRec.SetRange("Department Name", "Department Name");
                        if DepartmentRec.FindSet() then
                            "Department No" := DepartmentRec."No.";
                    end;
                }
            }
        }
    }
}