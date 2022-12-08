page 50993 "Dependency Style Header Card"
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
                field("Style Name."; rec."Style Name.")
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
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin

                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;


                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", rec."Style Name.");

                        if StyleMasterRec.FindSet() then begin
                            rec."No." := StyleMasterRec."No.";

                            rec."Store No." := StyleMasterRec."Store No.";
                            rec."Brand No." := StyleMasterRec."Brand No.";
                            rec."Buyer No." := StyleMasterRec."Buyer No.";
                            rec."Season No." := StyleMasterRec."Season No.";
                            rec."Department No." := StyleMasterRec."Department No.";
                            rec."Store Name" := StyleMasterRec."Store Name";
                            rec."Brand Name" := StyleMasterRec."Brand Name";
                            rec."Buyer Name" := StyleMasterRec."Buyer Name";
                            rec."Season Name" := StyleMasterRec."Season Name";
                            rec."Department Name" := StyleMasterRec."Department Name";

                            //Get min Xfactory date
                            StyleMasterPORec.Reset();
                            StyleMasterPORec.SetRange("Style No.", StyleMasterRec."No.");
                            StyleMasterPORec.SetCurrentKey("Ship Date");
                            StyleMasterPORec.Ascending(true);

                            if StyleMasterPORec.FindSet() then
                                rec."Min X-Fac Date" := StyleMasterPORec."Ship Date";

                            //Get total PO qty
                            StyleMasterPORec.Reset();
                            StyleMasterPORec.SetRange("Style No.", StyleMasterRec."No.");

                            if StyleMasterPORec.FindSet() then begin
                                repeat
                                    rec.Quantity += StyleMasterPORec.Qty;
                                until StyleMasterPORec.Next() = 0;
                            end;


                            //Get Max line no
                            MaxLineNo := 0;
                            DependencyStyleLineRec.Reset();
                            DependencyStyleLineRec.SetRange("Buyer No.", rec."Buyer No.");

                            if DependencyStyleLineRec.FindLast() then
                                MaxLineNo := DependencyStyleLineRec."Line No.";


                            //Fill Parameter Lines
                            DependencyStyleLineRec.Reset();
                            DependencyStyleLineRec.SetRange("Style No.", StyleMasterRec."No.");

                            if not DependencyStyleLineRec.FindSet() then begin

                                DependencyBuyerParaRec.Reset();
                                DependencyBuyerParaRec.SetRange("Buyer No.", rec."Buyer No.");

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
                                        DependencyStyleLineRec.Qty := rec.Quantity;
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
                                        DependencyStyleLineRec.BPCD := rec.BPCD;
                                        DependencyStyleLineRec."Main Dependency No." := DependencyBuyerParaRec."Main Dependency No.";
                                        DependencyStyleLineRec.Insert();
                                    until DependencyBuyerParaRec.Next() = 0;
                                end;

                            end;
                        end;

                    end;
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Store';
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Brand';
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Season';
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Department';
                }

                field("Min X-Fac Date"; rec."Min X-Fac Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(BPCD; rec.BPCD)
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    var
                        DependencyStyleLineRec: Record "Dependency Style Line";
                    begin
                        if rec."Min X-Fac Date" < rec.BPCD then
                            Error('Possible cutting date cannot greater than Min X-Fac Date.')
                        else begin

                            DependencyStyleLineRec.Reset();
                            DependencyStyleLineRec.SetRange("Style No.", rec."No.");

                            if DependencyStyleLineRec.FindSet() then begin

                                repeat
                                    if DependencyStyleLineRec."Gap Days" < 0 then
                                        DependencyStyleLineRec."Plan Date" := rec.BPCD + DependencyStyleLineRec."Gap Days"
                                    else
                                        DependencyStyleLineRec."Plan Date" := rec.BPCD + DependencyStyleLineRec."Gap Days";

                                    DependencyStyleLineRec.BPCD := rec.BPCD;

                                    DependencyStyleLineRec.Modify();

                                until DependencyStyleLineRec.Next() = 0;
                            end;
                        end;

                    end;
                }

                field(Quantity; rec.Quantity)
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
        DepeStyleHeaderRec.SetRange("No.", rec."No.");
        DepeStyleHeaderRec.DeleteAll();

        DependencyStyleLineRec.Reset();
        DependencyStyleLineRec.SetRange("Style No.", rec."No.");
        DependencyStyleLineRec.DeleteAll();

    end;

}