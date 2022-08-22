page 50440 "Sample Status List"
{
    PageType = List;
    AutoSplitKey = true;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sample Requsition Line";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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

                field("Sample Name"; "Sample Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sample';
                }

                field("Fabrication Name"; "Fabrication Name")
                {
                    ApplicationArea = All;
                    Caption = 'Fabrication';
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                }

                field(Size; Size)
                {
                    ApplicationArea = All;
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    Caption = 'Complete';
                }

                field("Complete Qty"; "Complete Qty")
                {
                    ApplicationArea = All;
                }

                field("Req Date"; "Req Date")
                {
                    ApplicationArea = All;
                }

                field(Comment; Comment)
                {
                    ApplicationArea = All;
                }

                field("Created User"; "Created User")
                {
                    ApplicationArea = All;
                }

                field("Created Date"; "Created Date")
                {
                    ApplicationArea = All;
                }

                field("Plan Start Date"; "Plan Start Date")
                {
                    ApplicationArea = All;
                }

                field("Plan End Date"; "Plan End Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}