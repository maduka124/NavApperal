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
                field("Machine No."; rec."Machine No.")
                {
                    ApplicationArea = All;
                    Caption = 'Machine No';

                    trigger OnValidate()
                    var
                    begin
                        rec."Machine Description" := rec."Machine No.";
                        CurrPage.Update();
                    end;
                }

                field("Machine Description"; rec."Machine Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }

                field("Machine Category Name"; rec."Machine Category Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Machine Category';

                    trigger OnValidate()
                    var
                        MachineCateRec: Record "Machine Category";
                    begin
                        MachineCateRec.Reset();
                        MachineCateRec.SetRange("Machine Category", rec."Machine Category Name");
                        if MachineCateRec.FindSet() then
                            rec."Machine Category" := MachineCateRec."No.";
                    end;
                }

                field("Needle Type Name"; rec."Needle Type Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Needle Type';

                    trigger OnValidate()
                    var
                        NeedleTypeRec: Record NeedleType;
                    begin
                        NeedleTypeRec.Reset();
                        NeedleTypeRec.SetRange("Needle Description", rec."Needle Type Name");
                        if NeedleTypeRec.FindSet() then
                            rec."Needle Type No." := NeedleTypeRec."No.";
                    end;
                }

                field("Machine Type"; rec."Machine Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}