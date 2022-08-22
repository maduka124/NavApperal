page 50505 "StyleMasterContract ListPart 2"
{
    PageType = ListPart;
    SourceTable = "Contract/LCStyle";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Select; Select)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Qty"; "Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Remove)
            {
                ApplicationArea = All;
                Image = RemoveLine;

                trigger OnAction()
                var
                    "StyleMasterRec": Record "Style Master";
                    "Contract/LCStyleRec": Record "Contract/LCStyle";
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                begin

                    "Contract/LCStyleRec".Reset();
                    "Contract/LCStyleRec".SetRange("No.", "No.");
                    "Contract/LCStyleRec".SetFilter(Select, '=%1', true);

                    if "Contract/LCStyleRec".FindSet() then begin
                        repeat
                            //Update Purchase order pi no
                            StyleMasterRec.Reset();
                            StyleMasterRec.SetRange("No.", "Contract/LCStyleRec"."Style No.");
                            StyleMasterRec.FindSet();
                            StyleMasterRec.Select := false;
                            StyleMasterRec.AssignedContractNo := '';
                            StyleMasterRec.Modify();
                        until "Contract/LCStyleRec".Next() = 0;
                    end;

                    //Delete from line table
                    "Contract/LCStyleRec".Reset();
                    "Contract/LCStyleRec".SetRange("No.", "No.");
                    "Contract/LCStyleRec".SetFilter(Select, '=%1', true);
                    "Contract/LCStyleRec".DeleteAll();


                    CodeUnitNav.CalQty("No.");
                    CurrPage.Update();
                end;
            }
        }
    }


}