let () =
  let concurrency = Cstubs.sequential in
  let prefix = Sys.argv.(2) in
  match Sys.argv.(1) with
  | "ml" ->
    Cstubs.write_ml ~concurrency Format.std_formatter ~prefix
      (module Fidlib_c_function_description.Functions)
  | "c" ->
    print_endline "#include <stdio.h>";
    print_endline "#include \"fidlib.h\"";
    Cstubs.write_c ~concurrency Format.std_formatter ~prefix
      (module Fidlib_c_function_description.Functions)
  | s -> failwith ("unknown functions "^s)
;;
