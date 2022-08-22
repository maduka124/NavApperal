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
                field(Name; Name)
                {
                    ApplicationArea = All;
                    Caption = 'Line No';
                }

                field(Carder; Carder)
                {
                    ApplicationArea = All;
                }

                field(MO; MO)
                {
                    ApplicationArea = All;
                }

                field(HP; HP)
                {
                    ApplicationArea = All;
                }

                field(PlanEff; PlanEff)
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
        SetFilter("No.", ResourceNo);
    end;

    var
        ResourceNo: Code[20];

    procedure PassParameters(ResourceNoPara: Text);
    var
    begin
        ResourceNo := ResourceNoPara;
    end;

}