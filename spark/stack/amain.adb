with Spark_IO;
with Stacks;

--# inherit Spark_IO, Stacks;
--# main_program
procedure AMain
--# global in out Spark_IO.Outputs; in out Stacks.State;
--# derives Spark_IO.Outputs from Spark_IO.Outputs, Stacks.State &
--#         Stacks.State from Stacks.State;
is
    -- When printing numbers via Spark_IO, what is the base of the number system
    -- used? (e.g. 16 for hex, 2 for binary, 10 for decimal)
    Number_Base: constant := 10;
    -- When printing numbers via Spark_IO, how many spaces should be reserved
    -- per number output?
    Output_Width: constant := 7;

    Pop_Container: Integer;
begin
    -- Push a couple values onto the stack.
    Stacks.Push(110);
    Spark_IO.Put_Integer(File => Spark_IO.Standard_Output,
                         Item => Stacks.Get_Size,
                         Width => Output_Width,
                         Base => Number_Base);
    Spark_IO.New_Line(File => Spark_IO.Standard_Output,
                      Spacing => 1);

    Stacks.Push(220);
    Spark_IO.Put_Integer(File => Spark_IO.Standard_Output,
                         Item => Stacks.Get_Size,
                         Width => Output_Width,
                         Base => Number_Base);
    Spark_IO.New_Line(File => Spark_IO.Standard_Output,
                      Spacing => 1);

    Stacks.Push(330);
    Spark_IO.Put_Integer(File => Spark_IO.Standard_Output,
                         Item => Stacks.Get_Size,
                         Width => Output_Width,
                         Base => Number_Base);
    Spark_IO.New_Line(File => Spark_IO.Standard_Output,
                      Spacing => 1);

    -- Pop a couple values off of the stack (more than were put on!).
    for I in Integer range 1 .. 6 loop
        Stacks.Pop(Pop_Container);
        Spark_IO.Put_Integer(File => Spark_IO.Standard_Output,
                             Item => Pop_Container,
                             Width => Output_Width,
                             Base => Number_Base);
        Spark_IO.Put_Integer(File => Spark_IO.Standard_Output,
                             Item => Stacks.Get_Size,
                             Width => Output_Width,
                             Base => Number_Base);
        Spark_IO.New_Line(File => Spark_IO.Standard_Output,
                          Spacing => 1);
    end loop;
end AMain;
