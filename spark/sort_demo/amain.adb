with Spark_IO;
with Bubblesort;

--# inherit Spark_IO, Bubblesort;
--# main_program;
procedure AMain
--# global in out Spark_IO.Outputs;
--# derives Spark_IO.Outputs from Spark_IO.Outputs;
is
    Test_Record: Bubblesort.Array_Record;
begin
    Test_Record.Sort_Limit := 5;
    Test_Record.The_Array := Bubblesort.Array_Template'(32, 9, 0, 1, 10, 9, 9, 1024, 24, 13246, -30000, -132, 2, 12, others => 0);

    Bubblesort.Sort(Test_Record);

    for I in Bubblesort.Array_Index loop
        Spark_IO.Put_Integer(File => Spark_IO.Standard_Output,
                             Item => Test_Record.The_Array(I),
                             Width => 10,
                             Base => 10);
        Spark_IO.New_Line(File => Spark_IO.Standard_Output,
                          Spacing => 1);
        exit when I = Test_Record.Sort_Limit;
    end loop;
end AMain;
