page 50681 "FabricCodeList"
{
    PageType = List;
    SourceTable = FabricCodeMaster;
    CardPageId = FabricCodeCard;
    SourceTableView = sorting(FabricCode) order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(FabricCode; FabricCode)
                {
                    ApplicationArea = all;
                    Caption = 'Fabric Code';
                }

                field(Composition; Composition)
                {
                    ApplicationArea = All;
                }

                field(Construction; Construction)
                {
                    ApplicationArea = All;
                }

                field("Supplier Name"; "Supplier Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                }
            }
        }
    }
}