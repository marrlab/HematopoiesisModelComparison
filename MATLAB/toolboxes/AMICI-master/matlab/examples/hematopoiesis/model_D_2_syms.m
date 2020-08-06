function [model] = model_D_2_syms()
% set the parametrisation of the problem options are 'log', 'log10' and
% 'lin' (default).
% model.param = 'log10';

%%
% STATES

% create state syms
syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20 x21 x22 x23 x24 x25 x26 x27 x28 x29 x30 x31 x32 x33 x34 x35 x36 x37 x38 x39 x40 x41 x42 x43 x44 x45 x46 x47 x48 x49 x50 x51 x52 x53 x54 x55 x56 x57 x58 x59 x60 x61 x62 x63 x64 x65 x66 x67 x68 x69 x70 x71 x72 x73 x74 x75 x76 x77 x78 x79 x80 x81 x82 x83 x84 x85 x86 x87 x88 x89 x90 x91 x92 x93 x94 x95 x96 x97 x98 x99 x100 x101 x102 x103 x104 x105 x106 x107 x108 x109 x110 x111 x112 x113 x114 x115 x116 x117 x118 x119 x120 x121 x122 x123 x124 x125 x126 x127 x128 x129 x130 x131 x132 x133 x134 x135 x136 x137 x138 x139 x140 x141 x142 x143 x144 x145 x146 x147 x148 x149 x150 x151 x152 x153 x154 x155 x156 x157 x158 x159 x160 x161 x162 x163 x164 x165 x166 x167 x168 x169 x170 x171 x172 x173 x174 x175 x176 x177 x178 x179 x180 x181 x182 x183 x184 x185 x186 x187 x188 x189 x190 x191 x192 x193 x194 x195 x196 x197 x198 x199 x200 x201 x202 x203 x204 x205 x206 x207 x208 x209 x210 x211 x212 x213 x214 x215 x216 x217 x218 x219 x220 x221 x222 x223 x224 x225 x226 x227 x228 x229 x230 x231 x232 x233 x234 x235 x236 x237 x238 x239 x240 x241 x242 x243 x244 x245 x246 x247 x248 x249 x250 x251 x252 x253 x254 x255 x256 x257 x258 x259 x260 x261 x262 x263 x264 x265 x266 x267 x268 x269 x270 x271 x272 x273 x274 x275 x276 x277 x278 x279 x280 x281 x282 x283 x284 x285 x286 x287 x288 x289 x290 x291 x292 x293 x294 x295 x296 x297 x298 x299 x300 x301 x302 x303 x304 x305 x306 x307 x308 x309 x310 x311 x312 x313 x314 x315 x316 x317 x318 x319 x320 x321 x322 x323 x324 x325 x326 x327 x328 x329 x330 x331 x332 x333 x334 x335 x336 x337 x338 x339 x340 x341 x342 x343 x344 x345 x346 x347 x348 x349 x350 x351 x352 x353 x354 x355 x356 x357

% create state vector
x = [
 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20 x21 x22 x23 x24 x25 x26 x27 x28 x29 x30 x31 x32 x33 x34 x35 x36 x37 x38 x39 x40 x41 x42 x43 x44 x45 x46 x47 x48 x49 x50 x51 x52 x53 x54 x55 x56 x57 x58 x59 x60 x61 x62 x63 x64 x65 x66 x67 x68 x69 x70 x71 x72 x73 x74 x75 x76 x77 x78 x79 x80 x81 x82 x83 x84 x85 x86 x87 x88 x89 x90 x91 x92 x93 x94 x95 x96 x97 x98 x99 x100 x101 x102 x103 x104 x105 x106 x107 x108 x109 x110 x111 x112 x113 x114 x115 x116 x117 x118 x119 x120 x121 x122 x123 x124 x125 x126 x127 x128 x129 x130 x131 x132 x133 x134 x135 x136 x137 x138 x139 x140 x141 x142 x143 x144 x145 x146 x147 x148 x149 x150 x151 x152 x153 x154 x155 x156 x157 x158 x159 x160 x161 x162 x163 x164 x165 x166 x167 x168 x169 x170 x171 x172 x173 x174 x175 x176 x177 x178 x179 x180 x181 x182 x183 x184 x185 x186 x187 x188 x189 x190 x191 x192 x193 x194 x195 x196 x197 x198 x199 x200 x201 x202 x203 x204 x205 x206 x207 x208 x209 x210 x211 x212 x213 x214 x215 x216 x217 x218 x219 x220 x221 x222 x223 x224 x225 x226 x227 x228 x229 x230 x231 x232 x233 x234 x235 x236 x237 x238 x239 x240 x241 x242 x243 x244 x245 x246 x247 x248 x249 x250 x251 x252 x253 x254 x255 x256 x257 x258 x259 x260 x261 x262 x263 x264 x265 x266 x267 x268 x269 x270 x271 x272 x273 x274 x275 x276 x277 x278 x279 x280 x281 x282 x283 x284 x285 x286 x287 x288 x289 x290 x291 x292 x293 x294 x295 x296 x297 x298 x299 x300 x301 x302 x303 x304 x305 x306 x307 x308 x309 x310 x311 x312 x313 x314 x315 x316 x317 x318 x319 x320 x321 x322 x323 x324 x325 x326 x327 x328 x329 x330 x331 x332 x333 x334 x335 x336 x337 x338 x339 x340 x341 x342 x343 x344 x345 x346 x347 x348 x349 x350 x351 x352 x353 x354 x355 x356 x357
];

