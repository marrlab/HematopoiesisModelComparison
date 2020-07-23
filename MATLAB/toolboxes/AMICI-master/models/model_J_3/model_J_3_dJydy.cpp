
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

using namespace amici;

void dJydy_model_J_3(double *dJydy, const int iy, const realtype *p, const realtype *k, const double *y, const double *sigmay, const double *my) {
switch(iy){
    case 0:
  dJydy[0+0*1] = 1.0/(sigmay[0]*sigmay[0])*(my[0]*2.0-y[0]*2.0)*-5.0E-1;
    break;
    case 1:
  dJydy[0+1*1] = 1.0/(sigmay[1]*sigmay[1])*(my[1]*2.0-y[1]*2.0)*-5.0E-1;
    break;
    case 2:
  dJydy[0+2*1] = 1.0/(sigmay[2]*sigmay[2])*(my[2]*2.0-y[2]*2.0)*-5.0E-1;
    break;
    case 3:
  dJydy[0+3*1] = 1.0/(sigmay[3]*sigmay[3])*(my[3]*2.0-y[3]*2.0)*-5.0E-1;
    break;
    case 4:
  dJydy[0+4*1] = 1.0/(sigmay[4]*sigmay[4])*(my[4]*2.0-y[4]*2.0)*-5.0E-1;
    break;
    case 5:
  dJydy[0+5*1] = 1.0/(sigmay[5]*sigmay[5])*(my[5]*2.0-y[5]*2.0)*-5.0E-1;
    break;
    case 6:
  dJydy[0+6*1] = 1.0/(sigmay[6]*sigmay[6])*(my[6]*2.0-y[6]*2.0)*-5.0E-1;
    break;
    case 7:
  dJydy[0+7*1] = 1.0/(sigmay[7]*sigmay[7])*(my[7]*2.0-y[7]*2.0)*-5.0E-1;
    break;
    case 8:
  dJydy[0+8*1] = 1.0/(sigmay[8]*sigmay[8])*(my[8]*2.0-y[8]*2.0)*-5.0E-1;
    break;
    case 9:
  dJydy[0+9*1] = 1.0/(sigmay[9]*sigmay[9])*(my[9]*2.0-y[9]*2.0)*-5.0E-1;
    break;
    case 10:
  dJydy[0+10*1] = 1.0/(sigmay[10]*sigmay[10])*(my[10]*2.0-y[10]*2.0)*-5.0E-1;
    break;
    case 11:
  dJydy[0+11*1] = 1.0/(sigmay[11]*sigmay[11])*(my[11]*2.0-y[11]*2.0)*-5.0E-1;
    break;
    case 12:
  dJydy[0+12*1] = 1.0/(sigmay[12]*sigmay[12])*(my[12]*2.0-y[12]*2.0)*-5.0E-1;
    break;
    case 13:
  dJydy[0+13*1] = 1.0/(sigmay[13]*sigmay[13])*(my[13]*2.0-y[13]*2.0)*-5.0E-1;
    break;
    case 14:
  dJydy[0+14*1] = 1.0/(sigmay[14]*sigmay[14])*(my[14]*2.0-y[14]*2.0)*-5.0E-1;
    break;
    case 15:
  dJydy[0+15*1] = 1.0/(sigmay[15]*sigmay[15])*(my[15]*2.0-y[15]*2.0)*-5.0E-1;
    break;
    case 16:
  dJydy[0+16*1] = 1.0/(sigmay[16]*sigmay[16])*(my[16]*2.0-y[16]*2.0)*-5.0E-1;
    break;
    case 17:
  dJydy[0+17*1] = 1.0/(sigmay[17]*sigmay[17])*(my[17]*2.0-y[17]*2.0)*-5.0E-1;
    break;
    case 18:
  dJydy[0+18*1] = 1.0/(sigmay[18]*sigmay[18])*(my[18]*2.0-y[18]*2.0)*-5.0E-1;
    break;
    case 19:
  dJydy[0+19*1] = 1.0/(sigmay[19]*sigmay[19])*(my[19]*2.0-y[19]*2.0)*-5.0E-1;
    break;
    case 20:
  dJydy[0+20*1] = 1.0/(sigmay[20]*sigmay[20])*(my[20]*2.0-y[20]*2.0)*-5.0E-1;
    break;
    case 21:
  dJydy[0+21*1] = 1.0/(sigmay[21]*sigmay[21])*(my[21]*2.0-y[21]*2.0)*-5.0E-1;
    break;
    case 22:
  dJydy[0+22*1] = 1.0/(sigmay[22]*sigmay[22])*(my[22]*2.0-y[22]*2.0)*-5.0E-1;
    break;
    case 23:
  dJydy[0+23*1] = 1.0/(sigmay[23]*sigmay[23])*(my[23]*2.0-y[23]*2.0)*-5.0E-1;
    break;
    case 24:
  dJydy[0+24*1] = 1.0/(sigmay[24]*sigmay[24])*(my[24]*2.0-y[24]*2.0)*-5.0E-1;
    break;
    case 25:
  dJydy[0+25*1] = 1.0/(sigmay[25]*sigmay[25])*(my[25]*2.0-y[25]*2.0)*-5.0E-1;
    break;
    case 26:
  dJydy[0+26*1] = 1.0/(sigmay[26]*sigmay[26])*(my[26]*2.0-y[26]*2.0)*-5.0E-1;
    break;
    case 27:
  dJydy[0+27*1] = 1.0/(sigmay[27]*sigmay[27])*(my[27]*2.0-y[27]*2.0)*-5.0E-1;
    break;
    case 28:
  dJydy[0+28*1] = 1.0/(sigmay[28]*sigmay[28])*(my[28]*2.0-y[28]*2.0)*-5.0E-1;
    break;
    case 29:
  dJydy[0+29*1] = 1.0/(sigmay[29]*sigmay[29])*(my[29]*2.0-y[29]*2.0)*-5.0E-1;
    break;
    case 30:
  dJydy[0+30*1] = 1.0/(sigmay[30]*sigmay[30])*(my[30]*2.0-y[30]*2.0)*-5.0E-1;
    break;
    case 31:
  dJydy[0+31*1] = 1.0/(sigmay[31]*sigmay[31])*(my[31]*2.0-y[31]*2.0)*-5.0E-1;
    break;
    case 32:
  dJydy[0+32*1] = 1.0/(sigmay[32]*sigmay[32])*(my[32]*2.0-y[32]*2.0)*-5.0E-1;
    break;
    case 33:
  dJydy[0+33*1] = 1.0/(sigmay[33]*sigmay[33])*(my[33]*2.0-y[33]*2.0)*-5.0E-1;
    break;
    case 34:
  dJydy[0+34*1] = 1.0/(sigmay[34]*sigmay[34])*(my[34]*2.0-y[34]*2.0)*-5.0E-1;
    break;
    case 35:
  dJydy[0+35*1] = 1.0/(sigmay[35]*sigmay[35])*(my[35]*2.0-y[35]*2.0)*-5.0E-1;
    break;
    case 36:
  dJydy[0+36*1] = 1.0/(sigmay[36]*sigmay[36])*(my[36]*2.0-y[36]*2.0)*-5.0E-1;
    break;
    case 37:
  dJydy[0+37*1] = 1.0/(sigmay[37]*sigmay[37])*(my[37]*2.0-y[37]*2.0)*-5.0E-1;
    break;
    case 38:
  dJydy[0+38*1] = 1.0/(sigmay[38]*sigmay[38])*(my[38]*2.0-y[38]*2.0)*-5.0E-1;
    break;
    case 39:
  dJydy[0+39*1] = 1.0/(sigmay[39]*sigmay[39])*(my[39]*2.0-y[39]*2.0)*-5.0E-1;
    break;
    case 40:
  dJydy[0+40*1] = 1.0/(sigmay[40]*sigmay[40])*(my[40]*2.0-y[40]*2.0)*-5.0E-1;
    break;
    case 41:
  dJydy[0+41*1] = 1.0/(sigmay[41]*sigmay[41])*(my[41]*2.0-y[41]*2.0)*-5.0E-1;
    break;
    case 42:
  dJydy[0+42*1] = 1.0/(sigmay[42]*sigmay[42])*(my[42]*2.0-y[42]*2.0)*-5.0E-1;
    break;
    case 43:
  dJydy[0+43*1] = 1.0/(sigmay[43]*sigmay[43])*(my[43]*2.0-y[43]*2.0)*-5.0E-1;
    break;
    case 44:
  dJydy[0+44*1] = 1.0/(sigmay[44]*sigmay[44])*(my[44]*2.0-y[44]*2.0)*-5.0E-1;
    break;
    case 45:
  dJydy[0+45*1] = 1.0/(sigmay[45]*sigmay[45])*(my[45]*2.0-y[45]*2.0)*-5.0E-1;
    break;
    case 46:
  dJydy[0+46*1] = 1.0/(sigmay[46]*sigmay[46])*(my[46]*2.0-y[46]*2.0)*-5.0E-1;
    break;
    case 47:
  dJydy[0+47*1] = 1.0/(sigmay[47]*sigmay[47])*(my[47]*2.0-y[47]*2.0)*-5.0E-1;
    break;
    case 48:
  dJydy[0+48*1] = 1.0/(sigmay[48]*sigmay[48])*(my[48]*2.0-y[48]*2.0)*-5.0E-1;
    break;
}
}

