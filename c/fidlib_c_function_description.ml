open Ctypes

module Types = Fidlib_c_generated_types

module Functions (F : Ctypes.FOREIGN) = struct
  open F
  let fid_design_coef =
    foreign "fid_design_coef"
      (ptr void @-> int @-> string @-> float @-> float @-> float @-> int @->
       returning float)
end
