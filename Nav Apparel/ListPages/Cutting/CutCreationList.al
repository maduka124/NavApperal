page 50601 "Cut Creation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = CutCreation;
    CardPageId = "Cut Creation Card";
    SourceTableView = sorting(CutCreNo) order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(CutCreNo; Rec.CutCreNo)
                {
                    ApplicationArea = All;
                    Caption = 'Cut Creation No';
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Colour Name"; Rec."Colour Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                }

                field("Marker Name"; Rec."Marker Name")
                {
                    ApplicationArea = All;
                    Caption = 'Marker';
                }

                field("Group ID"; Rec."Group ID")
                {
                    ApplicationArea = All;
                }

                field("Component Group"; Rec."Component Group")
                {
                    ApplicationArea = All;
                }

                field("Ply Height"; Rec."Ply Height")
                {
                    ApplicationArea = All;
                    Caption = 'No of Plies';
                }
            }
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


    trigger OnDeleteRecord(): Boolean
    var
        CurCreLineRec: Record CutCreationLine;
        FabRec: Record FabricRequsition;
        TableRec: Record TableCreartionLine;
        LaySheetRec: Record LaySheetHeader;
        UserRec: Record "User Setup";
    begin

        //Done By sachith on 06/04/23
        UserRec.Reset();
        UserRec.Get(UserId);

        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.')
        end
        else
            Error('You are not authorized to delete records.');

        //Check fabric requsition
        CurCreLineRec.Reset();
        CurCreLineRec.SetRange("CutCreNo.", Rec.CutCreNo);
        CurCreLineRec.SetFilter("Cut No", '<>%1', 0);

        if CurCreLineRec.FindSet() then begin
            repeat

                //Check for cut creation
                FabRec.Reset();
                FabRec.SetRange("Marker Name", Rec."Marker Name");
                FabRec.SetRange("Style No.", Rec."Style No.");
                FabRec.SetRange("Colour No", Rec."Colour No");
                FabRec.SetRange("Group ID", Rec."Group ID");
                FabRec.SetRange("Component Group Code", Rec."Component Group");
                FabRec.SetRange("Marker Name", Rec."Marker Name");
                FabRec.SetRange("Cut No", CurCreLineRec."Cut No");

                if FabRec.FindSet() then begin
                    Message('Cannot delete. Cut No already used in the Fabric Requsition No : %1', FabRec."FabReqNo.");
                    exit(false);
                end;
            until CurCreLineRec.Next() = 0;
        end;


        //Check Table creation
        CurCreLineRec.Reset();
        CurCreLineRec.SetRange("CutCreNo.", Rec.CutCreNo);
        CurCreLineRec.SetFilter("Cut No", '<>%1', 0);

        if CurCreLineRec.FindSet() then begin
            repeat

                //Check for cut creation
                TableRec.Reset();
                TableRec.SetRange("Marker Name", Rec."Marker Name");
                TableRec.SetRange("Style No.", Rec."Style No.");
                TableRec.SetRange("Colour No", Rec."Colour No");
                TableRec.SetRange("Group ID", Rec."Group ID");
                TableRec.SetRange("Component Group", Rec."Component Group");
                TableRec.SetRange("Marker Name", Rec."Marker Name");
                TableRec.SetRange("Cut No", CurCreLineRec."Cut No");

                if TableRec.FindSet() then begin
                    Message('Cannot delete. Cut No already used in the Cutting Table Creation : %1', TableRec."TableCreNo.");
                    exit(false);
                end;
            until CurCreLineRec.Next() = 0;
        end;


        //Check LaySheet
        CurCreLineRec.Reset();
        CurCreLineRec.SetRange("CutCreNo.", Rec.CutCreNo);
        CurCreLineRec.SetFilter("Record Type", '=%1', 'R');

        if CurCreLineRec.FindSet() then begin
            repeat

                //Check for cut creation
                LaySheetRec.Reset();
                LaySheetRec.SetRange("Marker Name", Rec."Marker Name");
                LaySheetRec.SetRange("Style No.", Rec."Style No.");
                LaySheetRec.SetRange("Color No.", Rec."Colour No");
                LaySheetRec.SetRange("Group ID", Rec."Group ID");
                LaySheetRec.SetRange("Component Group Code", Rec."Component Group");
                LaySheetRec.SetRange("Cut No.", CurCreLineRec."Cut No");

                if LaySheetRec.FindSet() then begin
                    Message('Cannot delete. Cut No already used in the Laysheet No : %1', LaySheetRec."LaySheetNo.");
                    exit(false);
                end;
            until CurCreLineRec.Next() = 0;
        end;


        CurCreLineRec.Reset();
        CurCreLineRec.SetRange("CutCreNo.", Rec.CutCreNo);
        if CurCreLineRec.FindSet() then
            CurCreLineRec.DeleteAll();
    end;
}