%%
% PARAMETERS ( for these sensitivities will be computed )

% create parameter syms
syms x0_1 x0_2 x0_3 x0_4 x0_5 x0_6 x0_7 a_HSC_MPP a_HSC_mat b_HSC g_HSC a_MPP_CMP a_MPP_MLP b_MPP g_MPP a_CMP_MEP a_CMP_GMP b_CMP g_CMP a_MLP b_MLP a_MEP_mat b_MEP g_MEP a_GMP_mat b_GMP g_GMP b_mat g_mat

% create parameter vector 
p= [x0_1 x0_2 x0_3 x0_4 x0_5 x0_6 x0_7 a_HSC_MPP a_HSC_mat b_HSC g_HSC a_MPP_CMP a_MPP_MLP b_MPP g_MPP a_CMP_MEP a_CMP_GMP b_CMP g_CMP a_MLP b_MLP a_MEP_mat b_MEP g_MEP a_GMP_mat b_GMP g_GMP b_mat g_mat];

%%
% CONSTANTS ( for these no sensitivities will be computed )
% this part is optional and can be ommited

% create constants syms
k=[];
% k=[x0_1, x0_2, x0_3, x0_4, x0_5, x0_6, x0_7, x0_8];


%%
% SYSTEM EQUATIONS
% create symbolic variable for time
syms t

xdot = sym(zeros(size(x)));


