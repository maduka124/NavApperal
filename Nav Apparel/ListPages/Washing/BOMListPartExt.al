pageextension 50658 WashinBOMList extends "Production BOM Lines"
{
    layout
    {
        addafter("No.")
        {
            field("Item Name Washing"; rec."Item Name Washing")
            {
                ApplicationArea = All;
                Visible = ItemNoWashingVisible;
                Caption = 'Item';

                trigger OnLookup(var texts: text): Boolean
                var
                    ItemRec: Record Item;
                    MainCateRec: Record "Main Category";
                begin
                    ItemRec.Reset();
                    ItemRec.SetRange("Main Category No.", rec."Main Category Code");
                    IF ItemRec.FINDSET() THEN BEGIN
                        REPEAT
                            ItemRec.MARK(TRUE);
                        UNTIL ItemRec.NEXT = 0;
                        ItemRec.MARKEDONLY(TRUE);

                        if Page.RunModal(51161, ItemRec) = Action::LookupOK then begin
                            rec."Item No Washing" := ItemRec."No.";
                            rec.Validate("No.", ItemRec."No.");
                        end;
                    END;
                END;


                trigger OnValidate()
                var
                    ItemRec: Record Item;
                begin
                    ItemRec.Reset();
                    ItemRec.SetRange(Description, rec."Item Name Washing");
                    if ItemRec.FindSet() then begin
                        rec."Item No Washing" := ItemRec."No.";
                        rec.Validate("No.", ItemRec."No.");
                    end
                    else
                        Error('Invalid Item.');
                end;
            }
        }

        addafter(Type)
        {
            field("Main Category Name"; rec."Main Category Name")
            {
                ApplicationArea = All;

                trigger OnLookup(var texts: text): Boolean
                var
                    ProdBOMHeader: Record "Production BOM Header";
                    ProdBOMRec: Record "Production BOM Header";
                    MainCateRec: Record "Main Category";
                begin
                    ProdBOMHeader.Reset();
                    ProdBOMHeader.SetRange("No.", rec."Production BOM No.");
                    ProdBOMHeader.FINDSET();

                    MainCateRec.Reset();
                    if ProdBOMHeader."BOM Type" = ProdBOMHeader."BOM Type"::Washing then
                        MainCateRec.SetFilter("Master Category Name", '=%1', 'WASH')
                    else
                        MainCateRec.SetFilter("Master Category Name", '<>%1', 'WASH');

                    if MainCateRec.FindSet() then begin
                        REPEAT
                            MainCateRec.MARK(TRUE);
                        UNTIL MainCateRec.NEXT = 0;
                        MainCateRec.MARKEDONLY(TRUE);

                        if Page.RunModal(51401, MainCateRec) = Action::LookupOK then begin
                            rec."Main Category Code" := MainCateRec."No.";

                            ProdBOMRec.Reset();
                            ProdBOMRec.SetRange("No.", rec."Production BOM No.");
                            if ProdBOMRec.FindSet() then begin
                                if ProdBOMRec."BOM Type" = ProdBOMRec."BOM Type"::Washing then begin
                                    ItemNoOriginalVisible := false;
                                    ItemNoWashingVisible := true;
                                end
                                else begin
                                    ItemNoOriginalVisible := true;
                                    ItemNoWashingVisible := false;
                                end;
                            end
                            else begin
                                ItemNoOriginalVisible := true;
                                ItemNoWashingVisible := false;
                            end;

                            CurrPage.Update();
                        end;
                    END;
                END;


                trigger OnValidate()
                var
                    ProdBOMRec: Record "Production BOM Header";
                begin
                    ProdBOMRec.Reset();
                    ProdBOMRec.SetRange("No.", rec."Production BOM No.");
                    if ProdBOMRec.FindSet() then begin
                        if ProdBOMRec."BOM Type" = ProdBOMRec."BOM Type"::Washing then begin
                            ItemNoOriginalVisible := false;
                            ItemNoWashingVisible := true;
                        end
                        else begin
                            ItemNoOriginalVisible := true;
                            ItemNoWashingVisible := false;
                        end;
                    end
                    else begin
                        ItemNoOriginalVisible := true;
                        ItemNoWashingVisible := false;
                    end;

                    CurrPage.Update();
                end;
            }
        }

        addafter("Unit of Measure Code")
        {
            field(Step; rec.Step)
            {
                ApplicationArea = All;
            }

            field("Water(L)"; rec."Water(L)")
            {
                ApplicationArea = All;
            }

            field(Temperature; rec.Temperature)
            {
                ApplicationArea = All;
                Caption = 'Temperature (C)';
            }

            field(Time; rec.Time)
            {
                ApplicationArea = All;
                Caption = 'Time (Minutes)';
            }

            field("Weight(Kg)"; rec."Weight(Kg)")
            {
                ApplicationArea = All;
            }

            field(Remark; rec.Remark)
            {
                ApplicationArea = All;
            }
        }

        modify(Type)
        {
            ApplicationArea = all;

            trigger OnAfterValidate()
            var
                ProdBOMRec: Record "Production BOM Header";
            begin
                ProdBOMRec.Reset();
                ProdBOMRec.SetRange("No.", rec."Production BOM No.");
                if ProdBOMRec.FindSet() then begin
                    if ProdBOMRec."BOM Type" = ProdBOMRec."BOM Type"::Washing then begin
                        ItemNoOriginalVisible := false;
                        ItemNoWashingVisible := true;
                    end
                    else begin
                        ItemNoOriginalVisible := true;
                        ItemNoWashingVisible := false;
                    end;
                end
                else begin
                    ItemNoOriginalVisible := true;
                    ItemNoWashingVisible := false;
                end;

                CurrPage.Update();
            end;
        }

        modify("No.")
        {
            ApplicationArea = all;
            Visible = ItemNoOriginalVisible;

            // trigger OnLookup(var texts: text): Boolean
            // var
            //IteRec: Record Item;
            //begin
            // IteRec.Reset();
            // IteRec.SetRange("Main Category Name", 'CHEMICAL');
            // IteRec.FindSet();

            //end;

            // TableRelation = if ("Main Category Name" = filter('CHEMICAL')) Item where("Main Category Name" = filter('CHEMICAL'))
            // else
            // Item;
        }

        modify(Description)
        {
            ApplicationArea = all;
            Visible = ItemNoOriginalVisible;
        }
    }

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
    begin
        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());
        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();
        end;
    end;


    trigger OnAfterGetCurrRecord()
    var
        ProdBOMRec: Record "Production BOM Header";
    begin
        ProdBOMRec.Reset();
        ProdBOMRec.SetRange("No.", rec."Production BOM No.");
        if ProdBOMRec.FindSet() then begin
            if ProdBOMRec."BOM Type" = ProdBOMRec."BOM Type"::Washing then begin
                ItemNoOriginalVisible := false;
                ItemNoWashingVisible := true;
            end
            else begin
                ItemNoOriginalVisible := true;
                ItemNoWashingVisible := false;
            end;
        end
        else begin
            ItemNoOriginalVisible := true;
            ItemNoWashingVisible := false;
        end;
    end;


    var
        ItemNoOriginalVisible: Boolean;
        ItemNoWashingVisible: Boolean;

}