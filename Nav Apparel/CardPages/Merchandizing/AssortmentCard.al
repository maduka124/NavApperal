page 50983 "Assortment Card"
{
    PageType = Card;
    SourceTable = "Style Master";
    Caption = 'Assortment Details';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Style No."; rec."Style No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Store';
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Season';
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Brand';
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Department';
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                    Editable = false;
                }

                field("Order Qty"; rec."Order Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Order Qty (Style)';
                }

                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    TableRelation = "Style Master PO"."Lot No." where("Style No." = field("No."));

                    trigger OnValidate()
                    var
                        StylePORec: Record "Style Master PO";
                    begin

                        //CurrPage.SaveRecord();
                        CurrPage.Update(true);
                        StylePORec.Reset();
                        StylePORec.SetRange("Style No.", rec."No.");
                        StylePORec.SetRange("Lot No.", rec."Lot No.");

                        if StylePORec.FindSet() then begin
                            rec."PO No" := StylePORec."PO No.";
                            POTotal := StylePORec.Qty;
                        end
                        else
                            POTotal := 0;

                        CurrPage.Update(true);
                    end;
                }

                field("PO No"; rec."PO No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(POTotal; POTotal)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'PO Total';
                }

                field("Pack No"; rec."Pack No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }

            group("GMT Color Information")
            {
                part("AssoColourSizeListPart"; "AssoColourSizeListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No."), Type = filter(1);
                }
            }

            group("Size Information")
            {
                part("AssoInSeamListPart"; AssoInSeamListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No.");
                }
            }

            group("Pack/Country Size Ratio")
            {
                part("AssoPackCountryListPart"; AssoPackCountryListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No.");
                    UpdatePropagation = Both;
                }
            }

            group("Color Size Ratio")
            {
                part("AssorColorSizeRatioListPart"; AssorColorSizeRatioListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No.");
                    //SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No."), "Pack No" = field("Pack No");
                }
            }

            group("Quantity Breakdown")
            {
                part("AssorColorSizeRatioListPart2"; AssorColorSizeRatioListPart2)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No.");
                    //SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No."), "Pack No" = field("Pack No");
                    Editable = false;
                }
            }

            // group("Size Color Wise Price")
            // {
            //     part("AssorColorSizeRatiPricListPart"; AssorColorSizeRatiPricListPart)
            //     {
            //         ApplicationArea = All;
            //         Caption = ' ';
            //         SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No.");
            //         //SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No."), "Pack No" = field("Pack No");
            //     }
            // }
        }
    }


    actions
    {
        area(Processing)
        {
            action("Adjust Sales Orders")
            {
                Caption = 'Create Sales Order';
                Image = CreateJobSalesInvoice;
                ApplicationArea = All;

                trigger OnAction();
                var
                    Ass: Record AssorColorSizeRatio;
                begin
                    // Ass.Reset();
                    // Ass.SetRange("lot No.", 'A_17093054');
                    // Ass.FindSet();
                    // Ass.DeleteAll();
                end;
            }

            // action("Remove error data")
            // {
            //     Caption = 'Remove error data';
            //     Image = RemoveLine;
            //     ApplicationArea = All;

            //     trigger OnAction();
            //     var
            //         Ass: Record AssorColorSizeRatio;
            //     begin
            //         Ass.Reset();
            //         Ass.SetRange("lot No.", 'A_17093054');
            //         Ass.FindSet();
            //         Ass.DeleteAll();
            //     end;
            // }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
    begin
        Error('Style already confirmed. Cannot delete.');
    end;


    procedure xxx()
    var
        StyleMasterRec: Record "Style Master";
    begin
        CurrPage.Update();
        CurrPage.AssorColorSizeRatioListPart.Page.Update();
    end;

    procedure Refresh()
    var
    begin
        CurrPage.Update();
    end;

    var
        POTotal: BigInteger;

}