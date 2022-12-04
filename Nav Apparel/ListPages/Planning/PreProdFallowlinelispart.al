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
                field(Buyer; rec.Buyer)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Style; rec.Style)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Order Qty"; rec."Order Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Ship Date"; rec."Ship Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Start Date"; rec."Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("END Date"; rec."End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Production File Received Date"; rec."Production File Received Date")
                {
                    ApplicationArea = All;
                }

                field("PP Sample Recevied Date"; rec."PP Sample Recevied Date")
                {
                    ApplicationArea = All;
                }

                field("Patten Received Date"; rec."Patten Received Date")
                {
                    ApplicationArea = All;
                }

                field("Fabric Received Date"; rec."Fabric Received Date")
                {
                    ApplicationArea = All;
                }

                field("Shrinkage Report Received Date"; rec."Shrinkage Report Received Date")
                {
                    ApplicationArea = All;
                }

                field("Fabric Relax Date"; rec."Fabric Relax Date")
                {
                    ApplicationArea = All;
                }

                field("Size set Marker Date"; rec."Size Set Marker Date")
                {
                    ApplicationArea = All;
                }

                field("Size Set Cutting Date"; rec."Size Set Cutting Date")
                {
                    ApplicationArea = All;
                }

                field("Size Set Sewing Date"; rec."size Set Sewing Date")
                {
                    ApplicationArea = All;
                }

                field("Size Set Wash Send Date"; rec."Size Set Wash Send Date")
                {
                    ApplicationArea = All;
                }

                field("Size Set Wash Received Date"; rec."Size Set Wash Received Date")
                {
                    ApplicationArea = All;
                    Caption = 'Size Set Wash  Received Date';
                }

                field("Size Set QC Report"; rec."Size Set QC Report")
                {
                    ApplicationArea = All;
                }

                field("Pilot Cutting Date"; rec."Pilot Cutting Date")
                {
                    ApplicationArea = All;
                }

                field("Pilot Sewing Date"; rec."Pilot Sewing Date")
                {
                    ApplicationArea = All;
                }

                field("Pilot Wash Send Date"; rec."Pilot Wash Send Date")
                {
                    ApplicationArea = All;
                }

                field("Pilot Wash Received Date"; rec."Pilot Wash Received Date")
                {
                    ApplicationArea = All;
                }

                field("Pilot Report"; rec."Pilot Report")
                {
                    ApplicationArea = All;
                }

                field("Bulk Cutting Date"; rec."Bulk Cutting Date")
                {
                    ApplicationArea = All;
                }

                field("Line layout Date"; rec."Line layout Date")
                {
                    ApplicationArea = All;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }

                field("Create User"; rec."Create User")
                {
                    ApplicationArea = All;
                    Caption = 'User Id';
                }
            }
        }
    }
}