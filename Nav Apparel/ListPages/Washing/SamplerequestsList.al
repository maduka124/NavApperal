page 50719 WashingSampleHistry
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Washing Sample Header";
    CardPageId = "Washing Sample Request Card";
    Caption = 'History of Sample Requests';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Garment Type Name"; "Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                }

                field("Wash Plant Name"; "Wash Plant Name")
                {
                    ApplicationArea = All;
                    Caption = 'Washing Plant';
                }

                field(Comment; Comment)
                {
                    ApplicationArea = All;
                }

                field("Req Date"; "Req Date")
                {
                    ApplicationArea = All;
                }

                field("Washing Status"; "Washing Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}