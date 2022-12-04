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
                field(FabricCode; Rec.FabricCode)
                {
                    ApplicationArea = all;
                    Caption = 'Fabric Code';
                }

                field(Composition; Rec.Composition)
                {
                    ApplicationArea = All;
                }

                field(Construction; Rec.Construction)
                {
                    ApplicationArea = All;
                }

                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                }
            }
        }
    }
}