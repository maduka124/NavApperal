page 51367 FactoryAndMachineReq
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FactoryandlinemachineReqlist;
    CardPageId = FactoryAndLineMachineReqCard;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Factory Name"; Rec."Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        LocationRec: Record Location;
        UserRec: Record "User Setup";
        FacmachineRec: Record FactoryandlinemachineReqlist;
    begin

        FacmachineRec.Reset();
        if FacmachineRec.FindSet() then
            FacmachineRec.DeleteAll();

        UserRec.Reset();
        UserRec.Get(UserId);

        LocationRec.Reset();
        LocationRec.SetFilter("Sewing Unit", '=%1', true);
        LocationRec.SetCurrentKey(Code);
        LocationRec.Ascending(true);

        if LocationRec.FindSet() then begin
            repeat
                FacmachineRec.Init();
                FacmachineRec."Factory Code" := LocationRec.Code;
                FacmachineRec."Factory Name" := LocationRec.Name;
                FacmachineRec.Insert()
            until LocationRec.Next() = 0;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        FactoryAndLineMachineLineRec: Record FactoryAndLineMachineLine;
        FactoryAndLineMachine2LineRec: Record FactoryAndLineMachine2Line;
    begin

        FactoryAndLineMachineLineRec.Reset();
        FactoryAndLineMachineLineRec.SetRange(Factory, Rec."Factory Name");
        if FactoryAndLineMachineLineRec.FindSet() then
            FactoryAndLineMachineLineRec.DeleteAll();

        FactoryAndLineMachine2LineRec.Reset();
        FactoryAndLineMachine2LineRec.SetRange(Factory, Rec."Factory Name");
        if FactoryAndLineMachine2LineRec.FindSet() then
            FactoryAndLineMachine2LineRec.DeleteAll();

    end;
}