page 50340 "Property Card"
{
    PageType = Card;
    Caption = 'Property';
    SourceTable = "Planning Queue";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(Properties)
            {
                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    Editable = false;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Qty';
                    Editable = false;
                }

                field(SMV; rec.SMV)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Carder; rec.Carder)
                {
                    ApplicationArea = All;
                    Caption = 'Man/Machine Req.';

                    trigger OnValidate()
                    var

                    begin
                        Cal();
                    end;
                }

                field(Eff; rec.Eff)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Efficiency (%)';

                    trigger OnValidate()
                    var

                    begin
                        Cal();
                    end;
                }

                field(HoursPerDay; rec.HoursPerDay)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Working Hours Per Day';

                    trigger OnValidate()
                    var

                    begin
                        Cal();
                    end;
                }

                field(Target; rec.Target)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Learning Curve No."; rec."Learning Curve No.")
                {
                    ApplicationArea = All;
                    Caption = 'Learning Curve';
                }

                field("TGTSEWFIN Date"; rec."TGTSEWFIN Date")
                {
                    ApplicationArea = All;
                    Caption = 'Req. Saw. Finish Date';
                }
            }

            part("Property Picture FactBox"; "Property Picture FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Queue No." = FIELD("Queue No.");
                Caption = ' ';
            }

        }
    }

    procedure Cal();
    var
    begin
        if rec.SMV <> 0 then begin
            rec.Target := round(((60 / rec.SMV) * rec.Carder * rec.HoursPerDay * rec.Eff) / 100, 1);
        end
        else
            Message('SMV is zero. Cannot continue.');
    end;

}