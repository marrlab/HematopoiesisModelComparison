
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

using namespace amici;

void w_model_G_3(realtype *w, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *tcl) {
  w[0] = p[7]*3.0;
  w[1] = p[8]*3.0;
  w[2] = p[9]*3.0;
  w[3] = p[10]*3.0;
  w[4] = w[0]+w[1]+w[2]+w[3];
  w[5] = p[14]*3.0;
  w[6] = p[15]*3.0;
  w[7] = p[16]*3.0;
  w[8] = p[17]*3.0;
  w[9] = w[5]+w[6]+w[7]+w[8];
  w[10] = p[21]*3.0;
  w[11] = p[22]*3.0;
  w[12] = w[10]+w[11];
  w[13] = p[18]*3.0;
  w[14] = p[19]*3.0;
  w[15] = p[20]*3.0;
  w[16] = w[13]+w[14]+w[15];
  w[17] = p[23]*3.0;
  w[18] = p[24]*3.0;
  w[19] = p[25]*3.0;
  w[20] = w[17]+w[18]+w[19];
  w[21] = p[11]*3.0;
  w[22] = p[12]*3.0;
  w[23] = p[13]*3.0;
  w[24] = w[21]+w[22]+w[23];
  w[25] = p[26]*3.0;
  w[26] = p[27]*3.0;
  w[27] = w[25]+w[26];
}

