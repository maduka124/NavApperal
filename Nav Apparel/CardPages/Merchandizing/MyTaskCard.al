page 50994 "MyTask Card"
{
    PageType = Card;
    Caption = 'My Task';
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group("Pending Tasks")
            {
                part(MyTask1; "My Task Pending")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }

            group("Completed Tasks")
            {
                part(MyTask2; "My Task Completed")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }
        }
    }
}