
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

using namespace amici;

void JDiag_model_C_1(realtype *JDiag, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const realtype *w, const realtype *dwdx) {
  JDiag[0+0*49] = -w[0];
  JDiag[1+0*49] = -w[0];
  JDiag[2+0*49] = -w[0];
  JDiag[3+0*49] = -w[0];
  JDiag[4+0*49] = -w[0];
  JDiag[5+0*49] = -w[0];
  JDiag[6+0*49] = -w[0]+p[9]*2.0;
  JDiag[7+0*49] = -w[1];
  JDiag[8+0*49] = -w[1];
  JDiag[9+0*49] = -w[1];
  JDiag[10+0*49] = -w[1];
  JDiag[11+0*49] = -w[1];
  JDiag[12+0*49] = -w[1];
  JDiag[13+0*49] = -w[1]+p[13]*2.0;
  JDiag[14+0*49] = -w[2];
  JDiag[15+0*49] = -w[2];
  JDiag[16+0*49] = -w[2];
  JDiag[17+0*49] = -w[2];
  JDiag[18+0*49] = -w[2];
  JDiag[19+0*49] = -w[2];
  JDiag[20+0*49] = -w[2]+p[21]*2.0;
  JDiag[21+0*49] = -w[3];
  JDiag[22+0*49] = -w[3];
  JDiag[23+0*49] = -w[3];
  JDiag[24+0*49] = -w[3];
  JDiag[25+0*49] = -w[3];
  JDiag[26+0*49] = -w[3];
  JDiag[27+0*49] = -w[3]+p[17]*2.0;
  JDiag[28+0*49] = -w[4];
  JDiag[29+0*49] = -w[4];
  JDiag[30+0*49] = -w[4];
  JDiag[31+0*49] = -w[4];
  JDiag[32+0*49] = -w[4];
  JDiag[33+0*49] = -w[4];
  JDiag[34+0*49] = -w[4]+p[26]*2.0;
  JDiag[35+0*49] = -w[5];
  JDiag[36+0*49] = -w[5];
  JDiag[37+0*49] = -w[5];
  JDiag[38+0*49] = -w[5];
  JDiag[39+0*49] = -w[5];
  JDiag[40+0*49] = -w[5];
  JDiag[41+0*49] = -w[5]+p[23]*2.0;
  JDiag[42+0*49] = -w[6];
  JDiag[43+0*49] = -w[6];
  JDiag[44+0*49] = -w[6];
  JDiag[45+0*49] = -w[6];
  JDiag[46+0*49] = -w[6];
  JDiag[47+0*49] = -w[6];
  JDiag[48+0*49] = -w[6]+p[28]*2.0;
}

