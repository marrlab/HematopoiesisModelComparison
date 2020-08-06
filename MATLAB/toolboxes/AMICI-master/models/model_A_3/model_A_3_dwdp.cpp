
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

using namespace amici;

void dwdp_model_A_3(realtype *dwdp, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *w, const realtype *tcl, const realtype *stcl) {
  dwdp[0] = 3.0;
  dwdp[1] = dwdp[0];
  dwdp[2] = 3.0;
  dwdp[3] = dwdp[2];
  dwdp[4] = 3.0;
  dwdp[5] = dwdp[4];
  dwdp[6] = 3.0;
  dwdp[7] = dwdp[6];
  dwdp[8] = 3.0;
  dwdp[9] = dwdp[8];
  dwdp[10] = 3.0;
  dwdp[11] = dwdp[10];
  dwdp[12] = 3.0;
  dwdp[13] = dwdp[12];
  dwdp[14] = 3.0;
  dwdp[15] = dwdp[14];
  dwdp[16] = 3.0;
  dwdp[17] = dwdp[16];
  dwdp[18] = 3.0;
  dwdp[19] = dwdp[18];
  dwdp[20] = 3.0;
  dwdp[21] = dwdp[20];
  dwdp[22] = 3.0;
  dwdp[23] = dwdp[22];
  dwdp[24] = 3.0;
  dwdp[25] = dwdp[24];
  dwdp[26] = 3.0;
  dwdp[27] = dwdp[26];
  dwdp[28] = 3.0;
  dwdp[29] = dwdp[28];
  dwdp[30] = 3.0;
  dwdp[31] = dwdp[30];
  dwdp[32] = 3.0;
  dwdp[33] = dwdp[32];
  dwdp[34] = 3.0;
  dwdp[35] = dwdp[34];
  dwdp[36] = 3.0;
  dwdp[37] = dwdp[36];
  dwdp[38] = 3.0;
  dwdp[39] = dwdp[38];
  dwdp[40] = 3.0;
  dwdp[41] = dwdp[40];
}

