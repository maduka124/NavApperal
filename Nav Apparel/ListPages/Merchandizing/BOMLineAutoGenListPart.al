page 51028 "BOM Line Autogen ListPart"
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
                field("Main Category Name"; rec."Main Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Include in PO"; rec."Include in PO")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var

                    begin
                        if (rec."Include in PO" = true) and (rec."Supplier No." = '') then begin
                            Error('Supplier is blank. Cannot select this item.');
                            exit;
                        end;
                    end;
                }

                field("Included in PO"; rec."Included in PO")
                {
                    ApplicationArea = All;
                    Caption = 'PO Generated';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("GMT Color Name"; rec."GMT Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'GMT Color';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Item Color Name"; rec."Item Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item Color';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }


                field("GMT Size Name"; rec."GMT Size Name")
                {
                    ApplicationArea = All;
                    Caption = 'GMT Size';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("GMT Qty"; rec."GMT Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Country Name"; rec."Country Name")
                {
                    ApplicationArea = All;
                    Caption = 'Country';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(PO; rec.PO)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Article No."; rec."Article No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Article Name."; rec."Article Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Article/Construction';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Dimension No."; rec."Dimension No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Dimension Name."; rec."Dimension Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Dimension/Width';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Unit N0."; rec."Unit N0.")
                {
                    ApplicationArea = All;
                    Caption = 'Unit';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(Consumption; rec.Consumption)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(WST; rec.WST)
                {
                    ApplicationArea = All;
                    Caption = 'WST%';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(Rate; rec.Rate)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(Value; rec.Value)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Supplier No."; rec."Supplier No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Supplier Name."; rec."Supplier Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(Requirment; rec.Requirment)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(AjstReq; rec.AjstReq)
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

                field("Placement of GMT"; rec."Placement of GMT")
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
                    BOMLineAutoGenRec.SetRange("No.", rec."No.");
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
                    BOMLineAutoGenRec.SetRange("No.", rec."No.");
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

        if rec."Included in PO" = true then begin
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