%HSC
xdot(1) =-(b_HSC*2+a_HSC_MPP*2+a_HSC_mat*2+g_HSC*2)*x1;
xdot(2) =+b_HSC*2*(x1-x2);
xdot(3) =+b_HSC*2*(x2-x3);
xdot(4) =a_HSC_MPP*2*(x1-x4);
xdot(5) =a_HSC_MPP*2*(x4-x5);
xdot(6) =a_HSC_mat*2*(x1-x6);
xdot(7) =a_HSC_mat*2*(x6-x7);
xdot(8) =g_HSC*2*(x1-x8);
xdot(9) =g_HSC*2*(x8-x9);
xdot(10) =+2*b_HSC*2*x3-(b_HSC*2+a_HSC_MPP*2+a_HSC_mat*2+g_HSC*2)*x10;
xdot(11) =+b_HSC*2*(x10-x11);
xdot(12) =+b_HSC*2*(x11-x12);
xdot(13) =a_HSC_MPP*2*(x10-x13);
xdot(14) =a_HSC_MPP*2*(x13-x14);
xdot(15) =a_HSC_mat*2*(x10-x15);
xdot(16) =a_HSC_mat*2*(x15-x16);
xdot(17) =g_HSC*2*(x10-x17);
xdot(18) =g_HSC*2*(x17-x18);
xdot(19) =+2*b_HSC*2*x12-(b_HSC*2+a_HSC_MPP*2+a_HSC_mat*2+g_HSC*2)*x19;
xdot(20) =+b_HSC*2*(x19-x20);
xdot(21) =+b_HSC*2*(x20-x21);
xdot(22) =a_HSC_MPP*2*(x19-x22);
xdot(23) =a_HSC_MPP*2*(x22-x23);
xdot(24) =a_HSC_mat*2*(x19-x24);
xdot(25) =a_HSC_mat*2*(x24-x25);
xdot(26) =g_HSC*2*(x19-x26);
xdot(27) =g_HSC*2*(x26-x27);
xdot(28) =+2*b_HSC*2*x21-(b_HSC*2+a_HSC_MPP*2+a_HSC_mat*2+g_HSC*2)*x28;
xdot(29) =+b_HSC*2*(x28-x29);
xdot(30) =+b_HSC*2*(x29-x30);
xdot(31) =a_HSC_MPP*2*(x28-x31);
xdot(32) =a_HSC_MPP*2*(x31-x32);
xdot(33) =a_HSC_mat*2*(x28-x33);
xdot(34) =a_HSC_mat*2*(x33-x34);
xdot(35) =g_HSC*2*(x28-x35);
xdot(36) =g_HSC*2*(x35-x36);
xdot(37) =+2*b_HSC*2*x30-(b_HSC*2+a_HSC_MPP*2+a_HSC_mat*2+g_HSC*2)*x37;
xdot(38) =+b_HSC*2*(x37-x38);
xdot(39) =+b_HSC*2*(x38-x39);
xdot(40) =a_HSC_MPP*2*(x37-x40);
xdot(41) =a_HSC_MPP*2*(x40-x41);
xdot(42) =a_HSC_mat*2*(x37-x42);
xdot(43) =a_HSC_mat*2*(x42-x43);
xdot(44) =g_HSC*2*(x37-x44);
xdot(45) =g_HSC*2*(x44-x45);
xdot(46) =+2*b_HSC*2*x39-(b_HSC*2+a_HSC_MPP*2+a_HSC_mat*2+g_HSC*2)*x46;
xdot(47) =+b_HSC*2*(x46-x47);
xdot(48) =+b_HSC*2*(x47-x48);
xdot(49) =a_HSC_MPP*2*(x46-x49);
xdot(50) =a_HSC_MPP*2*(x49-x50);
xdot(51) =a_HSC_mat*2*(x46-x51);
xdot(52) =a_HSC_mat*2*(x51-x52);
xdot(53) =g_HSC*2*(x46-x53);
xdot(54) =g_HSC*2*(x53-x54);
xdot(55) =+2*b_HSC*2*x48+2*b_HSC*2*x57-(b_HSC*2+a_HSC_MPP*2+a_HSC_mat*2+g_HSC*2)*x55;
xdot(56) =+b_HSC*2*(x55-x56);
xdot(57) =+b_HSC*2*(x56-x57);
xdot(58) =a_HSC_MPP*2*(x55-x58);
xdot(59) =a_HSC_MPP*2*(x58-x59);
xdot(60) =a_HSC_mat*2*(x55-x60);
xdot(61) =a_HSC_mat*2*(x60-x61);
xdot(62) =g_HSC*2*(x55-x62);
xdot(63) =g_HSC*2*(x62-x63);

