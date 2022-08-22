page 71012735 "Folder Detail Card"
{
    PageType = Card;
    SourceTable = "Folder Detail";
    Caption = 'Folder Detail';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Folder Detail No';
                }

                field("Folder Name"; "Folder Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        FolderDetailRec: Record "Folder Detail";
                    begin
                        FolderDetailRec.Reset();
                        FolderDetailRec.SetRange("Folder Name", "Folder Name");
                        if FolderDetailRec.FindSet() then
                            Error('Folder Name already exists.');
                    end;
                }
            }
        }
    }
}