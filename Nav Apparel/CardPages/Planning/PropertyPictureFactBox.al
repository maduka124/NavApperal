page 50341 "Property Picture FactBox Q"
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
        PlanQueRec: Record "Planning Queue";
    begin
        PlanQueRec.Reset();
        PlanQueRec.SetRange("Queue No.", ID);
        if PlanQueRec.FindSet() then
            rec.SetRange("Style No.", PlanQueRec."Style No.");
    end;


    procedure PassParameters(IDPara: BigInteger);
    begin
        ID := IDPara;
    end;


    var
        ID: BigInteger;
}




// page 50341 "Property Picture FactBox"
// {
//     PageType = Cardpart;
//     SourceTable = "Planning Queue";

//     layout
//     {
//         area(Content)
//         {
//             grid("")
//             {
//                 GridLayout = Rows;
//                 group(" ")
//                 {
//                     field(Front; rec.Front)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Front';
//                     }
//                     field(Back; rec.Back)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Back';
//                     }


//                 }
//             }
//         }
//     }
// }