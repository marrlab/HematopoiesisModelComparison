
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

using namespace amici;

void dxdotdp_model_A_1(realtype *dxdotdp, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const int ip, const realtype *w, const realtype *dwdp) {
switch (ip) {
  case 7: {
  dxdotdp[0] = -x[0]*dwdp[0];
  dxdotdp[1] = -x[1]*dwdp[0];
  dxdotdp[2] = -x[2]*dwdp[0];
  dxdotdp[3] = -x[3]*dwdp[0];
  dxdotdp[4] = -x[4]*dwdp[0];
  dxdotdp[5] = -x[5]*dwdp[0];
  dxdotdp[6] = -x[6]*dwdp[0];
  dxdotdp[7] = x[0];
  dxdotdp[8] = x[1];
  dxdotdp[9] = x[2];
  dxdotdp[10] = x[3];
  dxdotdp[11] = x[4];
  dxdotdp[12] = x[5];
  dxdotdp[13] = x[6];

  } break;

  case 8: {
  dxdotdp[0] = -x[0]*dwdp[1];
  dxdotdp[1] = x[0]*2.0-x[1]*dwdp[1];
  dxdotdp[2] = x[1]*2.0-x[2]*dwdp[1];
  dxdotdp[3] = x[2]*2.0-x[3]*dwdp[1];
  dxdotdp[4] = x[3]*2.0-x[4]*dwdp[1];
  dxdotdp[5] = x[4]*2.0-x[5]*dwdp[1];
  dxdotdp[6] = x[5]*2.0+x[6]*2.0-x[6]*dwdp[1];

  } break;

  case 9: {
  dxdotdp[0] = -x[0]*dwdp[2];
  dxdotdp[1] = -x[1]*dwdp[2];
  dxdotdp[2] = -x[2]*dwdp[2];
  dxdotdp[3] = -x[3]*dwdp[2];
  dxdotdp[4] = -x[4]*dwdp[2];
  dxdotdp[5] = -x[5]*dwdp[2];
  dxdotdp[6] = -x[6]*dwdp[2];

  } break;

  case 10: {
  dxdotdp[7] = -x[7]*dwdp[3];
  dxdotdp[8] = -x[8]*dwdp[3];
  dxdotdp[9] = -x[9]*dwdp[3];
  dxdotdp[10] = -x[10]*dwdp[3];
  dxdotdp[11] = -x[11]*dwdp[3];
  dxdotdp[12] = -x[12]*dwdp[3];
  dxdotdp[13] = -x[13]*dwdp[3];
  dxdotdp[14] = x[7];
  dxdotdp[15] = x[8];
  dxdotdp[16] = x[9];
  dxdotdp[17] = x[10];
  dxdotdp[18] = x[11];
  dxdotdp[19] = x[12];
  dxdotdp[20] = x[13];

  } break;

  case 11: {
  dxdotdp[7] = -x[7]*dwdp[4];
  dxdotdp[8] = -x[8]*dwdp[4];
  dxdotdp[9] = -x[9]*dwdp[4];
  dxdotdp[10] = -x[10]*dwdp[4];
  dxdotdp[11] = -x[11]*dwdp[4];
  dxdotdp[12] = -x[12]*dwdp[4];
  dxdotdp[13] = -x[13]*dwdp[4];
  dxdotdp[21] = x[7];
  dxdotdp[22] = x[8];
  dxdotdp[23] = x[9];
  dxdotdp[24] = x[10];
  dxdotdp[25] = x[11];
  dxdotdp[26] = x[12];
  dxdotdp[27] = x[13];

  } break;

  case 12: {
  dxdotdp[7] = -x[7]*dwdp[5];
  dxdotdp[8] = x[7]*2.0-x[8]*dwdp[5];
  dxdotdp[9] = x[8]*2.0-x[9]*dwdp[5];
  dxdotdp[10] = x[9]*2.0-x[10]*dwdp[5];
  dxdotdp[11] = x[10]*2.0-x[11]*dwdp[5];
  dxdotdp[12] = x[11]*2.0-x[12]*dwdp[5];
  dxdotdp[13] = x[12]*2.0+x[13]*2.0-x[13]*dwdp[5];

  } break;

  case 13: {
  dxdotdp[7] = -x[7]*dwdp[6];
  dxdotdp[8] = -x[8]*dwdp[6];
  dxdotdp[9] = -x[9]*dwdp[6];
  dxdotdp[10] = -x[10]*dwdp[6];
  dxdotdp[11] = -x[11]*dwdp[6];
  dxdotdp[12] = -x[12]*dwdp[6];
  dxdotdp[13] = -x[13]*dwdp[6];

  } break;

  case 14: {
  dxdotdp[14] = -x[14]*dwdp[7];
  dxdotdp[15] = -x[15]*dwdp[7];
  dxdotdp[16] = -x[16]*dwdp[7];
  dxdotdp[17] = -x[17]*dwdp[7];
  dxdotdp[18] = -x[18]*dwdp[7];
  dxdotdp[19] = -x[19]*dwdp[7];
  dxdotdp[20] = -x[20]*dwdp[7];

  } break;

  case 15: {
  dxdotdp[14] = -x[14]*dwdp[8];
  dxdotdp[15] = x[14]*2.0-x[15]*dwdp[8];
  dxdotdp[16] = x[15]*2.0-x[16]*dwdp[8];
  dxdotdp[17] = x[16]*2.0-x[17]*dwdp[8];
  dxdotdp[18] = x[17]*2.0-x[18]*dwdp[8];
  dxdotdp[19] = x[18]*2.0-x[19]*dwdp[8];
  dxdotdp[20] = x[19]*2.0+x[20]*2.0-x[20]*dwdp[8];

  } break;

  case 16: {
  dxdotdp[21] = -x[21]*dwdp[9];
  dxdotdp[22] = -x[22]*dwdp[9];
  dxdotdp[23] = -x[23]*dwdp[9];
  dxdotdp[24] = -x[24]*dwdp[9];
  dxdotdp[25] = -x[25]*dwdp[9];
  dxdotdp[26] = -x[26]*dwdp[9];
  dxdotdp[27] = -x[27]*dwdp[9];
  dxdotdp[28] = x[21];
  dxdotdp[29] = x[22];
  dxdotdp[30] = x[23];
  dxdotdp[31] = x[24];
  dxdotdp[32] = x[25];
  dxdotdp[33] = x[26];
  dxdotdp[34] = x[27];

  } break;

  case 17: {
  dxdotdp[21] = -x[21]*dwdp[10];
  dxdotdp[22] = -x[22]*dwdp[10];
  dxdotdp[23] = -x[23]*dwdp[10];
  dxdotdp[24] = -x[24]*dwdp[10];
  dxdotdp[25] = -x[25]*dwdp[10];
  dxdotdp[26] = -x[26]*dwdp[10];
  dxdotdp[27] = -x[27]*dwdp[10];
  dxdotdp[35] = x[21];
  dxdotdp[36] = x[22];
  dxdotdp[37] = x[23];
  dxdotdp[38] = x[24];
  dxdotdp[39] = x[25];
  dxdotdp[40] = x[26];
  dxdotdp[41] = x[27];

  } break;

  case 18: {
  dxdotdp[21] = -x[21]*dwdp[11];
  dxdotdp[22] = x[21]*2.0-x[22]*dwdp[11];
  dxdotdp[23] = x[22]*2.0-x[23]*dwdp[11];
  dxdotdp[24] = x[23]*2.0-x[24]*dwdp[11];
  dxdotdp[25] = x[24]*2.0-x[25]*dwdp[11];
  dxdotdp[26] = x[25]*2.0-x[26]*dwdp[11];
  dxdotdp[27] = x[26]*2.0+x[27]*2.0-x[27]*dwdp[11];

  } break;

  case 19: {
  dxdotdp[21] = -x[21]*dwdp[12];
  dxdotdp[22] = -x[22]*dwdp[12];
  dxdotdp[23] = -x[23]*dwdp[12];
  dxdotdp[24] = -x[24]*dwdp[12];
  dxdotdp[25] = -x[25]*dwdp[12];
  dxdotdp[26] = -x[26]*dwdp[12];
  dxdotdp[27] = -x[27]*dwdp[12];

  } break;

  case 20: {
  dxdotdp[28] = -x[28]*dwdp[13];
  dxdotdp[29] = -x[29]*dwdp[13];
  dxdotdp[30] = -x[30]*dwdp[13];
  dxdotdp[31] = -x[31]*dwdp[13];
  dxdotdp[32] = -x[32]*dwdp[13];
  dxdotdp[33] = -x[33]*dwdp[13];
  dxdotdp[34] = -x[34]*dwdp[13];
  dxdotdp[42] = x[28];
  dxdotdp[43] = x[29];
  dxdotdp[44] = x[30];
  dxdotdp[45] = x[31];
  dxdotdp[46] = x[32];
  dxdotdp[47] = x[33];
  dxdotdp[48] = x[34];

  } break;

  case 21: {
  dxdotdp[28] = -x[28]*dwdp[14];
  dxdotdp[29] = x[28]*2.0-x[29]*dwdp[14];
  dxdotdp[30] = x[29]*2.0-x[30]*dwdp[14];
  dxdotdp[31] = x[30]*2.0-x[31]*dwdp[14];
  dxdotdp[32] = x[31]*2.0-x[32]*dwdp[14];
  dxdotdp[33] = x[32]*2.0-x[33]*dwdp[14];
  dxdotdp[34] = x[33]*2.0+x[34]*2.0-x[34]*dwdp[14];

  } break;

  case 22: {
  dxdotdp[28] = -x[28]*dwdp[15];
  dxdotdp[29] = -x[29]*dwdp[15];
  dxdotdp[30] = -x[30]*dwdp[15];
  dxdotdp[31] = -x[31]*dwdp[15];
  dxdotdp[32] = -x[32]*dwdp[15];
  dxdotdp[33] = -x[33]*dwdp[15];
  dxdotdp[34] = -x[34]*dwdp[15];

  } break;

  case 23: {
  dxdotdp[35] = -x[35]*dwdp[16];
  dxdotdp[36] = -x[36]*dwdp[16];
  dxdotdp[37] = -x[37]*dwdp[16];
  dxdotdp[38] = -x[38]*dwdp[16];
  dxdotdp[39] = -x[39]*dwdp[16];
  dxdotdp[40] = -x[40]*dwdp[16];
  dxdotdp[41] = -x[41]*dwdp[16];
  dxdotdp[42] = x[35];
  dxdotdp[43] = x[29];
  dxdotdp[44] = x[30];
  dxdotdp[45] = x[31];
  dxdotdp[46] = x[32];
  dxdotdp[47] = x[33];
  dxdotdp[48] = x[34];

  } break;

  case 24: {
  dxdotdp[35] = -x[35]*dwdp[17];
  dxdotdp[36] = x[35]*2.0-x[36]*dwdp[17];
  dxdotdp[37] = x[36]*2.0-x[37]*dwdp[17];
  dxdotdp[38] = x[37]*2.0-x[38]*dwdp[17];
  dxdotdp[39] = x[38]*2.0-x[39]*dwdp[17];
  dxdotdp[40] = x[39]*2.0-x[40]*dwdp[17];
  dxdotdp[41] = x[40]*2.0+x[41]*2.0-x[41]*dwdp[17];

  } break;

  case 25: {
  dxdotdp[35] = -x[35]*dwdp[18];
  dxdotdp[36] = -x[36]*dwdp[18];
  dxdotdp[37] = -x[37]*dwdp[18];
  dxdotdp[38] = -x[38]*dwdp[18];
  dxdotdp[39] = -x[39]*dwdp[18];
  dxdotdp[40] = -x[40]*dwdp[18];
  dxdotdp[41] = -x[41]*dwdp[18];

  } break;

  case 26: {
  dxdotdp[42] = -x[42]*dwdp[19];
  dxdotdp[43] = x[42]*2.0-x[43]*dwdp[19];
  dxdotdp[44] = x[43]*2.0-x[44]*dwdp[19];
  dxdotdp[45] = x[44]*2.0-x[45]*dwdp[19];
  dxdotdp[46] = x[45]*2.0-x[46]*dwdp[19];
  dxdotdp[47] = x[46]*2.0-x[47]*dwdp[19];
  dxdotdp[48] = x[47]*2.0+x[48]*2.0-x[48]*dwdp[19];

  } break;

  case 27: {
  dxdotdp[42] = -x[42]*dwdp[20];
  dxdotdp[43] = -x[43]*dwdp[20];
  dxdotdp[44] = -x[44]*dwdp[20];
  dxdotdp[45] = -x[45]*dwdp[20];
  dxdotdp[46] = -x[46]*dwdp[20];
  dxdotdp[47] = -x[47]*dwdp[20];
  dxdotdp[48] = -x[48]*dwdp[20];

  } break;

}
}

