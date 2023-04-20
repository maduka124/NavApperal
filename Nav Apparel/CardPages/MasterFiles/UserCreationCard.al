page 50978 "Create User Card"
{
    PageType = Card;
    SourceTable = LoginDetails;
    Caption = 'User Creation';
    //AutoSplitKey = true;
    Permissions = tabledata "Sales Invoice Header" = rmID;

    layout
    {
        area(Content)
        {
            group(General)
            {
                // field("No."; rec."No.")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }

                field(contractNo; contractNo)
                {
                    ApplicationArea = All;
                }

                field("Secondary UserID"; rec."UserID Secondary")
                {
                    ApplicationArea = All;
                    Caption = 'Secondary User ID';

                    trigger OnValidate()
                    var
                        LoginDetailsRec: Record LoginDetails;
                    begin
                        LoginDetailsRec.Reset();
                        LoginDetailsRec.SetRange("UserID Secondary", rec."UserID Secondary");

                        if LoginDetailsRec.FindSet() then
                            Error('Secondary User ID already exists.');
                    end;
                }

                field("User Name"; rec."User Name")
                {
                    ApplicationArea = All;
                    Caption = 'Full Name';
                }

                field(Pw; rec.Pw)
                {
                    ApplicationArea = All;
                    Caption = 'Password';
                }

                field(Password; Password)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                    Caption = 'Re Enter Password';

                    trigger OnValidate()
                    var
                    begin
                        if rec.pw <> Password then
                            Error('Password mismatch.');
                    end;
                }

                field(Active; rec.Active)
                {
                    ApplicationArea = All;
                    Caption = 'Active Status';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("remove navapp plan/Prod")
            {
                ApplicationArea = All;
                Image = AddAction;

                trigger OnAction()
                var
                    NavApp: Record "NavApp Planning Lines";
                    NavAppprod: Record "NavApp Prod Plans Details";
                begin
                    NavApp.Reset();
                    NavApp.SetRange("Style No.", '02367');
                    if NavApp.FindSet() then
                        NavApp.Delete();

                    NavAppprod.Reset();
                    NavAppprod.SetRange("Style No.", '02367');
                    if NavAppprod.FindSet() then
                        NavAppprod.DeleteAll();

                    Message('Completed');
                end;
            }

            // action("remove contarct/style")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         ContractLCStyle: Record "Contract/LCStyle";
            //     begin
            //         ContractLCStyle.Reset();
            //         ContractLCStyle.SetRange("No.", contractNo);
            //         if ContractLCStyle.FindSet() then
            //             ContractLCStyle.DeleteAll();

            //         Message('Completed');
            //     end;
            // }


            // action("delete daily sewing")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         ProductionOutHeader: Record ProductionOutHeader;
            //     begin
            //         ProductionOutHeader.Reset();
            //         ProductionOutHeader.SetFilter(Type, '=%1', ProductionOutHeader.Type::Saw);
            //         ProductionOutHeader.SetRange("No.", 139);
            //         if ProductionOutHeader.FindSet() then
            //             ProductionOutHeader.DeleteAll();

            //         Message('Completed');
            //     end;
            // }


            // action("Update Prod Status")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         ProductionOutHeader: Record ProductionOutHeader;
            //     begin
            //         ProductionOutHeader.Reset();
            //         ProductionOutHeader.SetRange("No.", 175);
            //         if ProductionOutHeader.FindSet() then
            //             ProductionOutHeader.ModifyAll("Prod Updated", 1);

            //         Message('Completed');
            //     end;
            // }

            // actions


            // action("remove Export Reference No")
            // {
            //     ApplicationArea = All;
            //     Image = RemoveLine;


            //     trigger OnAction()
            //     var
            //         SalesInvRec: Record "Sales Invoice Header";
            //     begin
            //         SalesInvRec.Reset();
            //         SalesInvRec.FindSet();
            //         repeat
            //             SalesInvRec."Export Ref No." := '';
            //             SalesInvRec.Modify();
            //         until SalesInvRec.Next() = 0;
            //         Message('Completed');
            //     end;
            // }


        }
    }


    var
        Password: Text[50];
        contractNo: Text[50];
}