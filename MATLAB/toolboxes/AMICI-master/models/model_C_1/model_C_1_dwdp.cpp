
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

using namespace amici;

void dwdp_model_C_1(realtype *dwdp, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *w, const realtype *tcl, const realtype *stcl) {
  dwdp[0] = 1.0;
  dwdp[1] = 1.0;
  dwdp[2] = 1.0;
  dwdp[3] = 1.0;
  dwdp[4] = 1.0;
  dwdp[5] = 1.0;
  dwdp[6] = 1.0;
  dwdp[7] = 1.0;
  dwdp[8] = 1.0;
  dwdp[9] = 1.0;
  dwdp[10] = 1.0;
  dwdp[11] = 1.0;
  dwdp[12] = 1.0;
  dwdp[13] = 1.0;
  dwdp[14] = 1.0;
  dwdp[15] = 1.0;
  dwdp[16] = 1.0;
  dwdp[17] = 1.0;
  dwdp[18] = 1.0;
  dwdp[19] = 1.0;
  dwdp[20] = 1.0;
  dwdp[21] = 1.0;
  dwdp[22] = 1.0;
}

