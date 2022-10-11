pageextension 50806 "Output Jrnl List Ext" extends "Output Journal"
{
    actions
    {
        modify("Explode &Routing")
        {
            trigger OnAfterAction()
            var
                ItemJrnlLineRec: Record "Item Journal Line";
                RouterLineRec: Record "Routing Line";
            begin
                ItemJrnlLineRec.Reset();
                ItemJrnlLineRec.SetRange("Journal Template Name", 'OUTPUT');
                ItemJrnlLineRec.SetRange("Journal Batch Name", 'DEFAULT');

                if ItemJrnlLineRec.FindSet() then
                    repeat
                        RouterLineRec.Reset();
                        RouterLineRec.SetRange("Routing No.", ItemJrnlLineRec."Routing No.");
                        RouterLineRec.SetRange("No.", ItemJrnlLineRec."No.");

                        if RouterLineRec.FindSet() then begin
                            if RouterLineRec."Run Time" > 0 then begin
                                ItemJrnlLineRec."Run Time" := RouterLineRec."Run Time";
                                ItemJrnlLineRec.Modify();
                            end
                            else
                                ItemJrnlLineRec.Delete();
                        end
                        else
                            Error('Cannot find Router Line details for the Router %1.', ItemJrnlLineRec.Description);

                    until ItemJrnlLineRec.Next() = 0;
            end;
        }
    }
}