
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

using namespace amici;

void sx0_model_A_3(realtype *sx0, const realtype t,const realtype *x0, const realtype *p, const realtype *k, const int ip) {
switch (ip) {
  case 0: {
  sx0[0] = exp(p[0]);

  } break;

  case 1: {
  sx0[70] = exp(p[1]);

  } break;

  case 2: {
  sx0[161] = exp(p[2]);

  } break;

  case 3: {
  sx0[210] = exp(p[3]);

  } break;

  case 4: {
  sx0[301] = exp(p[4]);

  } break;

  case 5: {
  sx0[371] = exp(p[5]);

  } break;

  case 6: {
  sx0[441] = exp(p[6]);

  } break;

}
}

