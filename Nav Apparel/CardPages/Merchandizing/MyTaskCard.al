page 71012782 "MyTask Card"
{
    PageType = Card;
    Caption = 'My Task';
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(" ")
            {
                part(MyTask1; "My Task Pending")
                {
                    ApplicationArea = All;
                    Caption = 'Pending Tasks';
                }
            }

            group("  ")
            {
                part(MyTask2; "My Task Completed")
                {
                    ApplicationArea = All;
                    Caption = 'Completed Tasks';
                }
            }
        }
    }
}