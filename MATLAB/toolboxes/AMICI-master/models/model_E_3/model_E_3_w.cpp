
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

using namespace amici;

void w_model_E_3(realtype *w, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *tcl) {
  w[0] = p[7]*3.0;
  w[1] = p[8]*3.0;
  w[2] = p[9]*3.0;
  w[3] = p[10]*3.0;
  w[4] = w[0]+w[1]+w[2]+w[3];
  w[5] = p[11]*3.0;
  w[6] = p[12]*3.0;
  w[7] = p[13]*3.0;
  w[8] = p[14]*3.0;
  w[9] = p[15]*3.0;
  w[10] = w[5]+w[6]+w[7]+w[8]+w[9];
  w[11] = p[20]*3.0;
  w[12] = p[21]*3.0;
  w[13] = p[22]*3.0;
  w[14] = w[11]+w[12]+w[13];
  w[15] = p[16]*3.0;
  w[16] = p[17]*3.0;
  w[17] = p[18]*3.0;
  w[18] = p[19]*3.0;
  w[19] = w[15]+w[16]+w[17]+w[18];
  w[20] = p[26]*3.0;
  w[21] = p[27]*3.0;
  w[22] = p[28]*3.0;
  w[23] = w[20]+w[21]+w[22];
  w[24] = p[23]*3.0;
  w[25] = p[24]*3.0;
  w[26] = p[25]*3.0;
  w[27] = w[24]+w[25]+w[26];
  w[28] = p[29]*3.0;
  w[29] = p[30]*3.0;
  w[30] = w[28]+w[29];
}

