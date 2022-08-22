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
                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    Editable = false;
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Qty';
                    Editable = false;
                }

                field(SMV; SMV)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Carder; Carder)
                {
                    ApplicationArea = All;
                    Caption = 'Man/Machine Req.';

                    trigger OnValidate()
                    var

                    begin
                        Cal();
                    end;
                }

                field(Eff; Eff)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Efficiency (%)';

                    trigger OnValidate()
                    var

                    begin
                        Cal();
                    end;
                }

                field(HoursPerDay; HoursPerDay)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Hours Per Day';

                    trigger OnValidate()
                    var

                    begin
                        Cal();
                    end;
                }

                field(Target; Target)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Learning Curve No."; "Learning Curve No.")
                {
                    ApplicationArea = All;
                    Caption = 'Learning Curve';
                }

                field("TGTSEWFIN Date"; "TGTSEWFIN Date")
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
        if SMV <> 0 then begin
            Target := round(((60 / SMV) * Carder * HoursPerDay * Eff) / 100, 1);
        end
        else
            Message('SMV is zero. Cannot continue.');
    end;

}