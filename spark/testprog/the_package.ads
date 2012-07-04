package The_Package
--# own State;
is
   procedure Change(Change_Me: out Integer);
   --# global in out State;
   --# derives Change_Me from &
   --#         State from State;

   procedure Initialize;
   --# global out State;
   --# derives State from ;
end The_Package;
