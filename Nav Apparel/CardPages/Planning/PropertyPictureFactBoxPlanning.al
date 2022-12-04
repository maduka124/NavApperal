page 50344 "Property Picture FactBox Plan"
{
    PageType = Cardpart;
    SourceTable = "NavApp Planning Lines";
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
    begin
        rec.SetFilter("Line No.", LineNo);
    end;


    procedure PassParameters(LineNoPara: Text);

    begin
        LineNo := LineNoPara;
    end;

    var
        LineNo: Text;
}