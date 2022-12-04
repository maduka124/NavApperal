page 50776 "Factory CPM Card"
{
    PageType = Card;
    SourceTable = "Factory CPM";
    Caption = 'Factory Wise CPM';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Factory Name"; rec."Factory Name")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                    Caption = 'Factory';

                    trigger OnValidate()
                    var
                        Locationrec: Record Location;
                        FacCPMRec: Record "Factory CPM";
                        LineNo: Integer;
                    begin
                        Locationrec.Reset();
                        Locationrec.SetRange(Name, rec."Factory Name");
                        if Locationrec.FindSet() then
                            rec."Factory Code" := Locationrec.Code;

                        //Get Max line no
                        FacCPMRec.Reset();
                        FacCPMRec.SetRange("Factory Code", Locationrec.Code);

                        if FacCPMRec.FindLast() then
                            LineNo := FacCPMRec."Line No";

                        rec."Line No" := LineNo + 1;
                        CurrPage.Update();
                    end;
                }

                field(CPM; rec.CPM)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
        }
    }

    trigger OnClosePage()
    var
    begin
        if (rec."Factory Name" <> '') and (rec.CPM = 0) then
            Error('CPM is blank.');

        if (rec."Factory Name" = '') and (rec.CPM > 0) then
            Error('Factory is blank.');
    end;
}