%MPP
xdot(64) =a_HSC_MPP*2*x5-(b_MPP*2+a_MPP_CMP*2+a_MPP_MLP*2+g_MPP*2)*x64;
xdot(65) =+b_MPP*2*(x64-x65);
xdot(66) =+b_MPP*2*(x65-x66);
xdot(67) =a_MPP_CMP*2*(x64-x67);
xdot(68) =a_MPP_CMP*2*(x67-x68);
xdot(69) =a_MPP_MLP*2*(x64-x69);
xdot(70) =a_MPP_MLP*2*(x69-x70);
xdot(71) =g_MPP*2*(x64-x71);
xdot(72) =g_MPP*2*(x71-x72);
xdot(73) =a_HSC_MPP*2*x14+2*b_MPP*2*x66-(b_MPP*2+a_MPP_CMP*2+a_MPP_MLP*2+g_MPP*2)*x73;
xdot(74) =+b_MPP*2*(x73-x74);
xdot(75) =+b_MPP*2*(x74-x75);
xdot(76) =a_MPP_CMP*2*(x73-x76);
xdot(77) =a_MPP_CMP*2*(x76-x77);
xdot(78) =a_MPP_MLP*2*(x73-x78);
xdot(79) =a_MPP_MLP*2*(x78-x79);
xdot(80) =g_MPP*2*(x73-x80);
xdot(81) =g_MPP*2*(x80-x81);
xdot(82) =a_HSC_MPP*2*x23+2*b_MPP*2*x75-(b_MPP*2+a_MPP_CMP*2+a_MPP_MLP*2+g_MPP*2)*x82;
xdot(83) =+b_MPP*2*(x82-x83);
xdot(84) =+b_MPP*2*(x83-x84);
xdot(85) =a_MPP_CMP*2*(x82-x85);
xdot(86) =a_MPP_CMP*2*(x85-x86);
xdot(87) =a_MPP_MLP*2*(x82-x87);
xdot(88) =a_MPP_MLP*2*(x87-x88);
xdot(89) =g_MPP*2*(x82-x89);
xdot(90) =g_MPP*2*(x89-x90);
xdot(91) =a_HSC_MPP*2*x32+2*b_MPP*2*x84-(b_MPP*2+a_MPP_CMP*2+a_MPP_MLP*2+g_MPP*2)*x91;
xdot(92) =+b_MPP*2*(x91-x92);
xdot(93) =+b_MPP*2*(x92-x93);
xdot(94) =a_MPP_CMP*2*(x91-x94);
xdot(95) =a_MPP_CMP*2*(x94-x95);
xdot(96) =a_MPP_MLP*2*(x91-x96);
xdot(97) =a_MPP_MLP*2*(x96-x97);
xdot(98) =g_MPP*2*(x91-x98);
xdot(99) =g_MPP*2*(x98-x99);
xdot(100) =a_HSC_MPP*2*x41+2*b_MPP*2*x93-(b_MPP*2+a_MPP_CMP*2+a_MPP_MLP*2+g_MPP*2)*x100;
xdot(101) =+b_MPP*2*(x100-x101);
xdot(102) =+b_MPP*2*(x101-x102);
xdot(103) =a_MPP_CMP*2*(x100-x103);
xdot(104) =a_MPP_CMP*2*(x103-x104);
xdot(105) =a_MPP_MLP*2*(x100-x105);
xdot(106) =a_MPP_MLP*2*(x105-x106);
xdot(107) =g_MPP*2*(x100-x107);
xdot(108) =g_MPP*2*(x107-x108);
xdot(109) =a_HSC_MPP*2*x50+2*b_MPP*2*x102-(b_MPP*2+a_MPP_CMP*2+a_MPP_MLP*2+g_MPP*2)*x109;
xdot(110) =+b_MPP*2*(x109-x110);
xdot(111) =+b_MPP*2*(x110-x111);
xdot(112) =a_MPP_CMP*2*(x109-x112);
xdot(113) =a_MPP_CMP*2*(x112-x113);
xdot(114) =a_MPP_MLP*2*(x109-x114);
xdot(115) =a_MPP_MLP*2*(x114-x115);
xdot(116) =g_MPP*2*(x109-x116);
xdot(117) =g_MPP*2*(x116-x117);
xdot(118) =a_HSC_MPP*2*x59+2*b_MPP*2*x111+2*b_MPP*2*x120-(b_MPP*2+a_MPP_CMP*2+a_MPP_MLP*2+g_MPP*2)*x118;
xdot(119) =+b_MPP*2*(x118-x119);
xdot(120) =+b_MPP*2*(x119-x120);
xdot(121) =a_MPP_CMP*2*(x118-x121);
xdot(122) =a_MPP_CMP*2*(x121-x122);
xdot(123) =a_MPP_MLP*2*(x118-x123);
xdot(124) =a_MPP_MLP*2*(x123-x124);
xdot(125) =g_MPP*2*(x118-x125);
xdot(126) =g_MPP*2*(x125-x126);

%MLP
xdot(127) =a_MPP_MLP*2*x70-(b_MLP*2+a_MLP*2)*x127;
xdot(128) =+b_MLP*2*(x127-x128);
xdot(129) =+b_MLP*2*(x128-x129);
xdot(130) =a_MLP*2*(x127-x130);
xdot(131) =a_MLP*2*(x130-x131);
xdot(132) =a_MPP_MLP*2*x79+2*b_MLP*2*x129-(b_MLP*2+a_MLP*2)*x132;
xdot(133) =+b_MLP*2*(x132-x133);
xdot(134) =+b_MLP*2*(x133-x134);
xdot(135) =a_MLP*2*(x132-x135);
xdot(136) =a_MLP*2*(x135-x136);
xdot(137) =a_MPP_MLP*2*x88+2*b_MLP*2*x134-(b_MLP*2+a_MLP*2)*x137;
xdot(138) =+b_MLP*2*(x137-x138);
xdot(139) =+b_MLP*2*(x138-x139);
xdot(140) =a_MLP*2*(x137-x140);
xdot(141) =a_MLP*2*(x140-x141);
xdot(142) =a_MPP_MLP*2*x97+2*b_MLP*2*x139-(b_MLP*2+a_MLP*2)*x142;
xdot(143) =+b_MLP*2*(x142-x143);
xdot(144) =+b_MLP*2*(x143-x144);
xdot(145) =a_MLP*2*(x142-x145);
xdot(146) =a_MLP*2*(x145-x146);
xdot(147) =a_MPP_MLP*2*x106+2*b_MLP*2*x144-(b_MLP*2+a_MLP*2)*x147;
xdot(148) =+b_MLP*2*(x147-x148);
xdot(149) =+b_MLP*2*(x148-x149);
xdot(150) =a_MLP*2*(x147-x150);
xdot(151) =a_MLP*2*(x150-x151);
xdot(152) =a_MPP_MLP*2*x115+2*b_MLP*2*x149-(b_MLP*2+a_MLP*2)*x152;
xdot(153) =+b_MLP*2*(x152-x153);
xdot(154) =+b_MLP*2*(x153-x154);
xdot(155) =a_MLP*2*(x152-x155);
xdot(156) =a_MLP*2*(x155-x156);
xdot(157) =a_MPP_MLP*2*x124+2*b_MLP*2*x154+2*b_MLP*2*x159-(b_MLP*2+a_MLP*2)*x157;
xdot(158) =+b_MLP*2*(x157-x158);
xdot(159) =+b_MLP*2*(x158-x159);
xdot(160) =a_MLP*2*(x157-x160);
xdot(161) =a_MLP*2*(x160-x161);

