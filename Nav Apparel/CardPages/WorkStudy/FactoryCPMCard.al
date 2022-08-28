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
                field("Factory Name"; "Factory Name")
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
                        Locationrec.SetRange(Name, "Factory Name");
                        if Locationrec.FindSet() then
                            "Factory Code" := Locationrec.Code;

                        //Get Max line no
                        FacCPMRec.Reset();
                        FacCPMRec.SetRange("Factory Code", Locationrec.Code);

                        if FacCPMRec.FindLast() then
                            LineNo := FacCPMRec."Line No";

                        "Line No" := LineNo + 1;
                        CurrPage.Update();
                    end;
                }

                field(CPM; CPM)
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
        if ("Factory Name" <> '') and (CPM = 0) then
            Error('CPM is blank.');

        if ("Factory Name" = '') and (CPM > 0) then
            Error('Factory is blank.');
    end;
}