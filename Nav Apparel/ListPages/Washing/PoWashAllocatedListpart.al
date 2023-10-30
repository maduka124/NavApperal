page 51429 POWashAllocated
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = WashingMaster;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                    Editable = false;
                }

                field("Buyer Name"; Rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                    Editable = false;
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    Editable = false;
                }

                field("PO No"; Rec."PO No")
                {
                    ApplicationArea = All;
                    Caption = 'PO';
                    Editable = false;
                }

                field(Lot; Rec.Lot)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                    Editable = false;
                }

                field("Washing Plant"; Rec."Washing Plant")
                {
                    ApplicationArea = All;
                }

                field("Wash Type"; Rec."Wash Type")
                {
                    ApplicationArea = All;
                }

                field(Recipe; Rec.Recipe)
                {
                    ApplicationArea = All;
                }

                field("Color Qty"; Rec."Color Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sewing Factory Name"; Rec."Sewing Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sew Factory';
                    // Editable = false;

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                    begin


                        LocationRec.Reset();
                        LocationRec.SetRange(Name, Rec."Sewing Factory Name");

                        if LocationRec.FindSet() then
                            Rec."Sewing Factory Code" := LocationRec.Code;
                    end;
                }

                field("Plan Start Date"; Rec."Plan Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Plan End Date"; Rec."Plan End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("First Received Date"; Rec."First Received Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Last Received Date"; Rec."Last Received Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Plan Date"; Rec."Plan Date")
                {
                    ApplicationArea = All;
                }

                field("Actual Date"; Rec."Actual Date")
                {
                    ApplicationArea = All;
                }

                field("Close Plan Date"; Rec."Close Plan Date")
                {
                    ApplicationArea = All;
                }

                field("Close Actual Plan Date"; Rec."Close Actual Plan Date")
                {
                    ApplicationArea = All;
                }

                field("Delivery Qty"; Rec."Delivery Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Delivery Start Date"; Rec."Delivery Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Delivery End Date"; Rec."Delivery End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }


                field("SMV WHISKERS"; Rec."SMV WHISKERS")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("SMV BRUSH"; Rec."SMV BRUSH")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("SMV BASE WASH"; Rec."SMV BASE WASH")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("SMV FINAL WASH"; Rec."SMV FINAL WASH")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("SMV ACID/ RANDOM WASH"; Rec."SMV ACID/ RANDOM WASH")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("SMV PP SPRAY"; Rec."SMV PP SPRAY")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("SMV DESTROY"; Rec."SMV DESTROY")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("SMV LASER WHISKERS"; Rec."SMV LASER WHISKERS")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("SMV LASER BRUSH"; Rec."SMV LASER BRUSH")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("SMV LASER DESTROY"; Rec."SMV LASER DESTROY")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Production WHISKERS"; Rec."Production WHISKERS")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Production BRUSH"; Rec."Production BRUSH")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Production BASE WASH"; Rec."Production BASE WASH")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Production FINAL WASH"; Rec."Production FINAL WASH")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Production ACID/ RANDOM WASH"; Rec."Production ACID/ RANDOM WASH")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Production PP SPRAY"; Rec."Production PP SPRAY")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Production DESTROY"; Rec."Production DESTROY")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Production LASER WHISKERS"; Rec."Production LASER WHISKERS")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Production LASER BRUSH"; Rec."Production LASER BRUSH")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Production LASER DESTROY"; Rec."Production LASER DESTROY")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}