page 51454 WashingProductionLine
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = WashinProductionLine;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Buyer Name"; Rec."Buyer Name")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                }

                field("Lot No"; Rec."Lot No")
                {
                    ApplicationArea = All;
                }

                field("PO No"; Rec."PO No")
                {
                    ApplicationArea = All;
                }

                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                }

                field("Production WHISKERS"; Rec."Production WHISKERS")
                {
                    ApplicationArea = All;
                }

                field("Production BRUSH"; Rec."Production BRUSH")
                {
                    ApplicationArea = All;
                }

                field("Production BASE WASH"; Rec."Production BASE WASH")
                {
                    ApplicationArea = All;
                }

                field("Production FINAL WASH"; Rec."Production FINAL WASH")
                {
                    ApplicationArea = All;
                }

                field("Production ACID/ RANDOM WASH"; Rec."Production ACID/ RANDOM WASH")
                {
                    ApplicationArea = All;
                }

                field("Production PP SPRAY"; Rec."Production PP SPRAY")
                {
                    ApplicationArea = All;
                }

                field("Production DESTROY"; Rec."Production DESTROY")
                {
                    ApplicationArea = All;
                }

                field("Production LASER WHISKERS"; Rec."Production LASER WHISKERS")
                {
                    ApplicationArea = All;
                }

                field("Production LASER BRUSH"; Rec."Production LASER BRUSH")
                {
                    ApplicationArea = All;
                }

                field("Production LASER DESTROY"; Rec."Production LASER DESTROY")
                {
                    ApplicationArea = All;
                }


            }
        }
    }
}