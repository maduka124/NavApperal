page 51215 ProductionFilerelease
{
    PageType = ListPart;
    SourceTable = "NavApp Planning Lines";
    Caption = 'Production Files Release';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {

                field(Factory; Rec.Factory)
                {
                    ApplicationArea = All;
                }

                field("Resource Name"; Rec."Resource Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WorkcenterRec: Record "Work Center";
                    begin

                    end;
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {
    //             ApplicationArea = All;

    //             trigger OnAction()
    //             begin

    //             end;
    //         }
    //     }
    // }

    var
        myInt: Integer;
}