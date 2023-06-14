page 50771 "Bank Ref Collection ListPart"
{
    PageType = ListPart;
    SourceTable = BankRefCollectionLine;
    DeleteAllowed = false;
    InsertAllowed = false;
    //ModifyAllowed = false;
    SourceTableView = sorting("BankRefNo.") order(ascending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("BankRefNo."; Rec."BankRefNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Reference No';
                    StyleExpr = StyleExprTxt;

                }

                field("Reference Date"; Rec."Reference Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(AirwayBillNo; Rec.AirwayBillNo)
                {
                    ApplicationArea = All;
                    Caption = 'BL/AirWay Bill No';
                    StyleExpr = StyleExprTxt;
                }

                field("Airway Bill Date"; Rec."Airway Bill Date")
                {
                    ApplicationArea = All;
                    Caption = 'BL/AirWay Bill Date';
                    StyleExpr = StyleExprTxt;
                }

                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Release Date"; Rec."Release Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Exchange Rate"; Rec."Exchange Rate")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Factory Invoice No"; Rec."Factory Invoice No")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

                }
                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = All;
                    Visible = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Invoice Amount"; Rec."Invoice Amount")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Release Amount"; Rec."Release Amount")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                        BankRefLineRec: Record BankRefCollectionLine;
                    begin
                        BankRefLineRec.Reset();
                        BankRefLineRec.SetRange("BankRefNo.", Rec."BankRefNo.");
                        BankRefLineRec.SetFilter(Type, '=%1', 'T');
                        if BankRefLineRec.FindSet() then begin
                            BankRefLineRec."Release Amount" += Rec."Release Amount";
                            BankRefLineRec.Modify();
                            CurrPage.Update();

                        end;
                    end;
                }

                field("Margin A/C Amount"; Rec."Margin A/C Amount")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;


                    trigger OnValidate()
                    var
                        BankRefLineRec: Record BankRefCollectionLine;
                    begin
                        BankRefLineRec.Reset();
                        BankRefLineRec.SetRange("BankRefNo.", Rec."BankRefNo.");
                        BankRefLineRec.SetFilter(Type, '=%1', 'T');
                        if BankRefLineRec.FindSet() then begin
                            BankRefLineRec."Margin A/C Amount" += Rec."Margin A/C Amount";
                            BankRefLineRec.Modify();
                            CurrPage.Update();

                        end;
                    end;
                }

                field("FC A/C Amount"; Rec."FC A/C Amount")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;


                    trigger OnValidate()
                    var
                        BankRefLineRec: Record BankRefCollectionLine;
                    begin
                        BankRefLineRec.Reset();
                        BankRefLineRec.SetRange("BankRefNo.", Rec."BankRefNo.");
                        BankRefLineRec.SetFilter(Type, '=%1', 'T');
                        if BankRefLineRec.FindSet() then begin
                            BankRefLineRec."FC A/C Amount" += Rec."FC A/C Amount";
                            BankRefLineRec.Modify();
                            CurrPage.Update();

                        end;
                    end;
                }

                field("Current A/C Amount"; Rec."Current A/C Amount")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;


                    trigger OnValidate()
                    var
                        BankRefLineRec: Record BankRefCollectionLine;
                    begin
                        BankRefLineRec.Reset();
                        BankRefLineRec.SetRange("BankRefNo.", Rec."BankRefNo.");
                        BankRefLineRec.SetFilter(Type, '=%1', 'T');
                        if BankRefLineRec.FindSet() then begin
                            BankRefLineRec."Current A/C Amount" += Rec."Current A/C Amount";
                            BankRefLineRec.Modify();
                            CurrPage.Update();

                        end;
                    end;
                }

                field("Bank Charges"; Rec."Bank Charges")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;


                    trigger OnValidate()
                    var
                        BankRefLineRec: Record BankRefCollectionLine;
                    begin
                        BankRefLineRec.Reset();
                        BankRefLineRec.SetRange("BankRefNo.", Rec."BankRefNo.");
                        BankRefLineRec.SetFilter(Type, '=%1', 'T');
                        if BankRefLineRec.FindSet() then begin
                            BankRefLineRec."Bank Charges" += Rec."Bank Charges";
                            BankRefLineRec.Modify();
                            CurrPage.Update();

                        end;
                    end;
                }

                field(Tax; Rec.Tax)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;


                    trigger OnValidate()
                    var
                        BankRefLineRec: Record BankRefCollectionLine;
                    begin
                        BankRefLineRec.Reset();
                        BankRefLineRec.SetRange("BankRefNo.", Rec."BankRefNo.");
                        BankRefLineRec.SetFilter(Type, '=%1', 'T');
                        if BankRefLineRec.FindSet() then begin
                            BankRefLineRec.Tax += Rec.Tax;
                            BankRefLineRec.Modify();
                            CurrPage.Update();

                        end;
                    end;
                }

                field("Currier Charges"; Rec."Currier Charges")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;


                    trigger OnValidate()
                    var
                        BankRefLineRec: Record BankRefCollectionLine;
                    begin
                        BankRefLineRec.Reset();
                        BankRefLineRec.SetRange("BankRefNo.", Rec."BankRefNo.");
                        BankRefLineRec.SetFilter(Type, '=%1', 'T');
                        if BankRefLineRec.FindSet() then begin
                            BankRefLineRec."Currier Charges" += Rec."Currier Charges";
                            BankRefLineRec.Modify();
                            CurrPage.Update();

                        end;
                    end;
                }

                field("Transferred To Cash Receipt"; rec."Transferred To Cash Receipt")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Payment Posted"; rec."Payment Posted")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorBooking2(Rec);
    end;

    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
}