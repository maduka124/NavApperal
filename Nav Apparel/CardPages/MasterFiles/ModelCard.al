page 71012846 "Model Card"
{
    PageType = Card;
    SourceTable = Model;
    Caption = 'Model';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Model No';
                }

                field("Model Name"; rec."Model Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ModelRec: Record Model;
                    begin
                        ModelRec.Reset();
                        ModelRec.SetRange("Model Name", rec."Model Name");
                        if ModelRec.FindSet() then
                            Error('Model name already exists.');
                    end;
                }
            }
        }
    }
}