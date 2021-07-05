let () =
  print_endline "#include <stdio.h>";
  print_endline "#include \"fidlib.h\"";
  Cstubs_structs.write_c Format.std_formatter
    (module Fidlib_c_type_description.Types)
;;
