
#include "amici/symbolic_functions.h"
#include "amici/defines.h" //realtype definition
typedef amici::realtype realtype;
#include <cmath> 

using namespace amici;

void dxdotdp_model_H_3(realtype *dxdotdp, const realtype t, const realtype *x, const realtype *p, const realtype *k, const realtype *h, const int ip, const realtype *w, const realtype *dwdp) {
switch (ip) {
  case 7: {
  dxdotdp[0] = -x[0]*dwdp[1];
  dxdotdp[4] = x[0]*3.0-x[4]*3.0;
  dxdotdp[5] = x[4]*3.0-x[5]*3.0;
  dxdotdp[6] = x[5]*3.0-x[6]*3.0;
  dxdotdp[13] = -x[13]*dwdp[1];
  dxdotdp[17] = x[13]*3.0-x[17]*3.0;
  dxdotdp[18] = x[17]*3.0-x[18]*3.0;
  dxdotdp[19] = x[18]*3.0-x[19]*3.0;
  dxdotdp[26] = -x[26]*dwdp[1];
  dxdotdp[30] = x[26]*3.0-x[30]*3.0;
  dxdotdp[31] = x[30]*3.0-x[31]*3.0;
  dxdotdp[32] = x[31]*3.0-x[32]*3.0;
  dxdotdp[39] = -x[39]*dwdp[1];
  dxdotdp[43] = x[39]*3.0-x[43]*3.0;
  dxdotdp[44] = x[43]*3.0-x[44]*3.0;
  dxdotdp[45] = x[44]*3.0-x[45]*3.0;
  dxdotdp[52] = -x[52]*dwdp[1];
  dxdotdp[56] = x[52]*3.0-x[56]*3.0;
  dxdotdp[57] = x[56]*3.0-x[57]*3.0;
  dxdotdp[58] = x[57]*3.0-x[58]*3.0;
  dxdotdp[65] = -x[65]*dwdp[1];
  dxdotdp[69] = x[65]*3.0-x[69]*3.0;
  dxdotdp[70] = x[69]*3.0-x[70]*3.0;
  dxdotdp[71] = x[70]*3.0-x[71]*3.0;
  dxdotdp[78] = -x[78]*dwdp[1];
  dxdotdp[82] = x[78]*3.0-x[82]*3.0;
  dxdotdp[83] = x[82]*3.0-x[83]*3.0;
  dxdotdp[84] = x[83]*3.0-x[84]*3.0;
  dxdotdp[252] = x[6]*3.0;
  dxdotdp[265] = x[19]*3.0;
  dxdotdp[278] = x[32]*3.0;
  dxdotdp[291] = x[45]*3.0;
  dxdotdp[304] = x[58]*3.0;
  dxdotdp[317] = x[71]*3.0;
  dxdotdp[330] = x[84]*3.0;

  } break;

  case 8: {
  dxdotdp[0] = -x[0]*dwdp[3];
  dxdotdp[7] = x[0]*3.0-x[7]*3.0;
  dxdotdp[8] = x[7]*3.0-x[8]*3.0;
  dxdotdp[9] = x[8]*3.0-x[9]*3.0;
  dxdotdp[13] = -x[13]*dwdp[3];
  dxdotdp[20] = x[13]*3.0-x[20]*3.0;
  dxdotdp[21] = x[20]*3.0-x[21]*3.0;
  dxdotdp[22] = x[21]*3.0-x[22]*3.0;
  dxdotdp[26] = -x[26]*dwdp[3];
  dxdotdp[33] = x[26]*3.0-x[33]*3.0;
  dxdotdp[34] = x[33]*3.0-x[34]*3.0;
  dxdotdp[35] = x[34]*3.0-x[35]*3.0;
  dxdotdp[39] = -x[39]*dwdp[3];
  dxdotdp[46] = x[39]*3.0-x[46]*3.0;
  dxdotdp[47] = x[46]*3.0-x[47]*3.0;
  dxdotdp[48] = x[47]*3.0-x[48]*3.0;
  dxdotdp[52] = -x[52]*dwdp[3];
  dxdotdp[59] = x[52]*3.0-x[59]*3.0;
  dxdotdp[60] = x[59]*3.0-x[60]*3.0;
  dxdotdp[61] = x[60]*3.0-x[61]*3.0;
  dxdotdp[65] = -x[65]*dwdp[3];
  dxdotdp[72] = x[65]*3.0-x[72]*3.0;
  dxdotdp[73] = x[72]*3.0-x[73]*3.0;
  dxdotdp[74] = x[73]*3.0-x[74]*3.0;
  dxdotdp[78] = -x[78]*dwdp[3];
  dxdotdp[85] = x[78]*3.0-x[85]*3.0;
  dxdotdp[86] = x[85]*3.0-x[86]*3.0;
  dxdotdp[87] = x[86]*3.0-x[87]*3.0;
  dxdotdp[91] = x[9]*3.0;
  dxdotdp[107] = x[22]*3.0;
  dxdotdp[123] = x[35]*3.0;
  dxdotdp[139] = x[48]*3.0;
  dxdotdp[155] = x[61]*3.0;
  dxdotdp[171] = x[74]*3.0;
  dxdotdp[187] = x[87]*3.0;

  } break;

  case 9: {
  dxdotdp[0] = -x[0]*dwdp[5];
  dxdotdp[1] = x[0]*3.0-x[1]*3.0;
  dxdotdp[2] = x[1]*3.0-x[2]*3.0;
  dxdotdp[3] = x[2]*3.0-x[3]*3.0;
  dxdotdp[13] = x[3]*6.0-x[13]*dwdp[5];
  dxdotdp[14] = x[13]*3.0-x[14]*3.0;
  dxdotdp[15] = x[14]*3.0-x[15]*3.0;
  dxdotdp[16] = x[15]*3.0-x[16]*3.0;
  dxdotdp[26] = x[16]*6.0-x[26]*dwdp[5];
  dxdotdp[27] = x[26]*3.0-x[27]*3.0;
  dxdotdp[28] = x[27]*3.0-x[28]*3.0;
  dxdotdp[29] = x[28]*3.0-x[29]*3.0;
  dxdotdp[39] = x[29]*6.0-x[39]*dwdp[5];
  dxdotdp[40] = x[39]*3.0-x[40]*3.0;
  dxdotdp[41] = x[40]*3.0-x[41]*3.0;
  dxdotdp[42] = x[41]*3.0-x[42]*3.0;
  dxdotdp[52] = x[42]*6.0-x[52]*dwdp[5];
  dxdotdp[53] = x[52]*3.0-x[53]*3.0;
  dxdotdp[54] = x[53]*3.0-x[54]*3.0;
  dxdotdp[55] = x[54]*3.0-x[55]*3.0;
  dxdotdp[65] = x[55]*6.0-x[65]*dwdp[5];
  dxdotdp[66] = x[65]*3.0-x[66]*3.0;
  dxdotdp[67] = x[66]*3.0-x[67]*3.0;
  dxdotdp[68] = x[67]*3.0-x[68]*3.0;
  dxdotdp[78] = x[68]*6.0+x[81]*6.0-x[78]*dwdp[5];
  dxdotdp[79] = x[78]*3.0-x[79]*3.0;
  dxdotdp[80] = x[79]*3.0-x[80]*3.0;
  dxdotdp[81] = x[80]*3.0-x[81]*3.0;

  } break;

  case 10: {
  dxdotdp[0] = -x[0]*dwdp[7];
  dxdotdp[10] = x[0]*3.0-x[10]*3.0;
  dxdotdp[11] = x[10]*3.0-x[11]*3.0;
  dxdotdp[12] = x[11]*3.0-x[12]*3.0;
  dxdotdp[13] = -x[13]*dwdp[7];
  dxdotdp[23] = x[13]*3.0-x[23]*3.0;
  dxdotdp[24] = x[23]*3.0-x[24]*3.0;
  dxdotdp[25] = x[24]*3.0-x[25]*3.0;
  dxdotdp[26] = -x[26]*dwdp[7];
  dxdotdp[36] = x[26]*3.0-x[36]*3.0;
  dxdotdp[37] = x[36]*3.0-x[37]*3.0;
  dxdotdp[38] = x[37]*3.0-x[38]*3.0;
  dxdotdp[39] = -x[39]*dwdp[7];
  dxdotdp[49] = x[39]*3.0-x[49]*3.0;
  dxdotdp[50] = x[49]*3.0-x[50]*3.0;
  dxdotdp[51] = x[50]*3.0-x[51]*3.0;
  dxdotdp[52] = -x[52]*dwdp[7];
  dxdotdp[62] = x[52]*3.0-x[62]*3.0;
  dxdotdp[63] = x[62]*3.0-x[63]*3.0;
  dxdotdp[64] = x[63]*3.0-x[64]*3.0;
  dxdotdp[65] = -x[65]*dwdp[7];
  dxdotdp[75] = x[65]*3.0-x[75]*3.0;
  dxdotdp[76] = x[75]*3.0-x[76]*3.0;
  dxdotdp[77] = x[76]*3.0-x[77]*3.0;
  dxdotdp[78] = -x[78]*dwdp[7];
  dxdotdp[88] = x[78]*3.0-x[88]*3.0;
  dxdotdp[89] = x[88]*3.0-x[89]*3.0;
  dxdotdp[90] = x[89]*3.0-x[90]*3.0;

  } break;

  case 11: {
  dxdotdp[252] = -x[252]*dwdp[9];
  dxdotdp[256] = x[252]*3.0-x[256]*3.0;
  dxdotdp[257] = x[256]*3.0-x[257]*3.0;
  dxdotdp[258] = x[257]*3.0-x[258]*3.0;
  dxdotdp[265] = -x[265]*dwdp[9];
  dxdotdp[269] = x[265]*3.0-x[269]*3.0;
  dxdotdp[270] = x[269]*3.0-x[270]*3.0;
  dxdotdp[271] = x[270]*3.0-x[271]*3.0;
  dxdotdp[278] = -x[278]*dwdp[9];
  dxdotdp[282] = x[278]*3.0-x[282]*3.0;
  dxdotdp[283] = x[282]*3.0-x[283]*3.0;
  dxdotdp[284] = x[283]*3.0-x[284]*3.0;
  dxdotdp[291] = -x[291]*dwdp[9];
  dxdotdp[295] = x[291]*3.0-x[295]*3.0;
  dxdotdp[296] = x[295]*3.0-x[296]*3.0;
  dxdotdp[297] = x[296]*3.0-x[297]*3.0;
  dxdotdp[304] = -x[304]*dwdp[9];
  dxdotdp[308] = x[304]*3.0-x[308]*3.0;
  dxdotdp[309] = x[308]*3.0-x[309]*3.0;
  dxdotdp[310] = x[309]*3.0-x[310]*3.0;
  dxdotdp[317] = -x[317]*dwdp[9];
  dxdotdp[321] = x[317]*3.0-x[321]*3.0;
  dxdotdp[322] = x[321]*3.0-x[322]*3.0;
  dxdotdp[323] = x[322]*3.0-x[323]*3.0;
  dxdotdp[330] = -dwdp[9]*x[330];
  dxdotdp[334] = x[330]*3.0-x[334]*3.0;
  dxdotdp[335] = x[334]*3.0-x[335]*3.0;
  dxdotdp[336] = x[335]*3.0-x[336]*3.0;
  dxdotdp[413] = x[258]*3.0;
  dxdotdp[423] = x[271]*3.0;
  dxdotdp[433] = x[284]*3.0;
  dxdotdp[443] = x[297]*3.0;
  dxdotdp[453] = x[310]*3.0;
  dxdotdp[463] = x[323]*3.0;
  dxdotdp[473] = x[336]*3.0;

  } break;

  case 12: {
  dxdotdp[252] = -x[252]*dwdp[11];
  dxdotdp[259] = x[252]*3.0-x[259]*3.0;
  dxdotdp[260] = x[259]*3.0-x[260]*3.0;
  dxdotdp[261] = x[260]*3.0-x[261]*3.0;
  dxdotdp[265] = -x[265]*dwdp[11];
  dxdotdp[272] = x[265]*3.0-x[272]*3.0;
  dxdotdp[273] = x[272]*3.0-x[273]*3.0;
  dxdotdp[274] = x[273]*3.0-x[274]*3.0;
  dxdotdp[278] = -x[278]*dwdp[11];
  dxdotdp[285] = x[278]*3.0-x[285]*3.0;
  dxdotdp[286] = x[285]*3.0-x[286]*3.0;
  dxdotdp[287] = x[286]*3.0-x[287]*3.0;
  dxdotdp[291] = -x[291]*dwdp[11];
  dxdotdp[298] = x[291]*3.0-x[298]*3.0;
  dxdotdp[299] = x[298]*3.0-x[299]*3.0;
  dxdotdp[300] = x[299]*3.0-x[300]*3.0;
  dxdotdp[304] = -x[304]*dwdp[11];
  dxdotdp[311] = x[304]*3.0-x[311]*3.0;
  dxdotdp[312] = x[311]*3.0-x[312]*3.0;
  dxdotdp[313] = x[312]*3.0-x[313]*3.0;
  dxdotdp[317] = -x[317]*dwdp[11];
  dxdotdp[324] = x[317]*3.0-x[324]*3.0;
  dxdotdp[325] = x[324]*3.0-x[325]*3.0;
  dxdotdp[326] = x[325]*3.0-x[326]*3.0;
  dxdotdp[330] = -dwdp[11]*x[330];
  dxdotdp[337] = x[330]*3.0-x[337]*3.0;
  dxdotdp[338] = x[337]*3.0-x[338]*3.0;
  dxdotdp[339] = x[338]*3.0-x[339]*3.0;
  dxdotdp[343] = x[261]*3.0;
  dxdotdp[353] = x[274]*3.0;
  dxdotdp[363] = x[287]*3.0;
  dxdotdp[373] = x[300]*3.0;
  dxdotdp[383] = x[313]*3.0;
  dxdotdp[393] = x[326]*3.0;
  dxdotdp[403] = x[339]*3.0;

  } break;

  case 13: {
  dxdotdp[252] = -x[252]*dwdp[13];
  dxdotdp[253] = x[252]*3.0-x[253]*3.0;
  dxdotdp[254] = x[253]*3.0-x[254]*3.0;
  dxdotdp[255] = x[254]*3.0-x[255]*3.0;
  dxdotdp[265] = x[255]*6.0-x[265]*dwdp[13];
  dxdotdp[266] = x[265]*3.0-x[266]*3.0;
  dxdotdp[267] = x[266]*3.0-x[267]*3.0;
  dxdotdp[268] = x[267]*3.0-x[268]*3.0;
  dxdotdp[278] = x[268]*6.0-x[278]*dwdp[13];
  dxdotdp[279] = x[278]*3.0-x[279]*3.0;
  dxdotdp[280] = x[279]*3.0-x[280]*3.0;
  dxdotdp[281] = x[280]*3.0-x[281]*3.0;
  dxdotdp[291] = x[281]*6.0-x[291]*dwdp[13];
  dxdotdp[292] = x[291]*3.0-x[292]*3.0;
  dxdotdp[293] = x[292]*3.0-x[293]*3.0;
  dxdotdp[294] = x[293]*3.0-x[294]*3.0;
  dxdotdp[304] = x[294]*6.0-x[304]*dwdp[13];
  dxdotdp[305] = x[304]*3.0-x[305]*3.0;
  dxdotdp[306] = x[305]*3.0-x[306]*3.0;
  dxdotdp[307] = x[306]*3.0-x[307]*3.0;
  dxdotdp[317] = x[307]*6.0-x[317]*dwdp[13];
  dxdotdp[318] = x[317]*3.0-x[318]*3.0;
  dxdotdp[319] = x[318]*3.0-x[319]*3.0;
  dxdotdp[320] = x[319]*3.0-x[320]*3.0;
  dxdotdp[330] = x[320]*6.0+x[333]*6.0-dwdp[13]*x[330];
  dxdotdp[331] = x[330]*3.0-x[331]*3.0;
  dxdotdp[332] = x[331]*3.0-x[332]*3.0;
  dxdotdp[333] = x[332]*3.0-x[333]*3.0;

  } break;

  case 14: {
  dxdotdp[252] = -x[252]*dwdp[15];
  dxdotdp[262] = x[252]*3.0-x[262]*3.0;
  dxdotdp[263] = x[262]*3.0-x[263]*3.0;
  dxdotdp[264] = x[263]*3.0-x[264]*3.0;
  dxdotdp[265] = -x[265]*dwdp[15];
  dxdotdp[275] = x[265]*3.0-x[275]*3.0;
  dxdotdp[276] = x[275]*3.0-x[276]*3.0;
  dxdotdp[277] = x[276]*3.0-x[277]*3.0;
  dxdotdp[278] = -x[278]*dwdp[15];
  dxdotdp[288] = x[278]*3.0-x[288]*3.0;
  dxdotdp[289] = x[288]*3.0-x[289]*3.0;
  dxdotdp[290] = x[289]*3.0-x[290]*3.0;
  dxdotdp[291] = -x[291]*dwdp[15];
  dxdotdp[301] = x[291]*3.0-x[301]*3.0;
  dxdotdp[302] = x[301]*3.0-x[302]*3.0;
  dxdotdp[303] = x[302]*3.0-x[303]*3.0;
  dxdotdp[304] = -x[304]*dwdp[15];
  dxdotdp[314] = x[304]*3.0-x[314]*3.0;
  dxdotdp[315] = x[314]*3.0-x[315]*3.0;
  dxdotdp[316] = x[315]*3.0-x[316]*3.0;
  dxdotdp[317] = -x[317]*dwdp[15];
  dxdotdp[327] = x[317]*3.0-x[327]*3.0;
  dxdotdp[328] = x[327]*3.0-x[328]*3.0;
  dxdotdp[329] = x[328]*3.0-x[329]*3.0;
  dxdotdp[330] = -dwdp[15]*x[330];
  dxdotdp[340] = x[330]*3.0-x[340]*3.0;
  dxdotdp[341] = x[340]*3.0-x[341]*3.0;
  dxdotdp[342] = x[341]*3.0-x[342]*3.0;

  } break;

  case 15: {
  dxdotdp[91] = -x[91]*dwdp[17];
  dxdotdp[95] = x[91]*3.0-x[95]*3.0;
  dxdotdp[96] = x[95]*3.0-x[96]*3.0;
  dxdotdp[97] = x[96]*3.0-x[97]*3.0;
  dxdotdp[107] = -x[107]*dwdp[17];
  dxdotdp[111] = x[107]*3.0-x[111]*3.0;
  dxdotdp[112] = x[111]*3.0-x[112]*3.0;
  dxdotdp[113] = x[112]*3.0-x[113]*3.0;
  dxdotdp[123] = -x[123]*dwdp[17];
  dxdotdp[127] = x[123]*3.0-x[127]*3.0;
  dxdotdp[128] = x[127]*3.0-x[128]*3.0;
  dxdotdp[129] = x[128]*3.0-x[129]*3.0;
  dxdotdp[139] = -x[139]*dwdp[17];
  dxdotdp[143] = x[139]*3.0-x[143]*3.0;
  dxdotdp[144] = x[143]*3.0-x[144]*3.0;
  dxdotdp[145] = x[144]*3.0-x[145]*3.0;
  dxdotdp[155] = -x[155]*dwdp[17];
  dxdotdp[159] = x[155]*3.0-x[159]*3.0;
  dxdotdp[160] = x[159]*3.0-x[160]*3.0;
  dxdotdp[161] = x[160]*3.0-x[161]*3.0;
  dxdotdp[171] = -x[171]*dwdp[17];
  dxdotdp[175] = x[171]*3.0-x[175]*3.0;
  dxdotdp[176] = x[175]*3.0-x[176]*3.0;
  dxdotdp[177] = x[176]*3.0-x[177]*3.0;
  dxdotdp[187] = -x[187]*dwdp[17];
  dxdotdp[191] = x[187]*3.0-x[191]*3.0;
  dxdotdp[192] = x[191]*3.0-x[192]*3.0;
  dxdotdp[193] = x[192]*3.0-x[193]*3.0;
  dxdotdp[343] = x[97]*3.0;
  dxdotdp[353] = x[113]*3.0;
  dxdotdp[363] = x[129]*3.0;
  dxdotdp[373] = x[145]*3.0;
  dxdotdp[383] = x[161]*3.0;
  dxdotdp[393] = x[177]*3.0;
  dxdotdp[403] = x[193]*3.0;

  } break;

  case 16: {
  dxdotdp[91] = -x[91]*dwdp[19];
  dxdotdp[98] = x[91]*3.0-x[98]*3.0;
  dxdotdp[99] = x[98]*3.0-x[99]*3.0;
  dxdotdp[100] = x[99]*3.0-x[100]*3.0;
  dxdotdp[107] = -x[107]*dwdp[19];
  dxdotdp[114] = x[107]*3.0-x[114]*3.0;
  dxdotdp[115] = x[114]*3.0-x[115]*3.0;
  dxdotdp[116] = x[115]*3.0-x[116]*3.0;
  dxdotdp[123] = -x[123]*dwdp[19];
  dxdotdp[130] = x[123]*3.0-x[130]*3.0;
  dxdotdp[131] = x[130]*3.0-x[131]*3.0;
  dxdotdp[132] = x[131]*3.0-x[132]*3.0;
  dxdotdp[139] = -x[139]*dwdp[19];
  dxdotdp[146] = x[139]*3.0-x[146]*3.0;
  dxdotdp[147] = x[146]*3.0-x[147]*3.0;
  dxdotdp[148] = x[147]*3.0-x[148]*3.0;
  dxdotdp[155] = -x[155]*dwdp[19];
  dxdotdp[162] = x[155]*3.0-x[162]*3.0;
  dxdotdp[163] = x[162]*3.0-x[163]*3.0;
  dxdotdp[164] = x[163]*3.0-x[164]*3.0;
  dxdotdp[171] = -x[171]*dwdp[19];
  dxdotdp[178] = x[171]*3.0-x[178]*3.0;
  dxdotdp[179] = x[178]*3.0-x[179]*3.0;
  dxdotdp[180] = x[179]*3.0-x[180]*3.0;
  dxdotdp[187] = -x[187]*dwdp[19];
  dxdotdp[194] = x[187]*3.0-x[194]*3.0;
  dxdotdp[195] = x[194]*3.0-x[195]*3.0;
  dxdotdp[196] = x[195]*3.0-x[196]*3.0;
  dxdotdp[203] = x[100]*3.0;
  dxdotdp[210] = x[116]*3.0;
  dxdotdp[217] = x[132]*3.0;
  dxdotdp[224] = x[148]*3.0;
  dxdotdp[231] = x[164]*3.0;
  dxdotdp[238] = x[180]*3.0;
  dxdotdp[245] = x[196]*3.0;

  } break;

  case 17: {
  dxdotdp[91] = -x[91]*dwdp[21];
  dxdotdp[101] = x[91]*3.0-x[101]*3.0;
  dxdotdp[102] = x[101]*3.0-x[102]*3.0;
  dxdotdp[103] = x[102]*3.0-x[103]*3.0;
  dxdotdp[107] = -x[107]*dwdp[21];
  dxdotdp[117] = x[107]*3.0-x[117]*3.0;
  dxdotdp[118] = x[117]*3.0-x[118]*3.0;
  dxdotdp[119] = x[118]*3.0-x[119]*3.0;
  dxdotdp[123] = -x[123]*dwdp[21];
  dxdotdp[133] = x[123]*3.0-x[133]*3.0;
  dxdotdp[134] = x[133]*3.0-x[134]*3.0;
  dxdotdp[135] = x[134]*3.0-x[135]*3.0;
  dxdotdp[139] = -x[139]*dwdp[21];
  dxdotdp[149] = x[139]*3.0-x[149]*3.0;
  dxdotdp[150] = x[149]*3.0-x[150]*3.0;
  dxdotdp[151] = x[150]*3.0-x[151]*3.0;
  dxdotdp[155] = -x[155]*dwdp[21];
  dxdotdp[165] = x[155]*3.0-x[165]*3.0;
  dxdotdp[166] = x[165]*3.0-x[166]*3.0;
  dxdotdp[167] = x[166]*3.0-x[167]*3.0;
  dxdotdp[171] = -x[171]*dwdp[21];
  dxdotdp[181] = x[171]*3.0-x[181]*3.0;
  dxdotdp[182] = x[181]*3.0-x[182]*3.0;
  dxdotdp[183] = x[182]*3.0-x[183]*3.0;
  dxdotdp[187] = -x[187]*dwdp[21];
  dxdotdp[197] = x[187]*3.0-x[197]*3.0;
  dxdotdp[198] = x[197]*3.0-x[198]*3.0;
  dxdotdp[199] = x[198]*3.0-x[199]*3.0;
  dxdotdp[413] = x[103]*3.0;
  dxdotdp[423] = x[119]*3.0;
  dxdotdp[433] = x[135]*3.0;
  dxdotdp[443] = x[151]*3.0;
  dxdotdp[453] = x[167]*3.0;
  dxdotdp[463] = x[183]*3.0;
  dxdotdp[473] = x[199]*3.0;

  } break;

  case 18: {
  dxdotdp[91] = -x[91]*dwdp[23];
  dxdotdp[92] = x[91]*3.0-x[92]*3.0;
  dxdotdp[93] = x[92]*3.0-x[93]*3.0;
  dxdotdp[94] = x[93]*3.0-x[94]*3.0;
  dxdotdp[107] = x[94]*6.0-x[107]*dwdp[23];
  dxdotdp[108] = x[107]*3.0-x[108]*3.0;
  dxdotdp[109] = x[108]*3.0-x[109]*3.0;
  dxdotdp[110] = x[109]*3.0-x[110]*3.0;
  dxdotdp[123] = x[110]*6.0-x[123]*dwdp[23];
  dxdotdp[124] = x[123]*3.0-x[124]*3.0;
  dxdotdp[125] = x[124]*3.0-x[125]*3.0;
  dxdotdp[126] = x[125]*3.0-x[126]*3.0;
  dxdotdp[139] = x[126]*6.0-x[139]*dwdp[23];
  dxdotdp[140] = x[139]*3.0-x[140]*3.0;
  dxdotdp[141] = x[140]*3.0-x[141]*3.0;
  dxdotdp[142] = x[141]*3.0-x[142]*3.0;
  dxdotdp[155] = x[142]*6.0-x[155]*dwdp[23];
  dxdotdp[156] = x[155]*3.0-x[156]*3.0;
  dxdotdp[157] = x[156]*3.0-x[157]*3.0;
  dxdotdp[158] = x[157]*3.0-x[158]*3.0;
  dxdotdp[171] = x[158]*6.0-x[171]*dwdp[23];
  dxdotdp[172] = x[171]*3.0-x[172]*3.0;
  dxdotdp[173] = x[172]*3.0-x[173]*3.0;
  dxdotdp[174] = x[173]*3.0-x[174]*3.0;
  dxdotdp[187] = x[174]*6.0+x[190]*6.0-x[187]*dwdp[23];
  dxdotdp[188] = x[187]*3.0-x[188]*3.0;
  dxdotdp[189] = x[188]*3.0-x[189]*3.0;
  dxdotdp[190] = x[189]*3.0-x[190]*3.0;

  } break;

  case 19: {
  dxdotdp[91] = -x[91]*dwdp[25];
  dxdotdp[104] = x[91]*3.0-x[104]*3.0;
  dxdotdp[105] = x[104]*3.0-x[105]*3.0;
  dxdotdp[106] = x[105]*3.0-x[106]*3.0;
  dxdotdp[107] = -x[107]*dwdp[25];
  dxdotdp[120] = x[107]*3.0-x[120]*3.0;
  dxdotdp[121] = x[120]*3.0-x[121]*3.0;
  dxdotdp[122] = x[121]*3.0-x[122]*3.0;
  dxdotdp[123] = -x[123]*dwdp[25];
  dxdotdp[136] = x[123]*3.0-x[136]*3.0;
  dxdotdp[137] = x[136]*3.0-x[137]*3.0;
  dxdotdp[138] = x[137]*3.0-x[138]*3.0;
  dxdotdp[139] = -x[139]*dwdp[25];
  dxdotdp[152] = x[139]*3.0-x[152]*3.0;
  dxdotdp[153] = x[152]*3.0-x[153]*3.0;
  dxdotdp[154] = x[153]*3.0-x[154]*3.0;
  dxdotdp[155] = -x[155]*dwdp[25];
  dxdotdp[168] = x[155]*3.0-x[168]*3.0;
  dxdotdp[169] = x[168]*3.0-x[169]*3.0;
  dxdotdp[170] = x[169]*3.0-x[170]*3.0;
  dxdotdp[171] = -x[171]*dwdp[25];
  dxdotdp[184] = x[171]*3.0-x[184]*3.0;
  dxdotdp[185] = x[184]*3.0-x[185]*3.0;
  dxdotdp[186] = x[185]*3.0-x[186]*3.0;
  dxdotdp[187] = -x[187]*dwdp[25];
  dxdotdp[200] = x[187]*3.0-x[200]*3.0;
  dxdotdp[201] = x[200]*3.0-x[201]*3.0;
  dxdotdp[202] = x[201]*3.0-x[202]*3.0;

  } break;

  case 20: {
  dxdotdp[203] = -x[203]*dwdp[27];
  dxdotdp[207] = x[203]*3.0-x[207]*3.0;
  dxdotdp[208] = x[207]*3.0-x[208]*3.0;
  dxdotdp[209] = x[208]*3.0-x[209]*3.0;
  dxdotdp[210] = -x[210]*dwdp[27];
  dxdotdp[214] = x[210]*3.0-x[214]*3.0;
  dxdotdp[215] = x[214]*3.0-x[215]*3.0;
  dxdotdp[216] = x[215]*3.0-x[216]*3.0;
  dxdotdp[217] = -x[217]*dwdp[27];
  dxdotdp[221] = x[217]*3.0-x[221]*3.0;
  dxdotdp[222] = x[221]*3.0-x[222]*3.0;
  dxdotdp[223] = x[222]*3.0-x[223]*3.0;
  dxdotdp[224] = -x[224]*dwdp[27];
  dxdotdp[228] = x[224]*3.0-x[228]*3.0;
  dxdotdp[229] = x[228]*3.0-x[229]*3.0;
  dxdotdp[230] = x[229]*3.0-x[230]*3.0;
  dxdotdp[231] = -x[231]*dwdp[27];
  dxdotdp[235] = x[231]*3.0-x[235]*3.0;
  dxdotdp[236] = x[235]*3.0-x[236]*3.0;
  dxdotdp[237] = x[236]*3.0-x[237]*3.0;
  dxdotdp[238] = -x[238]*dwdp[27];
  dxdotdp[242] = x[238]*3.0-x[242]*3.0;
  dxdotdp[243] = x[242]*3.0-x[243]*3.0;
  dxdotdp[244] = x[243]*3.0-x[244]*3.0;
  dxdotdp[245] = -x[245]*dwdp[27];
  dxdotdp[249] = x[245]*3.0-x[249]*3.0;
  dxdotdp[250] = x[249]*3.0-x[250]*3.0;
  dxdotdp[251] = x[250]*3.0-x[251]*3.0;

  } break;

  case 21: {
  dxdotdp[203] = -x[203]*dwdp[29];
  dxdotdp[204] = x[203]*3.0-x[204]*3.0;
  dxdotdp[205] = x[204]*3.0-x[205]*3.0;
  dxdotdp[206] = x[205]*3.0-x[206]*3.0;
  dxdotdp[210] = x[206]*6.0-x[210]*dwdp[29];
  dxdotdp[211] = x[210]*3.0-x[211]*3.0;
  dxdotdp[212] = x[211]*3.0-x[212]*3.0;
  dxdotdp[213] = x[212]*3.0-x[213]*3.0;
  dxdotdp[217] = x[213]*6.0-x[217]*dwdp[29];
  dxdotdp[218] = x[217]*3.0-x[218]*3.0;
  dxdotdp[219] = x[218]*3.0-x[219]*3.0;
  dxdotdp[220] = x[219]*3.0-x[220]*3.0;
  dxdotdp[224] = x[220]*6.0-x[224]*dwdp[29];
  dxdotdp[225] = x[224]*3.0-x[225]*3.0;
  dxdotdp[226] = x[225]*3.0-x[226]*3.0;
  dxdotdp[227] = x[226]*3.0-x[227]*3.0;
  dxdotdp[231] = x[227]*6.0-x[231]*dwdp[29];
  dxdotdp[232] = x[231]*3.0-x[232]*3.0;
  dxdotdp[233] = x[232]*3.0-x[233]*3.0;
  dxdotdp[234] = x[233]*3.0-x[234]*3.0;
  dxdotdp[238] = x[234]*6.0-x[238]*dwdp[29];
  dxdotdp[239] = x[238]*3.0-x[239]*3.0;
  dxdotdp[240] = x[239]*3.0-x[240]*3.0;
  dxdotdp[241] = x[240]*3.0-x[241]*3.0;
  dxdotdp[245] = x[241]*6.0+x[248]*6.0-x[245]*dwdp[29];
  dxdotdp[246] = x[245]*3.0-x[246]*3.0;
  dxdotdp[247] = x[246]*3.0-x[247]*3.0;
  dxdotdp[248] = x[247]*3.0-x[248]*3.0;

  } break;

  case 22: {
  dxdotdp[413] = -dwdp[31]*x[413];
  dxdotdp[417] = x[413]*3.0-x[417]*3.0;
  dxdotdp[418] = x[417]*3.0-x[418]*3.0;
  dxdotdp[419] = x[418]*3.0-x[419]*3.0;
  dxdotdp[423] = -dwdp[31]*x[423];
  dxdotdp[427] = x[423]*3.0-x[427]*3.0;
  dxdotdp[428] = x[427]*3.0-x[428]*3.0;
  dxdotdp[429] = x[428]*3.0-x[429]*3.0;
  dxdotdp[433] = -dwdp[31]*x[433];
  dxdotdp[437] = x[433]*3.0-x[437]*3.0;
  dxdotdp[438] = x[437]*3.0-x[438]*3.0;
  dxdotdp[439] = x[438]*3.0-x[439]*3.0;
  dxdotdp[443] = -dwdp[31]*x[443];
  dxdotdp[447] = x[443]*3.0-x[447]*3.0;
  dxdotdp[448] = x[447]*3.0-x[448]*3.0;
  dxdotdp[449] = x[448]*3.0-x[449]*3.0;
  dxdotdp[453] = -dwdp[31]*x[453];
  dxdotdp[457] = x[453]*3.0-x[457]*3.0;
  dxdotdp[458] = x[457]*3.0-x[458]*3.0;
  dxdotdp[459] = x[458]*3.0-x[459]*3.0;
  dxdotdp[463] = -dwdp[31]*x[463];
  dxdotdp[467] = x[463]*3.0-x[467]*3.0;
  dxdotdp[468] = x[467]*3.0-x[468]*3.0;
  dxdotdp[469] = x[468]*3.0-x[469]*3.0;
  dxdotdp[473] = -dwdp[31]*x[473];
  dxdotdp[477] = x[473]*3.0-x[477]*3.0;
  dxdotdp[478] = x[477]*3.0-x[478]*3.0;
  dxdotdp[479] = x[478]*3.0-x[479]*3.0;
  dxdotdp[483] = x[419]*3.0;
  dxdotdp[490] = x[429]*3.0;
  dxdotdp[497] = x[439]*3.0;
  dxdotdp[504] = x[449]*3.0;
  dxdotdp[511] = x[459]*3.0;
  dxdotdp[518] = x[469]*3.0;
  dxdotdp[525] = x[479]*3.0;

  } break;

  case 23: {
  dxdotdp[413] = -dwdp[33]*x[413];
  dxdotdp[414] = x[413]*3.0-x[414]*3.0;
  dxdotdp[415] = x[414]*3.0-x[415]*3.0;
  dxdotdp[416] = x[415]*3.0-x[416]*3.0;
  dxdotdp[423] = x[416]*6.0-dwdp[33]*x[423];
  dxdotdp[424] = x[423]*3.0-x[424]*3.0;
  dxdotdp[425] = x[424]*3.0-x[425]*3.0;
  dxdotdp[426] = x[425]*3.0-x[426]*3.0;
  dxdotdp[433] = x[426]*6.0-dwdp[33]*x[433];
  dxdotdp[434] = x[433]*3.0-x[434]*3.0;
  dxdotdp[435] = x[434]*3.0-x[435]*3.0;
  dxdotdp[436] = x[435]*3.0-x[436]*3.0;
  dxdotdp[443] = x[436]*6.0-dwdp[33]*x[443];
  dxdotdp[444] = x[443]*3.0-x[444]*3.0;
  dxdotdp[445] = x[444]*3.0-x[445]*3.0;
  dxdotdp[446] = x[445]*3.0-x[446]*3.0;
  dxdotdp[453] = x[446]*6.0-dwdp[33]*x[453];
  dxdotdp[454] = x[453]*3.0-x[454]*3.0;
  dxdotdp[455] = x[454]*3.0-x[455]*3.0;
  dxdotdp[456] = x[455]*3.0-x[456]*3.0;
  dxdotdp[463] = x[456]*6.0-dwdp[33]*x[463];
  dxdotdp[464] = x[463]*3.0-x[464]*3.0;
  dxdotdp[465] = x[464]*3.0-x[465]*3.0;
  dxdotdp[466] = x[465]*3.0-x[466]*3.0;
  dxdotdp[473] = x[466]*6.0+x[476]*6.0-dwdp[33]*x[473];
  dxdotdp[474] = x[473]*3.0-x[474]*3.0;
  dxdotdp[475] = x[474]*3.0-x[475]*3.0;
  dxdotdp[476] = x[475]*3.0-x[476]*3.0;

  } break;

  case 24: {
  dxdotdp[413] = -dwdp[35]*x[413];
  dxdotdp[420] = x[413]*3.0-x[420]*3.0;
  dxdotdp[421] = x[420]*3.0-x[421]*3.0;
  dxdotdp[422] = x[421]*3.0-x[422]*3.0;
  dxdotdp[423] = -dwdp[35]*x[423];
  dxdotdp[430] = x[423]*3.0-x[430]*3.0;
  dxdotdp[431] = x[430]*3.0-x[431]*3.0;
  dxdotdp[432] = x[431]*3.0-x[432]*3.0;
  dxdotdp[433] = -dwdp[35]*x[433];
  dxdotdp[440] = x[433]*3.0-x[440]*3.0;
  dxdotdp[441] = x[440]*3.0-x[441]*3.0;
  dxdotdp[442] = x[441]*3.0-x[442]*3.0;
  dxdotdp[443] = -dwdp[35]*x[443];
  dxdotdp[450] = x[443]*3.0-x[450]*3.0;
  dxdotdp[451] = x[450]*3.0-x[451]*3.0;
  dxdotdp[452] = x[451]*3.0-x[452]*3.0;
  dxdotdp[453] = -dwdp[35]*x[453];
  dxdotdp[460] = x[453]*3.0-x[460]*3.0;
  dxdotdp[461] = x[460]*3.0-x[461]*3.0;
  dxdotdp[462] = x[461]*3.0-x[462]*3.0;
  dxdotdp[463] = -dwdp[35]*x[463];
  dxdotdp[470] = x[463]*3.0-x[470]*3.0;
  dxdotdp[471] = x[470]*3.0-x[471]*3.0;
  dxdotdp[472] = x[471]*3.0-x[472]*3.0;
  dxdotdp[473] = -dwdp[35]*x[473];
  dxdotdp[480] = x[473]*3.0-x[480]*3.0;
  dxdotdp[481] = x[480]*3.0-x[481]*3.0;
  dxdotdp[482] = x[481]*3.0-x[482]*3.0;

  } break;

  case 25: {
  dxdotdp[343] = -x[343]*dwdp[37];
  dxdotdp[347] = x[343]*3.0-x[347]*3.0;
  dxdotdp[348] = x[347]*3.0-x[348]*3.0;
  dxdotdp[349] = x[348]*3.0-x[349]*3.0;
  dxdotdp[353] = -dwdp[37]*x[353];
  dxdotdp[357] = x[353]*3.0-x[357]*3.0;
  dxdotdp[358] = x[357]*3.0-x[358]*3.0;
  dxdotdp[359] = x[358]*3.0-x[359]*3.0;
  dxdotdp[363] = -dwdp[37]*x[363];
  dxdotdp[367] = x[363]*3.0-x[367]*3.0;
  dxdotdp[368] = x[367]*3.0-x[368]*3.0;
  dxdotdp[369] = x[368]*3.0-x[369]*3.0;
  dxdotdp[373] = -dwdp[37]*x[373];
  dxdotdp[377] = x[373]*3.0-x[377]*3.0;
  dxdotdp[378] = x[377]*3.0-x[378]*3.0;
  dxdotdp[379] = x[378]*3.0-x[379]*3.0;
  dxdotdp[383] = -dwdp[37]*x[383];
  dxdotdp[387] = x[383]*3.0-x[387]*3.0;
  dxdotdp[388] = x[387]*3.0-x[388]*3.0;
  dxdotdp[389] = x[388]*3.0-x[389]*3.0;
  dxdotdp[393] = -dwdp[37]*x[393];
  dxdotdp[397] = x[393]*3.0-x[397]*3.0;
  dxdotdp[398] = x[397]*3.0-x[398]*3.0;
  dxdotdp[399] = x[398]*3.0-x[399]*3.0;
  dxdotdp[403] = -dwdp[37]*x[403];
  dxdotdp[407] = x[403]*3.0-x[407]*3.0;
  dxdotdp[408] = x[407]*3.0-x[408]*3.0;
  dxdotdp[409] = x[408]*3.0-x[409]*3.0;
  dxdotdp[483] = x[349]*3.0;
  dxdotdp[490] = x[359]*3.0;
  dxdotdp[497] = x[369]*3.0;
  dxdotdp[504] = x[379]*3.0;
  dxdotdp[511] = x[389]*3.0;
  dxdotdp[518] = x[399]*3.0;
  dxdotdp[525] = x[409]*3.0;

  } break;

  case 26: {
  dxdotdp[343] = -x[343]*dwdp[39];
  dxdotdp[344] = x[343]*3.0-x[344]*3.0;
  dxdotdp[345] = x[344]*3.0-x[345]*3.0;
  dxdotdp[346] = x[345]*3.0-x[346]*3.0;
  dxdotdp[353] = x[346]*6.0-dwdp[39]*x[353];
  dxdotdp[354] = x[353]*3.0-x[354]*3.0;
  dxdotdp[355] = x[354]*3.0-x[355]*3.0;
  dxdotdp[356] = x[355]*3.0-x[356]*3.0;
  dxdotdp[363] = x[356]*6.0-dwdp[39]*x[363];
  dxdotdp[364] = x[363]*3.0-x[364]*3.0;
  dxdotdp[365] = x[364]*3.0-x[365]*3.0;
  dxdotdp[366] = x[365]*3.0-x[366]*3.0;
  dxdotdp[373] = x[366]*6.0-dwdp[39]*x[373];
  dxdotdp[374] = x[373]*3.0-x[374]*3.0;
  dxdotdp[375] = x[374]*3.0-x[375]*3.0;
  dxdotdp[376] = x[375]*3.0-x[376]*3.0;
  dxdotdp[383] = x[376]*6.0-dwdp[39]*x[383];
  dxdotdp[384] = x[383]*3.0-x[384]*3.0;
  dxdotdp[385] = x[384]*3.0-x[385]*3.0;
  dxdotdp[386] = x[385]*3.0-x[386]*3.0;
  dxdotdp[393] = x[386]*6.0-dwdp[39]*x[393];
  dxdotdp[394] = x[393]*3.0-x[394]*3.0;
  dxdotdp[395] = x[394]*3.0-x[395]*3.0;
  dxdotdp[396] = x[395]*3.0-x[396]*3.0;
  dxdotdp[403] = x[396]*6.0+x[406]*6.0-dwdp[39]*x[403];
  dxdotdp[404] = x[403]*3.0-x[404]*3.0;
  dxdotdp[405] = x[404]*3.0-x[405]*3.0;
  dxdotdp[406] = x[405]*3.0-x[406]*3.0;

  } break;

  case 27: {
  dxdotdp[343] = -x[343]*dwdp[41];
  dxdotdp[350] = x[343]*3.0-x[350]*3.0;
  dxdotdp[351] = x[350]*3.0-x[351]*3.0;
  dxdotdp[352] = x[351]*3.0-x[352]*3.0;
  dxdotdp[353] = -dwdp[41]*x[353];
  dxdotdp[360] = x[353]*3.0-x[360]*3.0;
  dxdotdp[361] = x[360]*3.0-x[361]*3.0;
  dxdotdp[362] = x[361]*3.0-x[362]*3.0;
  dxdotdp[363] = -dwdp[41]*x[363];
  dxdotdp[370] = x[363]*3.0-x[370]*3.0;
  dxdotdp[371] = x[370]*3.0-x[371]*3.0;
  dxdotdp[372] = x[371]*3.0-x[372]*3.0;
  dxdotdp[373] = -dwdp[41]*x[373];
  dxdotdp[380] = x[373]*3.0-x[380]*3.0;
  dxdotdp[381] = x[380]*3.0-x[381]*3.0;
  dxdotdp[382] = x[381]*3.0-x[382]*3.0;
  dxdotdp[383] = -dwdp[41]*x[383];
  dxdotdp[390] = x[383]*3.0-x[390]*3.0;
  dxdotdp[391] = x[390]*3.0-x[391]*3.0;
  dxdotdp[392] = x[391]*3.0-x[392]*3.0;
  dxdotdp[393] = -dwdp[41]*x[393];
  dxdotdp[400] = x[393]*3.0-x[400]*3.0;
  dxdotdp[401] = x[400]*3.0-x[401]*3.0;
  dxdotdp[402] = x[401]*3.0-x[402]*3.0;
  dxdotdp[403] = -dwdp[41]*x[403];
  dxdotdp[410] = x[403]*3.0-x[410]*3.0;
  dxdotdp[411] = x[410]*3.0-x[411]*3.0;
  dxdotdp[412] = x[411]*3.0-x[412]*3.0;

  } break;

  case 28: {
  dxdotdp[483] = -dwdp[43]*x[483];
  dxdotdp[484] = x[483]*3.0-x[484]*3.0;
  dxdotdp[485] = x[484]*3.0-x[485]*3.0;
  dxdotdp[486] = x[485]*3.0-x[486]*3.0;
  dxdotdp[490] = x[486]*6.0-dwdp[43]*x[490];
  dxdotdp[491] = x[490]*3.0-x[491]*3.0;
  dxdotdp[492] = x[491]*3.0-x[492]*3.0;
  dxdotdp[493] = x[492]*3.0-x[493]*3.0;
  dxdotdp[497] = x[493]*6.0-dwdp[43]*x[497];
  dxdotdp[498] = x[497]*3.0-x[498]*3.0;
  dxdotdp[499] = x[498]*3.0-x[499]*3.0;
  dxdotdp[500] = x[499]*3.0-x[500]*3.0;
  dxdotdp[504] = x[500]*6.0-dwdp[43]*x[504];
  dxdotdp[505] = x[504]*3.0-x[505]*3.0;
  dxdotdp[506] = x[505]*3.0-x[506]*3.0;
  dxdotdp[507] = x[506]*3.0-x[507]*3.0;
  dxdotdp[511] = x[507]*6.0-dwdp[43]*x[511];
  dxdotdp[512] = x[511]*3.0-x[512]*3.0;
  dxdotdp[513] = x[512]*3.0-x[513]*3.0;
  dxdotdp[514] = x[513]*3.0-x[514]*3.0;
  dxdotdp[518] = x[514]*6.0-dwdp[43]*x[518];
  dxdotdp[519] = x[518]*3.0-x[519]*3.0;
  dxdotdp[520] = x[519]*3.0-x[520]*3.0;
  dxdotdp[521] = x[520]*3.0-x[521]*3.0;
  dxdotdp[525] = x[521]*6.0+x[528]*6.0-dwdp[43]*x[525];
  dxdotdp[526] = x[525]*3.0-x[526]*3.0;
  dxdotdp[527] = x[526]*3.0-x[527]*3.0;
  dxdotdp[528] = x[527]*3.0-x[528]*3.0;

  } break;

  case 29: {
  dxdotdp[483] = -dwdp[45]*x[483];
  dxdotdp[487] = x[483]*3.0-x[487]*3.0;
  dxdotdp[488] = x[487]*3.0-x[488]*3.0;
  dxdotdp[489] = x[488]*3.0-x[489]*3.0;
  dxdotdp[490] = -dwdp[45]*x[490];
  dxdotdp[494] = x[490]*3.0-x[494]*3.0;
  dxdotdp[495] = x[494]*3.0-x[495]*3.0;
  dxdotdp[496] = x[495]*3.0-x[496]*3.0;
  dxdotdp[497] = -dwdp[45]*x[497];
  dxdotdp[501] = x[497]*3.0-x[501]*3.0;
  dxdotdp[502] = x[501]*3.0-x[502]*3.0;
  dxdotdp[503] = x[502]*3.0-x[503]*3.0;
  dxdotdp[504] = -dwdp[45]*x[504];
  dxdotdp[508] = x[504]*3.0-x[508]*3.0;
  dxdotdp[509] = x[508]*3.0-x[509]*3.0;
  dxdotdp[510] = x[509]*3.0-x[510]*3.0;
  dxdotdp[511] = -dwdp[45]*x[511];
  dxdotdp[515] = x[511]*3.0-x[515]*3.0;
  dxdotdp[516] = x[515]*3.0-x[516]*3.0;
  dxdotdp[517] = x[516]*3.0-x[517]*3.0;
  dxdotdp[518] = -dwdp[45]*x[518];
  dxdotdp[522] = x[518]*3.0-x[522]*3.0;
  dxdotdp[523] = x[522]*3.0-x[523]*3.0;
  dxdotdp[524] = x[523]*3.0-x[524]*3.0;
  dxdotdp[525] = -dwdp[45]*x[525];
  dxdotdp[529] = x[525]*3.0-x[529]*3.0;
  dxdotdp[530] = x[529]*3.0-x[530]*3.0;
  dxdotdp[531] = x[530]*3.0-x[531]*3.0;

  } break;

}
}
