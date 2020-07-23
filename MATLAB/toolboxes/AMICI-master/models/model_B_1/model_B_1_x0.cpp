
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

using namespace amici;

void x0_model_B_1(realtype *x0, const realtype t, const realtype *p, const realtype *k) {
  x0[0] = exp(p[0])-1.0;
  x0[7] = exp(p[1])-1.0;
  x0[14] = exp(p[2])-1.0;
  x0[21] = exp(p[3])-1.0;
  x0[28] = exp(p[4])-1.0;
  x0[35] = exp(p[5])-1.0;
  x0[42] = exp(p[6])-1.0;
}

