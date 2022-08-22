page 71012779 "Dependency Style Header Card"
{
    PageType = Card;
    SourceTable = "Dependency Style Header";
    Caption = 'T & A Style';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Style Name."; "Style Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                        StyleMasterPORec: Record "Style Master PO";
                        DependencyStyleLineRec: Record "Dependency Style Line";
                        DependencyBuyerParaRec: Record "Dependency Buyer Para";
                        MaxLineNo: BigInteger;
                    begin

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", "Style Name.");

                        if StyleMasterRec.FindSet() then begin
                            "No." := StyleMasterRec."No.";

                            "Store No." := StyleMasterRec."Store No.";
                            "Brand No." := StyleMasterRec."Brand No.";
                            "Buyer No." := StyleMasterRec."Buyer No.";
                            "Season No." := StyleMasterRec."Season No.";
                            "Department No." := StyleMasterRec."Department No.";
                            "Store Name" := StyleMasterRec."Store Name";
                            "Brand Name" := StyleMasterRec."Brand Name";
                            "Buyer Name" := StyleMasterRec."Buyer Name";
                            "Season Name" := StyleMasterRec."Season Name";
                            "Department Name" := StyleMasterRec."Department Name";

                            //Get min Xfactory date
                            StyleMasterPORec.Reset();
                            StyleMasterPORec.SetRange("Style No.", StyleMasterRec."No.");
                            StyleMasterPORec.SetCurrentKey("Ship Date");
                            StyleMasterPORec.Ascending(true);

                            if StyleMasterPORec.FindSet() then
                                "Min X-Fac Date" := StyleMasterPORec."Ship Date";

                            //Get total PO qty
                            StyleMasterPORec.Reset();
                            StyleMasterPORec.SetRange("Style No.", StyleMasterRec."No.");

                            if StyleMasterPORec.FindSet() then begin
                                repeat
                                    Quantity += StyleMasterPORec.Qty;
                                until StyleMasterPORec.Next() = 0;
                            end;


                            //Get Max line no
                            MaxLineNo := 0;
                            DependencyStyleLineRec.Reset();
                            DependencyStyleLineRec.SetRange("Buyer No.", "Buyer No.");

                            if DependencyStyleLineRec.FindLast() then
                                MaxLineNo := DependencyStyleLineRec."Line No.";


                            //Fill Parameter Lines
                            DependencyStyleLineRec.Reset();
                            DependencyStyleLineRec.SetRange("Style No.", StyleMasterRec."No.");

                            if not DependencyStyleLineRec.FindSet() then begin

                                DependencyBuyerParaRec.Reset();
                                DependencyBuyerParaRec.SetRange("Buyer No.", "Buyer No.");

                                if DependencyBuyerParaRec.FindSet() then begin
                                    repeat
                                        MaxLineNo += 1;
                                        DependencyStyleLineRec.Init();
                                        DependencyStyleLineRec."Style No." := StyleMasterRec."No.";
                                        DependencyStyleLineRec."Line No." := MaxLineNo;
                                        DependencyStyleLineRec."Buyer No." := DependencyBuyerParaRec."Buyer No.";
                                        DependencyStyleLineRec."Buyer Name" := DependencyBuyerParaRec."Buyer Name";
                                        DependencyStyleLineRec."Garment Type No" := StyleMasterRec."Garment Type No.";
                                        DependencyStyleLineRec."Garment Type Name" := StyleMasterRec."Garment Type Name";
                                        DependencyStyleLineRec.Qty := Quantity;
                                        DependencyStyleLineRec."Department No." := StyleMasterRec."Department No.";
                                        DependencyStyleLineRec.Department := StyleMasterRec."Department Name";
                                        DependencyStyleLineRec."Dependency Group No." := DependencyBuyerParaRec."Dependency Group No.";
                                        DependencyStyleLineRec."Dependency Group" := DependencyBuyerParaRec."Dependency Group";
                                        DependencyStyleLineRec."Action Type No." := DependencyBuyerParaRec."Action Type No.";
                                        DependencyStyleLineRec."Action Type" := DependencyBuyerParaRec."Action Type";
                                        DependencyStyleLineRec."Action Description" := DependencyBuyerParaRec."Action Description";
                                        DependencyStyleLineRec."Gap Days" := DependencyBuyerParaRec."Gap Days";
                                        DependencyStyleLineRec.Select := DependencyBuyerParaRec.Select;
                                        DependencyStyleLineRec."MK Critical" := DependencyBuyerParaRec."MK Critical";
                                        DependencyStyleLineRec."Action User" := DependencyBuyerParaRec."Action User";
                                        DependencyStyleLineRec."Created User" := DependencyBuyerParaRec."Created User";
                                        DependencyStyleLineRec.BPCD := BPCD;
                                        DependencyStyleLineRec."Main Dependency No." := DependencyBuyerParaRec."Main Dependency No.";
                                        DependencyStyleLineRec.Insert();
                                    until DependencyBuyerParaRec.Next() = 0;
                                end;

                            end;
                        end;

                    end;
                }

                field("Store Name"; "Store Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Store';
                }

                field("Brand Name"; "Brand Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Brand';
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Season Name"; "Season Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Season';
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Department';
                }

                field("Min X-Fac Date"; "Min X-Fac Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(BPCD; BPCD)
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    var
                        DependencyStyleLineRec: Record "Dependency Style Line";
                    begin
                        if "Min X-Fac Date" < BPCD then
                            Error('Possible cutting date cannot greater than Min X-Fac Date.')
                        else begin

                            DependencyStyleLineRec.Reset();
                            DependencyStyleLineRec.SetRange("Style No.", "No.");

                            if DependencyStyleLineRec.FindSet() then begin

                                repeat
                                    if DependencyStyleLineRec."Gap Days" < 0 then
                                        DependencyStyleLineRec."Plan Date" := BPCD + DependencyStyleLineRec."Gap Days"
                                    else
                                        DependencyStyleLineRec."Plan Date" := BPCD + DependencyStyleLineRec."Gap Days";

                                    DependencyStyleLineRec.BPCD := BPCD;

                                    DependencyStyleLineRec.Modify();

                                until DependencyStyleLineRec.Next() = 0;
                            end;
                        end;

                    end;
                }

                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group("Dependency Parameters")
            {
                part("Dependency Style Para List"; "Dependency Style Para List")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Style No." = field("No.");
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        DependencyStyleLineRec: Record "Dependency Style Line";
        DepeStyleHeaderRec: Record "Dependency Style Header";
    begin
        DepeStyleHeaderRec.Reset();
        DepeStyleHeaderRec.SetRange("No.", "No.");
        DepeStyleHeaderRec.DeleteAll();

        DependencyStyleLineRec.Reset();
        DependencyStyleLineRec.SetRange("Style No.", "No.");
        DependencyStyleLineRec.DeleteAll();

    end;

}