%CMP
xdot(162) =a_MPP_CMP*2*x68-(b_CMP*2+a_CMP_MEP*2+a_CMP_GMP*2+g_CMP*2)*x162;
xdot(163) =+b_CMP*2*(x162-x163);
xdot(164) =+b_CMP*2*(x163-x164);
xdot(165) =a_CMP_MEP*2*(x162-x165);
xdot(166) =a_CMP_MEP*2*(x165-x166);
xdot(167) =a_CMP_GMP*2*(x162-x167);
xdot(168) =a_CMP_GMP*2*(x167-x168);
xdot(169) =g_CMP*2*(x162-x169);
xdot(170) =g_CMP*2*(x169-x170);
xdot(171) =a_MPP_CMP*2*x77+2*b_CMP*2*x164-(b_CMP*2+a_CMP_MEP*2+a_CMP_GMP*2+g_CMP*2)*x171;
xdot(172) =+b_CMP*2*(x171-x172);
xdot(173) =+b_CMP*2*(x172-x173);
xdot(174) =a_CMP_MEP*2*(x171-x174);
xdot(175) =a_CMP_MEP*2*(x174-x175);
xdot(176) =a_CMP_GMP*2*(x171-x176);
xdot(177) =a_CMP_GMP*2*(x176-x177);
xdot(178) =g_CMP*2*(x171-x178);
xdot(179) =g_CMP*2*(x178-x179);
xdot(180) =a_MPP_CMP*2*x86+2*b_CMP*2*x173-(b_CMP*2+a_CMP_MEP*2+a_CMP_GMP*2+g_CMP*2)*x180;
xdot(181) =+b_CMP*2*(x180-x181);
xdot(182) =+b_CMP*2*(x181-x182);
xdot(183) =a_CMP_MEP*2*(x180-x183);
xdot(184) =a_CMP_MEP*2*(x183-x184);
xdot(185) =a_CMP_GMP*2*(x180-x185);
xdot(186) =a_CMP_GMP*2*(x185-x186);
xdot(187) =g_CMP*2*(x180-x187);
xdot(188) =g_CMP*2*(x187-x188);
xdot(189) =a_MPP_CMP*2*x95+2*b_CMP*2*x182-(b_CMP*2+a_CMP_MEP*2+a_CMP_GMP*2+g_CMP*2)*x189;
xdot(190) =+b_CMP*2*(x189-x190);
xdot(191) =+b_CMP*2*(x190-x191);
xdot(192) =a_CMP_MEP*2*(x189-x192);
xdot(193) =a_CMP_MEP*2*(x192-x193);
xdot(194) =a_CMP_GMP*2*(x189-x194);
xdot(195) =a_CMP_GMP*2*(x194-x195);
xdot(196) =g_CMP*2*(x189-x196);
xdot(197) =g_CMP*2*(x196-x197);
xdot(198) =a_MPP_CMP*2*x104+2*b_CMP*2*x191-(b_CMP*2+a_CMP_MEP*2+a_CMP_GMP*2+g_CMP*2)*x198;
xdot(199) =+b_CMP*2*(x198-x199);
xdot(200) =+b_CMP*2*(x199-x200);
xdot(201) =a_CMP_MEP*2*(x198-x201);
xdot(202) =a_CMP_MEP*2*(x201-x202);
xdot(203) =a_CMP_GMP*2*(x198-x203);
xdot(204) =a_CMP_GMP*2*(x203-x204);
xdot(205) =g_CMP*2*(x198-x205);
xdot(206) =g_CMP*2*(x205-x206);
xdot(207) =a_MPP_CMP*2*x113+2*b_CMP*2*x200-(b_CMP*2+a_CMP_MEP*2+a_CMP_GMP*2+g_CMP*2)*x207;
xdot(208) =+b_CMP*2*(x207-x208);
xdot(209) =+b_CMP*2*(x208-x209);
xdot(210) =a_CMP_MEP*2*(x207-x210);
xdot(211) =a_CMP_MEP*2*(x210-x211);
xdot(212) =a_CMP_GMP*2*(x207-x212);
xdot(213) =a_CMP_GMP*2*(x212-x213);
xdot(214) =g_CMP*2*(x207-x214);
xdot(215) =g_CMP*2*(x214-x215);
xdot(216) =a_MPP_CMP*2*x122+2*b_CMP*2*x209+2*b_CMP*2*x218-(b_CMP*2+a_CMP_MEP*2+a_CMP_GMP*2+g_CMP*2)*x216;
xdot(217) =+b_CMP*2*(x216-x217);
xdot(218) =+b_CMP*2*(x217-x218);
xdot(219) =a_CMP_MEP*2*(x216-x219);
xdot(220) =a_CMP_MEP*2*(x219-x220);
xdot(221) =a_CMP_GMP*2*(x216-x221);
xdot(222) =a_CMP_GMP*2*(x221-x222);
xdot(223) =g_CMP*2*(x216-x223);
xdot(224) =g_CMP*2*(x223-x224);

