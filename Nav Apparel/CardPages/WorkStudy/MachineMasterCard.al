page 50453 "Machine Master Card"
{
    PageType = Card;
    SourceTable = "Machine Master";
    Caption = 'Machine Master';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Machine No."; "Machine No.")
                {
                    ApplicationArea = All;
                    Caption = 'Machine No';

                    trigger OnValidate()
                    var
                    begin
                        "Machine Description" := "Machine No.";
                        CurrPage.Update();
                    end;
                }

                field("Machine Description"; "Machine Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }

                field("Machine Category Name"; "Machine Category Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Machine Category';

                    trigger OnValidate()
                    var
                        MachineCateRec: Record "Machine Category";
                    begin
                        MachineCateRec.Reset();
                        MachineCateRec.SetRange("Machine Category", "Machine Category Name");
                        if MachineCateRec.FindSet() then
                            "Machine Category" := MachineCateRec."No.";
                    end;
                }

                field("Needle Type Name"; "Needle Type Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Needle Type';

                    trigger OnValidate()
                    var
                        NeedleTypeRec: Record NeedleType;
                    begin
                        NeedleTypeRec.Reset();
                        NeedleTypeRec.SetRange("Needle Description", "Needle Type Name");
                        if NeedleTypeRec.FindSet() then
                            "Needle Type No." := NeedleTypeRec."No.";
                    end;
                }

                field("Machine Type"; "Machine Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}