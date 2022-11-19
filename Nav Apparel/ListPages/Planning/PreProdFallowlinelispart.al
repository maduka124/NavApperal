page 50834 PreProductionFallowLine
{
    PageType = Listpart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = PreProductionFollowUpline;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Buyer; Buyer)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Style; Style)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Order Qty"; "Order Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Ship Date"; "Ship Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("END Date"; "End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Production File Received Date"; "Production File Received Date")
                {
                    ApplicationArea = All;
                }

                field("PP Sample Recevied Date"; "PP Sample Recevied Date")
                {
                    ApplicationArea = All;
                }

                field("Patten Received Date"; "Patten Received Date")
                {
                    ApplicationArea = All;
                }

                field("Fabric Received Date"; "Fabric Received Date")
                {
                    ApplicationArea = All;
                }

                field("Shrinkage Report Received Date"; "Shrinkage Report Received Date")
                {
                    ApplicationArea = All;
                }

                field("Fabric Relax Date"; "Fabric Relax Date")
                {
                    ApplicationArea = All;
                }

                field("Size set Marker Date"; "Size Set Marker Date")
                {
                    ApplicationArea = All;
                }

                field("Size Set Cutting Date"; "Size Set Cutting Date")
                {
                    ApplicationArea = All;
                }

                field("Size Set Sewing Date"; "size Set Sewing Date")
                {
                    ApplicationArea = All;
                }

                field("Size Set Wash Send Date"; "Size Set Wash Send Date")
                {
                    ApplicationArea = All;
                }

                field("Size Set Wash Received Date"; "Size Set Wash Received Date")
                {
                    ApplicationArea = All;
                    Caption = 'Size Set Wash  Received Date';
                }

                field("Size Set QC Report"; "Size Set QC Report")
                {
                    ApplicationArea = All;
                }

                field("Pilot Cutting Date"; "Pilot Cutting Date")
                {
                    ApplicationArea = All;
                }

                field("Pilot Sewing Date"; "Pilot Sewing Date")
                {
                    ApplicationArea = All;
                }

                field("Pilot Wash Send Date"; "Pilot Wash Send Date")
                {
                    ApplicationArea = All;
                }

                field("Pilot Wash Received Date"; "Pilot Wash Received Date")
                {
                    ApplicationArea = All;
                }

                field("Pilot Report"; "Pilot Report")
                {
                    ApplicationArea = All;
                }

                field("Bulk Cutting Date"; "Bulk Cutting Date")
                {
                    ApplicationArea = All;
                }

                field("Line layout Date"; "Line layout Date")
                {
                    ApplicationArea = All;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }

                field("Create User"; "Create User")
                {
                    ApplicationArea = All;
                    Caption = 'User Id';
                }
            }
        }
    }
}