%GMP
xdot(225) =a_CMP_GMP*2*x168-(b_GMP*2+a_GMP_mat*2+g_GMP*2)*x225;
xdot(226) =+b_GMP*2*(x225-x226);
xdot(227) =+b_GMP*2*(x226-x227);
xdot(228) =a_GMP_mat*2*(x225-x228);
xdot(229) =a_GMP_mat*2*(x228-x229);
xdot(230) =g_GMP*2*(x225-x230);
xdot(231) =g_GMP*2*(x230-x231);
xdot(232) =a_CMP_GMP*2*x177+2*b_GMP*2*x227-(b_GMP*2+a_GMP_mat*2+g_GMP*2)*x232;
xdot(233) =+b_GMP*2*(x232-x233);
xdot(234) =+b_GMP*2*(x233-x234);
xdot(235) =a_GMP_mat*2*(x232-x235);
xdot(236) =a_GMP_mat*2*(x235-x236);
xdot(237) =g_GMP*2*(x232-x237);
xdot(238) =g_GMP*2*(x237-x238);
xdot(239) =a_CMP_GMP*2*x186+2*b_GMP*2*x234-(b_GMP*2+a_GMP_mat*2+g_GMP*2)*x239;
xdot(240) =+b_GMP*2*(x239-x240);
xdot(241) =+b_GMP*2*(x240-x241);
xdot(242) =a_GMP_mat*2*(x239-x242);
xdot(243) =a_GMP_mat*2*(x242-x243);
xdot(244) =g_GMP*2*(x239-x244);
xdot(245) =g_GMP*2*(x244-x245);
xdot(246) =a_CMP_GMP*2*x195+2*b_GMP*2*x241-(b_GMP*2+a_GMP_mat*2+g_GMP*2)*x246;
xdot(247) =+b_GMP*2*(x246-x247);
xdot(248) =+b_GMP*2*(x247-x248);
xdot(249) =a_GMP_mat*2*(x246-x249);
xdot(250) =a_GMP_mat*2*(x249-x250);
xdot(251) =g_GMP*2*(x246-x251);
xdot(252) =g_GMP*2*(x251-x252);
xdot(253) =a_CMP_GMP*2*x204+2*b_GMP*2*x248-(b_GMP*2+a_GMP_mat*2+g_GMP*2)*x253;
xdot(254) =+b_GMP*2*(x253-x254);
xdot(255) =+b_GMP*2*(x254-x255);
xdot(256) =a_GMP_mat*2*(x253-x256);
xdot(257) =a_GMP_mat*2*(x256-x257);
xdot(258) =g_GMP*2*(x253-x258);
xdot(259) =g_GMP*2*(x258-x259);
xdot(260) =a_CMP_GMP*2*x213+2*b_GMP*2*x255-(b_GMP*2+a_GMP_mat*2+g_GMP*2)*x260;
xdot(261) =+b_GMP*2*(x260-x261);
xdot(262) =+b_GMP*2*(x261-x262);
xdot(263) =a_GMP_mat*2*(x260-x263);
xdot(264) =a_GMP_mat*2*(x263-x264);
xdot(265) =g_GMP*2*(x260-x265);
xdot(266) =g_GMP*2*(x265-x266);
xdot(267) =a_CMP_GMP*2*x222+2*b_GMP*2*x262+2*b_GMP*2*x269-(b_GMP*2+a_GMP_mat*2+g_GMP*2)*x267;
xdot(268) =+b_GMP*2*(x267-x268);
xdot(269) =+b_GMP*2*(x268-x269);
xdot(270) =a_GMP_mat*2*(x267-x270);
xdot(271) =a_GMP_mat*2*(x270-x271);
xdot(272) =g_GMP*2*(x267-x272);
xdot(273) =g_GMP*2*(x272-x273);

