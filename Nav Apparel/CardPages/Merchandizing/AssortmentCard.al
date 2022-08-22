page 71012669 "Assortment Card"
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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Style No."; "Style No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field("Store Name"; "Store Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Store';
                }

                field("Season Name"; "Season Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Season';
                }

                field("Brand Name"; "Brand Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Brand';
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Department';
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Garment Type Name"; "Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                }

                field("Order Qty"; "Order Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Order Qty (Style)';
                }

                field("Lot No."; "Lot No.")
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
                        StylePORec.SetRange("Style No.", "No.");
                        StylePORec.SetRange("Lot No.", "Lot No.");
                        if StylePORec.FindSet() then
                            "PO No" := StylePORec."PO No.";

                        CurrPage.Update(true);
                    end;
                }

                field("PO No"; "PO No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Pack No"; "Pack No")
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

            group("Size Color Wise Price")
            {
                part("AssorColorSizeRatiPricListPart"; AssorColorSizeRatiPricListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No.");
                    //SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No."), "Pack No" = field("Pack No");
                }
            }
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

}