pageextension 50658 WashinBOMList extends "Production BOM Lines"
{

    layout
    {
        addafter(Type)
        {
            field("Main Category Code"; rec."Main Category Code")
            {
                ApplicationArea = All;
            }

            field("Main Category Name"; rec."Main Category Name")
            {
                ApplicationArea = All;
                Editable = false;
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

        modify("No.")
        {

            ApplicationArea = all;

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

            // LoginSessionsRec.Reset();
            // LoginSessionsRec.SetRange(SessionID, SessionId());
            // if LoginSessionsRec.FindSet() then
            //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end
        else begin   //logged in
            //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end;

    end;

}