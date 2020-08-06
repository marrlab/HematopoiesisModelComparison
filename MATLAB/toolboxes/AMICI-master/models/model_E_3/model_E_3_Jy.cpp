
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

using namespace amici;

void Jy_model_E_3(double *nllh, const int iy, const realtype *p, const realtype *k, const double *y, const double *sigmay, const double *my) {
switch(iy){
    case 0:
  nllh[0] = amici::log((sigmay[0]*sigmay[0])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[0]*sigmay[0])*pow(my[0]-y[0],2.0)*5.0E-1;
    break;
    case 1:
  nllh[0] = amici::log((sigmay[1]*sigmay[1])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[1]*sigmay[1])*pow(my[1]-y[1],2.0)*5.0E-1;
    break;
    case 2:
  nllh[0] = amici::log((sigmay[2]*sigmay[2])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[2]*sigmay[2])*pow(my[2]-y[2],2.0)*5.0E-1;
    break;
    case 3:
  nllh[0] = amici::log((sigmay[3]*sigmay[3])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[3]*sigmay[3])*pow(my[3]-y[3],2.0)*5.0E-1;
    break;
    case 4:
  nllh[0] = amici::log((sigmay[4]*sigmay[4])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[4]*sigmay[4])*pow(my[4]-y[4],2.0)*5.0E-1;
    break;
    case 5:
  nllh[0] = amici::log((sigmay[5]*sigmay[5])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[5]*sigmay[5])*pow(my[5]-y[5],2.0)*5.0E-1;
    break;
    case 6:
  nllh[0] = amici::log((sigmay[6]*sigmay[6])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[6]*sigmay[6])*pow(my[6]-y[6],2.0)*5.0E-1;
    break;
    case 7:
  nllh[0] = amici::log((sigmay[7]*sigmay[7])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[7]*sigmay[7])*pow(my[7]-y[7],2.0)*5.0E-1;
    break;
    case 8:
  nllh[0] = amici::log((sigmay[8]*sigmay[8])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[8]*sigmay[8])*pow(my[8]-y[8],2.0)*5.0E-1;
    break;
    case 9:
  nllh[0] = amici::log((sigmay[9]*sigmay[9])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[9]*sigmay[9])*pow(my[9]-y[9],2.0)*5.0E-1;
    break;
    case 10:
  nllh[0] = amici::log((sigmay[10]*sigmay[10])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[10]*sigmay[10])*pow(my[10]-y[10],2.0)*5.0E-1;
    break;
    case 11:
  nllh[0] = amici::log((sigmay[11]*sigmay[11])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[11]*sigmay[11])*pow(my[11]-y[11],2.0)*5.0E-1;
    break;
    case 12:
  nllh[0] = amici::log((sigmay[12]*sigmay[12])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[12]*sigmay[12])*pow(my[12]-y[12],2.0)*5.0E-1;
    break;
    case 13:
  nllh[0] = amici::log((sigmay[13]*sigmay[13])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[13]*sigmay[13])*pow(my[13]-y[13],2.0)*5.0E-1;
    break;
    case 14:
  nllh[0] = amici::log((sigmay[14]*sigmay[14])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[14]*sigmay[14])*pow(my[14]-y[14],2.0)*5.0E-1;
    break;
    case 15:
  nllh[0] = amici::log((sigmay[15]*sigmay[15])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[15]*sigmay[15])*pow(my[15]-y[15],2.0)*5.0E-1;
    break;
    case 16:
  nllh[0] = amici::log((sigmay[16]*sigmay[16])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[16]*sigmay[16])*pow(my[16]-y[16],2.0)*5.0E-1;
    break;
    case 17:
  nllh[0] = amici::log((sigmay[17]*sigmay[17])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[17]*sigmay[17])*pow(my[17]-y[17],2.0)*5.0E-1;
    break;
    case 18:
  nllh[0] = amici::log((sigmay[18]*sigmay[18])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[18]*sigmay[18])*pow(my[18]-y[18],2.0)*5.0E-1;
    break;
    case 19:
  nllh[0] = amici::log((sigmay[19]*sigmay[19])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[19]*sigmay[19])*pow(my[19]-y[19],2.0)*5.0E-1;
    break;
    case 20:
  nllh[0] = amici::log((sigmay[20]*sigmay[20])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[20]*sigmay[20])*pow(my[20]-y[20],2.0)*5.0E-1;
    break;
    case 21:
  nllh[0] = amici::log((sigmay[21]*sigmay[21])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[21]*sigmay[21])*pow(my[21]-y[21],2.0)*5.0E-1;
    break;
    case 22:
  nllh[0] = amici::log((sigmay[22]*sigmay[22])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[22]*sigmay[22])*pow(my[22]-y[22],2.0)*5.0E-1;
    break;
    case 23:
  nllh[0] = amici::log((sigmay[23]*sigmay[23])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[23]*sigmay[23])*pow(my[23]-y[23],2.0)*5.0E-1;
    break;
    case 24:
  nllh[0] = amici::log((sigmay[24]*sigmay[24])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[24]*sigmay[24])*pow(my[24]-y[24],2.0)*5.0E-1;
    break;
    case 25:
  nllh[0] = amici::log((sigmay[25]*sigmay[25])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[25]*sigmay[25])*pow(my[25]-y[25],2.0)*5.0E-1;
    break;
    case 26:
  nllh[0] = amici::log((sigmay[26]*sigmay[26])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[26]*sigmay[26])*pow(my[26]-y[26],2.0)*5.0E-1;
    break;
    case 27:
  nllh[0] = amici::log((sigmay[27]*sigmay[27])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[27]*sigmay[27])*pow(my[27]-y[27],2.0)*5.0E-1;
    break;
    case 28:
  nllh[0] = amici::log((sigmay[28]*sigmay[28])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[28]*sigmay[28])*pow(my[28]-y[28],2.0)*5.0E-1;
    break;
    case 29:
  nllh[0] = amici::log((sigmay[29]*sigmay[29])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[29]*sigmay[29])*pow(my[29]-y[29],2.0)*5.0E-1;
    break;
    case 30:
  nllh[0] = amici::log((sigmay[30]*sigmay[30])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[30]*sigmay[30])*pow(my[30]-y[30],2.0)*5.0E-1;
    break;
    case 31:
  nllh[0] = amici::log((sigmay[31]*sigmay[31])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[31]*sigmay[31])*pow(my[31]-y[31],2.0)*5.0E-1;
    break;
    case 32:
  nllh[0] = amici::log((sigmay[32]*sigmay[32])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[32]*sigmay[32])*pow(my[32]-y[32],2.0)*5.0E-1;
    break;
    case 33:
  nllh[0] = amici::log((sigmay[33]*sigmay[33])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[33]*sigmay[33])*pow(my[33]-y[33],2.0)*5.0E-1;
    break;
    case 34:
  nllh[0] = amici::log((sigmay[34]*sigmay[34])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[34]*sigmay[34])*pow(my[34]-y[34],2.0)*5.0E-1;
    break;
    case 35:
  nllh[0] = amici::log((sigmay[35]*sigmay[35])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[35]*sigmay[35])*pow(my[35]-y[35],2.0)*5.0E-1;
    break;
    case 36:
  nllh[0] = amici::log((sigmay[36]*sigmay[36])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[36]*sigmay[36])*pow(my[36]-y[36],2.0)*5.0E-1;
    break;
    case 37:
  nllh[0] = amici::log((sigmay[37]*sigmay[37])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[37]*sigmay[37])*pow(my[37]-y[37],2.0)*5.0E-1;
    break;
    case 38:
  nllh[0] = amici::log((sigmay[38]*sigmay[38])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[38]*sigmay[38])*pow(my[38]-y[38],2.0)*5.0E-1;
    break;
    case 39:
  nllh[0] = amici::log((sigmay[39]*sigmay[39])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[39]*sigmay[39])*pow(my[39]-y[39],2.0)*5.0E-1;
    break;
    case 40:
  nllh[0] = amici::log((sigmay[40]*sigmay[40])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[40]*sigmay[40])*pow(my[40]-y[40],2.0)*5.0E-1;
    break;
    case 41:
  nllh[0] = amici::log((sigmay[41]*sigmay[41])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[41]*sigmay[41])*pow(my[41]-y[41],2.0)*5.0E-1;
    break;
    case 42:
  nllh[0] = amici::log((sigmay[42]*sigmay[42])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[42]*sigmay[42])*pow(my[42]-y[42],2.0)*5.0E-1;
    break;
    case 43:
  nllh[0] = amici::log((sigmay[43]*sigmay[43])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[43]*sigmay[43])*pow(my[43]-y[43],2.0)*5.0E-1;
    break;
    case 44:
  nllh[0] = amici::log((sigmay[44]*sigmay[44])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[44]*sigmay[44])*pow(my[44]-y[44],2.0)*5.0E-1;
    break;
    case 45:
  nllh[0] = amici::log((sigmay[45]*sigmay[45])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[45]*sigmay[45])*pow(my[45]-y[45],2.0)*5.0E-1;
    break;
    case 46:
  nllh[0] = amici::log((sigmay[46]*sigmay[46])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[46]*sigmay[46])*pow(my[46]-y[46],2.0)*5.0E-1;
    break;
    case 47:
  nllh[0] = amici::log((sigmay[47]*sigmay[47])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[47]*sigmay[47])*pow(my[47]-y[47],2.0)*5.0E-1;
    break;
    case 48:
  nllh[0] = amici::log((sigmay[48]*sigmay[48])*3.141592653589793*2.0)*5.0E-1+1.0/(sigmay[48]*sigmay[48])*pow(my[48]-y[48],2.0)*5.0E-1;
    break;
}
}