%MEP
xdot(274) =a_CMP_MEP*2*x166-(b_MEP*2+a_MEP_mat*2+g_MEP*2)*x274;
xdot(275) =+b_MEP*2*(x274-x275);
xdot(276) =+b_MEP*2*(x275-x276);
xdot(277) =a_MEP_mat*2*(x274-x277);
xdot(278) =a_MEP_mat*2*(x277-x278);
xdot(279) =g_MEP*2*(x274-x279);
xdot(280) =g_MEP*2*(x279-x280);
xdot(281) =a_CMP_MEP*2*x175+2*b_MEP*2*x276-(b_MEP*2+a_MEP_mat*2+g_MEP*2)*x281;
xdot(282) =+b_MEP*2*(x281-x282);
xdot(283) =+b_MEP*2*(x282-x283);
xdot(284) =a_MEP_mat*2*(x281-x284);
xdot(285) =a_MEP_mat*2*(x284-x285);
xdot(286) =g_MEP*2*(x281-x286);
xdot(287) =g_MEP*2*(x286-x287);
xdot(288) =a_CMP_MEP*2*x184+2*b_MEP*2*x283-(b_MEP*2+a_MEP_mat*2+g_MEP*2)*x288;
xdot(289) =+b_MEP*2*(x288-x289);
xdot(290) =+b_MEP*2*(x289-x290);
xdot(291) =a_MEP_mat*2*(x288-x291);
xdot(292) =a_MEP_mat*2*(x291-x292);
xdot(293) =g_MEP*2*(x288-x293);
xdot(294) =g_MEP*2*(x293-x294);
xdot(295) =a_CMP_MEP*2*x193+2*b_MEP*2*x290-(b_MEP*2+a_MEP_mat*2+g_MEP*2)*x295;
xdot(296) =+b_MEP*2*(x295-x296);
xdot(297) =+b_MEP*2*(x296-x297);
xdot(298) =a_MEP_mat*2*(x295-x298);
xdot(299) =a_MEP_mat*2*(x298-x299);
xdot(300) =g_MEP*2*(x295-x300);
xdot(301) =g_MEP*2*(x300-x301);
xdot(302) =a_CMP_MEP*2*x202+2*b_MEP*2*x297-(b_MEP*2+a_MEP_mat*2+g_MEP*2)*x302;
xdot(303) =+b_MEP*2*(x302-x303);
xdot(304) =+b_MEP*2*(x303-x304);
xdot(305) =a_MEP_mat*2*(x302-x305);
xdot(306) =a_MEP_mat*2*(x305-x306);
xdot(307) =g_MEP*2*(x302-x307);
xdot(308) =g_MEP*2*(x307-x308);
xdot(309) =a_CMP_MEP*2*x211+2*b_MEP*2*x304-(b_MEP*2+a_MEP_mat*2+g_MEP*2)*x309;
xdot(310) =+b_MEP*2*(x309-x310);
xdot(311) =+b_MEP*2*(x310-x311);
xdot(312) =a_MEP_mat*2*(x309-x312);
xdot(313) =a_MEP_mat*2*(x312-x313);
xdot(314) =g_MEP*2*(x309-x314);
xdot(315) =g_MEP*2*(x314-x315);
xdot(316) =a_CMP_MEP*2*x220+2*b_MEP*2*x311+2*b_MEP*2*x318-(b_MEP*2+a_MEP_mat*2+g_MEP*2)*x316;
xdot(317) =+b_MEP*2*(x316-x317);
xdot(318) =+b_MEP*2*(x317-x318);
xdot(319) =a_MEP_mat*2*(x316-x319);
xdot(320) =a_MEP_mat*2*(x319-x320);
xdot(321) =g_MEP*2*(x316-x321);
xdot(322) =g_MEP*2*(x321-x322);

