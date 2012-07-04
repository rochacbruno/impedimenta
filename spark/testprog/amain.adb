with The_Package;
with Spark_IO;

--# inherit The_Package, Spark_IO;
--# main_program;
procedure AMain
--# global in out Spark_IO.Outputs; out The_Package.State;
--# derives Spark_IO.Outputs from Spark_IO.Outputs &
--#         The_Package.State from ;
is
    Value : Integer;
begin
   The_Package.Initialize;
   The_Package.Change(Value);
   Spark_IO.Put_Integer(File => Spark_IO.Standard_Output,
                        Item => Value,
                        Width => 10,
                        Base => 10);
end AMain;
