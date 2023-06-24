page 50344 "Property Picture FactBox Plan"
{
    PageType = Cardpart;
    SourceTable = "Style Master";
    Caption = 'Style Picture Front/Back';

    layout
    {
        area(Content)
        {
            grid("")
            {
                GridLayout = Rows;
                group(" ")
                {
                    field(Front; rec.Front)
                    {
                        ApplicationArea = All;
                        Caption = 'Front';
                    }
                    field(Back; rec.Back)
                    {
                        ApplicationArea = All;
                        Caption = 'Back';
                    }
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        PlanLineRec: Record "NavApp Planning Lines";
    begin
        if LineNo <> 0 then begin
            PlanLineRec.Reset();
            PlanLineRec.SetRange("Line No.", LineNo);
            PlanLineRec.FindSet();

            rec.SetRange("No.", PlanLineRec."Style No.");
        end;
    end;


    procedure PassParameters(LineNoPara: BigInteger);

    begin
        LineNo := LineNoPara;
    end;

    var
        LineNo: BigInteger;


    // trigger OnOpenPage()
    // var
    // begin
    //     rec.SetFilter("Line No.", LineNo);
    // end;


    // procedure PassParameters(LineNoPara: Text);

    // begin
    //     LineNo := LineNoPara;
    // end;

    // var
    //     LineNo: Text;
}