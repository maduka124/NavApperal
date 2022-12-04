page 50857 SAH_CapacityAllocationList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SAH_CapacityUtiliSAHHeader;
    CardPageId = CapacityUtilizationSAH;
    SourceTableView = sorting(Year) order(ascending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Year; rec.Year)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        SAH_FactoryCapacity: Record SAH_FactoryCapacity;
        SAH_CapacityAllocation: Record SAH_CapacityAllocation;
        SAH_MerchGRPWiseAllocation: Record SAH_MerchGRPWiseAllocation;
        SAH_MerchGRPWiseAvgSMV: Record SAH_MerchGRPWiseAvgSMV;
        SAH_MerchGRPWiseBalance: Record SAH_MerchGRPWiseBalance;
        SAH_MerchGRPWiseSAHUsed: Record SAH_MerchGRPWiseSAHUsed;
        SAH_PlanEfficiency: Record SAH_PlanEfficiency;

    begin
        SAH_FactoryCapacity.Reset();
        SAH_FactoryCapacity.SetRange(Year, rec.Year);
        if SAH_FactoryCapacity.FindSet() then
            SAH_FactoryCapacity.DeleteAll();

        SAH_CapacityAllocation.Reset();
        SAH_CapacityAllocation.SetRange(Year, rec.Year);
        if SAH_CapacityAllocation.FindSet() then
            SAH_CapacityAllocation.DeleteAll();

        SAH_MerchGRPWiseAllocation.Reset();
        SAH_MerchGRPWiseAllocation.SetRange(Year, rec.Year);
        if SAH_MerchGRPWiseAllocation.FindSet() then
            SAH_MerchGRPWiseAllocation.DeleteAll();

        SAH_MerchGRPWiseAvgSMV.Reset();
        SAH_MerchGRPWiseAvgSMV.SetRange(Year, rec.Year);
        if SAH_MerchGRPWiseAvgSMV.FindSet() then
            SAH_MerchGRPWiseAvgSMV.DeleteAll();

        SAH_MerchGRPWiseBalance.Reset();
        SAH_MerchGRPWiseBalance.SetRange(Year, rec.Year);
        if SAH_MerchGRPWiseBalance.FindSet() then
            SAH_MerchGRPWiseBalance.DeleteAll();

        SAH_MerchGRPWiseSAHUsed.Reset();
        SAH_MerchGRPWiseSAHUsed.SetRange(Year, rec.Year);
        if SAH_MerchGRPWiseSAHUsed.FindSet() then
            SAH_MerchGRPWiseSAHUsed.DeleteAll();

        SAH_PlanEfficiency.Reset();
        SAH_PlanEfficiency.SetRange(Year, rec.Year);
        if SAH_PlanEfficiency.FindSet() then
            SAH_PlanEfficiency.DeleteAll();
    end;
}