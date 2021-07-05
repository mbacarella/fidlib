type ('a, 'b) bigarray = ('a, 'b, Bigarray.c_layout) Bigarray.Array1.t

(* See vendor/fidlib.txt for more detailed project documentation.
   Coefficients are written to both [coef] and a gain is returned. *)
val fid_design_coef:
     coef:(float, Bigarray.float64_elt) bigarray
  -> n_coef:int
  -> spec:string
  -> rate:float
  -> freq0:float
  -> freq1:float
  -> adj:int
  -> float
