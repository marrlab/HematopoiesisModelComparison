
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

using namespace amici;

void w_model_A_1(realtype *w, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *tcl) {
  w[0] = p[7]+p[8]+p[9];
  w[1] = p[10]+p[11]+p[12]+p[13];
  w[2] = p[14]+p[15];
  w[3] = p[16]+p[17]+p[18]+p[19];
  w[4] = p[20]+p[21]+p[22];
  w[5] = p[23]+p[24]+p[25];
  w[6] = p[26]+p[27];
}