%mat
xdot(323) =a_HSC_mat*2*x7+a_MEP_mat*2*x278+a_GMP_mat*2*x229-(b_mat*2+g_mat*2)*x323;
xdot(324) =+b_mat*2*(x323-x324);
xdot(325) =+b_mat*2*(x324-x325);
xdot(326) =g_mat*2*(x323-x326);
xdot(327) =g_mat*2*(x326-x327);
xdot(328) =a_HSC_mat*2*x16+a_MEP_mat*2*x285+a_GMP_mat*2*x236+2*b_mat*2*x325-(b_mat*2+g_mat*2)*x328;
xdot(329) =+b_mat*2*(x328-x329);
xdot(330) =+b_mat*2*(x329-x330);
xdot(331) =g_mat*2*(x328-x331);
xdot(332) =g_mat*2*(x331-x332);
xdot(333) =a_HSC_mat*2*x25+a_MEP_mat*2*x292+a_GMP_mat*2*x243+2*b_mat*2*x330-(b_mat*2+g_mat*2)*x333;
xdot(334) =+b_mat*2*(x333-x334);
xdot(335) =+b_mat*2*(x334-x335);
xdot(336) =g_mat*2*(x333-x336);
xdot(337) =g_mat*2*(x336-x337);
xdot(338) =a_HSC_mat*2*x34+a_MEP_mat*2*x299+a_GMP_mat*2*x250+2*b_mat*2*x335-(b_mat*2+g_mat*2)*x338;
xdot(339) =+b_mat*2*(x338-x339);
xdot(340) =+b_mat*2*(x339-x340);
xdot(341) =g_mat*2*(x338-x341);
xdot(342) =g_mat*2*(x341-x342);
xdot(343) =a_HSC_mat*2*x43+a_MEP_mat*2*x306+a_GMP_mat*2*x257+2*b_mat*2*x340-(b_mat*2+g_mat*2)*x343;
xdot(344) =+b_mat*2*(x343-x344);
xdot(345) =+b_mat*2*(x344-x345);
xdot(346) =g_mat*2*(x343-x346);
xdot(347) =g_mat*2*(x346-x347);
xdot(348) =a_HSC_mat*2*x52+a_MEP_mat*2*x313+a_GMP_mat*2*x264+2*b_mat*2*x345-(b_mat*2+g_mat*2)*x348;
xdot(349) =+b_mat*2*(x348-x349);
xdot(350) =+b_mat*2*(x349-x350);
xdot(351) =g_mat*2*(x348-x351);
xdot(352) =g_mat*2*(x351-x352);
xdot(353) =a_HSC_mat*2*x61+a_MEP_mat*2*x320+a_GMP_mat*2*x271+2*b_mat*2*x350+2*b_mat*2*x355-(b_mat*2+g_mat*2)*x353;
xdot(354) =+b_mat*2*(x353-x354);
xdot(355) =+b_mat*2*(x354-x355);
xdot(356) =g_mat*2*(x353-x356);
xdot(357) =g_mat*2*(x356-x357);

%D



% INITIAL CONDITIONS
x0 = sym(zeros(size(x)));
x0([1,64,127,162,225,274,323])=exp(p(1:7))-1;

% OBSERVABLES
y= sym(zeros(49,1));
for i=1:7
y(0+i) = log(sum(x((i-1)*9+1:i*9+1-1))+1);
end
for i=1:7
y(7+i) = log(sum(x((i-1)*9+64:i*9+64-1))+1);
end
for i=1:7
y(14+i) = log(sum(x((i-1)*5+127:i*5+127-1))+1);
end
for i=1:7
y(21+i) = log(sum(x((i-1)*9+162:i*9+162-1))+1);
end
for i=1:7
y(28+i) = log(sum(x((i-1)*7+225:i*7+225-1))+1);
end
for i=1:7
y(35+i) = log(sum(x((i-1)*7+274:i*7+274-1))+1);
end
for i=1:7
y(42+i) = log(sum(x((i-1)*5+323:i*5+323-1))+1);
end


% SYSTEM STRUCT
model.sym.x = x;
model.sym.k = k;
model.sym.xdot = xdot;
model.sym.p = p;
model.sym.x0 = x0;
model.sym.y = y;
model.sym.sigma_y = 0;















































































































































































































































































































































































































































































