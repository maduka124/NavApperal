page 71012685 "BOM Line Autogen ListPart"
{
    PageType = ListPart;
    SourceTable = "BOM Line AutoGen";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Include in PO"; "Include in PO")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var

                    begin
                        if ("Include in PO" = true) and ("Supplier No." = '') then begin
                            Error('Supplier is blank. Cannot select this item.');
                            exit;
                        end;
                    end;
                }

                field("Included in PO"; "Included in PO")
                {
                    ApplicationArea = All;
                    Caption = 'PO Generated';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("GMT Color Name"; "GMT Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'GMT Color';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Item Color Name"; "Item Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item Color';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }


                field("GMT Size Name"; "GMT Size Name")
                {
                    ApplicationArea = All;
                    Caption = 'GMT Size';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("GMT Qty"; "GMT Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Country Name"; "Country Name")
                {
                    ApplicationArea = All;
                    Caption = 'Country';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(PO; PO)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Article No."; "Article No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Article Name."; "Article Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Article/Construction';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Dimension No."; "Dimension No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Dimension Name."; "Dimension Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Dimension/Width';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Unit N0."; "Unit N0.")
                {
                    ApplicationArea = All;
                    Caption = 'Unit';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(Type; Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(Consumption; Consumption)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(WST; WST)
                {
                    ApplicationArea = All;
                    Caption = 'WST%';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(Rate; Rate)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(Value; Value)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Supplier No."; "Supplier No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Supplier Name."; "Supplier Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(Requirment; Requirment)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(AjstReq; AjstReq)
                {
                    ApplicationArea = All;
                    Caption = 'Adjust. Req.';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                // field("Stock Bal"; "Stock Bal")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     StyleExpr = StyleExprTxt;
                // }

                field("Placement of GMT"; "Placement of GMT")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Select All")
            {
                Image = SelectMore;
                ApplicationArea = All;

                trigger OnAction();
                var
                    BOMLineAutoGenRec: Record "BOM Line AutoGen";
                begin

                    BOMLineAutoGenRec.Reset();
                    BOMLineAutoGenRec.SetRange("No.", "No.");
                    BOMLineAutoGenRec.FindSet();

                    repeat
                        BOMLineAutoGenRec."Include in PO" := true;
                        BOMLineAutoGenRec.Modify();
                    until BOMLineAutoGenRec.Next() = 0;

                    CurrPage.Update();

                end;
            }

            action("Deselect All")
            {
                Image = SelectMore;
                ApplicationArea = All;

                trigger OnAction();
                var
                    BOMLineAutoGenRec: Record "BOM Line AutoGen";
                begin

                    BOMLineAutoGenRec.Reset();
                    BOMLineAutoGenRec.SetRange("No.", "No.");
                    BOMLineAutoGenRec.FindSet();

                    repeat
                        BOMLineAutoGenRec."Include in PO" := false;
                        BOMLineAutoGenRec.Modify();
                    until BOMLineAutoGenRec.Next() = 0;

                    CurrPage.Update();

                end;
            }
        }
    }


    trigger OnAfterGetRecord()
    var

    begin
        StyleExprTxt := ChangeColor.ChangeColorAutoGen(Rec);

        if "Included in PO" = true then begin
            Clear(SetEdit);
            SetEdit := false;
        end
        ELSE begin
            Clear(SetEdit);
            SetEdit := true;
        end;
    end;

    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
        SetEdit: Boolean;
}