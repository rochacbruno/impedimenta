package body The_Package
--# own State is Counter;
is
    Counter : Natural;

    procedure Change(Change_Me: out Integer) is
    begin
      Change_Me := 1394;
      Counter := Counter + 1;
    end Change;

   procedure Initialize is
   begin
      	Counter := 0;
   end Initialize;
end The_Package;
