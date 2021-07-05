open! Core_kernel
open Ctypes

module Types = C.Types

module Functions = struct
  open C.Functions

  type ('a, 'b) bigarray = ('a, 'b, Bigarray.c_layout) Bigarray.Array1.t

  let ba_create k len = Bigarray.Array1.create k Bigarray.c_layout len

  let fid_design_coef ~coef ~n_coef ~spec ~rate ~freq0 ~freq1 ~adj =
    let () =
      let coef_len = Bigarray.Array1.dim coef in
      if Int.(>) coef_len n_coef then
        failwithf "Fidlib.fid_design_coef: coef-length:%d > n_coef:%d"
                    coef_len n_coef ()
    in
    let coef_ptr = to_voidp (bigarray_start array1 coef) in
    fid_design_coef coef_ptr n_coef spec rate freq0 freq1 adj

  let%test "fid_design_coef fail" =
    let ratio_to_db a = Float.log10 a *. 20. in
    let kill_gain = -23.0 in
    let bessel_start_ratio = 0.25 in
    let knob_value_to_biquad_gain_db ~value ~kill =
      if kill
      then kill_gain
      else if Float.(>) value bessel_start_ratio
      then ratio_to_db value
      else begin
        let start_db = ratio_to_db bessel_start_ratio in
        let value = 1.0 -. (value /. bessel_start_ratio) in
        (kill_gain -. start_db) *. value +. start_db
      end
    in
    let spec =
      let q_boost = 0.3 in
      let db_gain = knob_value_to_biquad_gain_db ~value:0.0 ~kill:false in
      sprintf "PkBq/%.10f/%.10f" q_boost db_gain
    in
    let coef_ba = ba_create Bigarray.Float64 5 in
    let gain =
      fid_design_coef ~coef:coef_ba ~n_coef:5 ~spec ~rate:44100.0
        ~freq0:1100.0 ~freq1:0. ~adj:0
    in
    printf "spec: %s\n" spec;
    printf "gain: %f\n" gain;
    for i=0 to pred (Bigarray.Array1.dim coef_ba); do
      let v = Bigarray.Array1.get coef_ba i in
      printf "coef[%d]: %f\n" i v
    done;
    true
end

include Functions
