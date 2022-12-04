page 50331 "Resource List part"
{
    PageType = ListPart;
    SourceTable = "Work Center";
    Editable = false;
    Caption = 'Line Details';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Line No';
                }

                field(Carder; rec.Carder)
                {
                    ApplicationArea = All;
                }

                field(MO; rec.MO)
                {
                    ApplicationArea = All;
                }

                field(HP; rec.HP)
                {
                    ApplicationArea = All;
                }

                field(PlanEff; rec.PlanEff)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Efficiency (%)';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        rec.SetFilter("No.", ResourceNo);
    end;

    var
        ResourceNo: Code[20];

    procedure PassParameters(ResourceNoPara: Text);
    var
    begin
        ResourceNo := ResourceNoPara;
    end;

}