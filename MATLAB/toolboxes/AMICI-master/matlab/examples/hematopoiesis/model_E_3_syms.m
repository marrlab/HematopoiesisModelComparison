function [model] = model_E_3_syms()
% set the parametrisation of the problem options are 'log', 'log10' and
% 'lin' (default).
% model.param = 'log10';

%%
% STATES

% create state syms
syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20 x21 x22 x23 x24 x25 x26 x27 x28 x29 x30 x31 x32 x33 x34 x35 x36 x37 x38 x39 x40 x41 x42 x43 x44 x45 x46 x47 x48 x49 x50 x51 x52 x53 x54 x55 x56 x57 x58 x59 x60 x61 x62 x63 x64 x65 x66 x67 x68 x69 x70 x71 x72 x73 x74 x75 x76 x77 x78 x79 x80 x81 x82 x83 x84 x85 x86 x87 x88 x89 x90 x91 x92 x93 x94 x95 x96 x97 x98 x99 x100 x101 x102 x103 x104 x105 x106 x107 x108 x109 x110 x111 x112 x113 x114 x115 x116 x117 x118 x119 x120 x121 x122 x123 x124 x125 x126 x127 x128 x129 x130 x131 x132 x133 x134 x135 x136 x137 x138 x139 x140 x141 x142 x143 x144 x145 x146 x147 x148 x149 x150 x151 x152 x153 x154 x155 x156 x157 x158 x159 x160 x161 x162 x163 x164 x165 x166 x167 x168 x169 x170 x171 x172 x173 x174 x175 x176 x177 x178 x179 x180 x181 x182 x183 x184 x185 x186 x187 x188 x189 x190 x191 x192 x193 x194 x195 x196 x197 x198 x199 x200 x201 x202 x203 x204 x205 x206 x207 x208 x209 x210 x211 x212 x213 x214 x215 x216 x217 x218 x219 x220 x221 x222 x223 x224 x225 x226 x227 x228 x229 x230 x231 x232 x233 x234 x235 x236 x237 x238 x239 x240 x241 x242 x243 x244 x245 x246 x247 x248 x249 x250 x251 x252 x253 x254 x255 x256 x257 x258 x259 x260 x261 x262 x263 x264 x265 x266 x267 x268 x269 x270 x271 x272 x273 x274 x275 x276 x277 x278 x279 x280 x281 x282 x283 x284 x285 x286 x287 x288 x289 x290 x291 x292 x293 x294 x295 x296 x297 x298 x299 x300 x301 x302 x303 x304 x305 x306 x307 x308 x309 x310 x311 x312 x313 x314 x315 x316 x317 x318 x319 x320 x321 x322 x323 x324 x325 x326 x327 x328 x329 x330 x331 x332 x333 x334 x335 x336 x337 x338 x339 x340 x341 x342 x343 x344 x345 x346 x347 x348 x349 x350 x351 x352 x353 x354 x355 x356 x357 x358 x359 x360 x361 x362 x363 x364 x365 x366 x367 x368 x369 x370 x371 x372 x373 x374 x375 x376 x377 x378 x379 x380 x381 x382 x383 x384 x385 x386 x387 x388 x389 x390 x391 x392 x393 x394 x395 x396 x397 x398 x399 x400 x401 x402 x403 x404 x405 x406 x407 x408 x409 x410 x411 x412 x413 x414 x415 x416 x417 x418 x419 x420 x421 x422 x423 x424 x425 x426 x427 x428 x429 x430 x431 x432 x433 x434 x435 x436 x437 x438 x439 x440 x441 x442 x443 x444 x445 x446 x447 x448 x449 x450 x451 x452 x453 x454 x455 x456 x457 x458 x459 x460 x461 x462 x463 x464 x465 x466 x467 x468 x469 x470 x471 x472 x473 x474 x475 x476 x477 x478 x479 x480 x481 x482 x483 x484 x485 x486 x487 x488 x489 x490 x491 x492 x493 x494 x495 x496 x497 x498 x499 x500 x501 x502 x503 x504 x505 x506 x507 x508 x509 x510 x511 x512 x513 x514 x515 x516 x517 x518 x519 x520 x521 x522 x523 x524 x525 x526 x527 x528 x529 x530 x531 x532 x533 x534 x535 x536 x537 x538 x539 x540 x541 x542 x543 x544 x545 x546 x547 x548 x549 x550 x551 x552 x553

% create state vector
x = [
 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20 x21 x22 x23 x24 x25 x26 x27 x28 x29 x30 x31 x32 x33 x34 x35 x36 x37 x38 x39 x40 x41 x42 x43 x44 x45 x46 x47 x48 x49 x50 x51 x52 x53 x54 x55 x56 x57 x58 x59 x60 x61 x62 x63 x64 x65 x66 x67 x68 x69 x70 x71 x72 x73 x74 x75 x76 x77 x78 x79 x80 x81 x82 x83 x84 x85 x86 x87 x88 x89 x90 x91 x92 x93 x94 x95 x96 x97 x98 x99 x100 x101 x102 x103 x104 x105 x106 x107 x108 x109 x110 x111 x112 x113 x114 x115 x116 x117 x118 x119 x120 x121 x122 x123 x124 x125 x126 x127 x128 x129 x130 x131 x132 x133 x134 x135 x136 x137 x138 x139 x140 x141 x142 x143 x144 x145 x146 x147 x148 x149 x150 x151 x152 x153 x154 x155 x156 x157 x158 x159 x160 x161 x162 x163 x164 x165 x166 x167 x168 x169 x170 x171 x172 x173 x174 x175 x176 x177 x178 x179 x180 x181 x182 x183 x184 x185 x186 x187 x188 x189 x190 x191 x192 x193 x194 x195 x196 x197 x198 x199 x200 x201 x202 x203 x204 x205 x206 x207 x208 x209 x210 x211 x212 x213 x214 x215 x216 x217 x218 x219 x220 x221 x222 x223 x224 x225 x226 x227 x228 x229 x230 x231 x232 x233 x234 x235 x236 x237 x238 x239 x240 x241 x242 x243 x244 x245 x246 x247 x248 x249 x250 x251 x252 x253 x254 x255 x256 x257 x258 x259 x260 x261 x262 x263 x264 x265 x266 x267 x268 x269 x270 x271 x272 x273 x274 x275 x276 x277 x278 x279 x280 x281 x282 x283 x284 x285 x286 x287 x288 x289 x290 x291 x292 x293 x294 x295 x296 x297 x298 x299 x300 x301 x302 x303 x304 x305 x306 x307 x308 x309 x310 x311 x312 x313 x314 x315 x316 x317 x318 x319 x320 x321 x322 x323 x324 x325 x326 x327 x328 x329 x330 x331 x332 x333 x334 x335 x336 x337 x338 x339 x340 x341 x342 x343 x344 x345 x346 x347 x348 x349 x350 x351 x352 x353 x354 x355 x356 x357 x358 x359 x360 x361 x362 x363 x364 x365 x366 x367 x368 x369 x370 x371 x372 x373 x374 x375 x376 x377 x378 x379 x380 x381 x382 x383 x384 x385 x386 x387 x388 x389 x390 x391 x392 x393 x394 x395 x396 x397 x398 x399 x400 x401 x402 x403 x404 x405 x406 x407 x408 x409 x410 x411 x412 x413 x414 x415 x416 x417 x418 x419 x420 x421 x422 x423 x424 x425 x426 x427 x428 x429 x430 x431 x432 x433 x434 x435 x436 x437 x438 x439 x440 x441 x442 x443 x444 x445 x446 x447 x448 x449 x450 x451 x452 x453 x454 x455 x456 x457 x458 x459 x460 x461 x462 x463 x464 x465 x466 x467 x468 x469 x470 x471 x472 x473 x474 x475 x476 x477 x478 x479 x480 x481 x482 x483 x484 x485 x486 x487 x488 x489 x490 x491 x492 x493 x494 x495 x496 x497 x498 x499 x500 x501 x502 x503 x504 x505 x506 x507 x508 x509 x510 x511 x512 x513 x514 x515 x516 x517 x518 x519 x520 x521 x522 x523 x524 x525 x526 x527 x528 x529 x530 x531 x532 x533 x534 x535 x536 x537 x538 x539 x540 x541 x542 x543 x544 x545 x546 x547 x548 x549 x550 x551 x552 x553
];

%%
% PARAMETERS ( for these sensitivities will be computed )

% create parameter syms
syms x0_1 x0_2 x0_3 x0_4 x0_5 x0_6 x0_7 a_HSC_MPP a_HSC_MEP b_HSC g_HSC a_MPP_CMP a_MPP_MLP a_MPP_MEP b_MPP g_MPP a_CMP_MEP a_CMP_GMP b_CMP g_CMP a_MLP a_MLP_GMP b_MLP a_MEP_mat b_MEP g_MEP a_GMP_mat b_GMP g_GMP b_mat g_mat

% create parameter vector 
p= [x0_1 x0_2 x0_3 x0_4 x0_5 x0_6 x0_7 a_HSC_MPP a_HSC_MEP b_HSC g_HSC a_MPP_CMP a_MPP_MLP a_MPP_MEP b_MPP g_MPP a_CMP_MEP a_CMP_GMP b_CMP g_CMP a_MLP a_MLP_GMP b_MLP a_MEP_mat b_MEP g_MEP a_GMP_mat b_GMP g_GMP b_mat g_mat];

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
xdot(1) =-(b_HSC*3+a_HSC_MPP*3+a_HSC_MEP*3+g_HSC*3)*x1;
xdot(2) =+b_HSC*3*(x1-x2);
xdot(3) =+b_HSC*3*(x2-x3);
xdot(4) =+b_HSC*3*(x3-x4);
xdot(5) =a_HSC_MPP*3*(x1-x5);
xdot(6) =a_HSC_MPP*3*(x5-x6);
xdot(7) =a_HSC_MPP*3*(x6-x7);
xdot(8) =a_HSC_MEP*3*(x1-x8);
xdot(9) =a_HSC_MEP*3*(x8-x9);
xdot(10) =a_HSC_MEP*3*(x9-x10);
xdot(11) =g_HSC*3*(x1-x11);
xdot(12) =g_HSC*3*(x11-x12);
xdot(13) =g_HSC*3*(x12-x13);
xdot(14) =+2*b_HSC*3*x4-(b_HSC*3+a_HSC_MPP*3+a_HSC_MEP*3+g_HSC*3)*x14;
xdot(15) =+b_HSC*3*(x14-x15);
xdot(16) =+b_HSC*3*(x15-x16);
xdot(17) =+b_HSC*3*(x16-x17);
xdot(18) =a_HSC_MPP*3*(x14-x18);
xdot(19) =a_HSC_MPP*3*(x18-x19);
xdot(20) =a_HSC_MPP*3*(x19-x20);
xdot(21) =a_HSC_MEP*3*(x14-x21);
xdot(22) =a_HSC_MEP*3*(x21-x22);
xdot(23) =a_HSC_MEP*3*(x22-x23);
xdot(24) =g_HSC*3*(x14-x24);
xdot(25) =g_HSC*3*(x24-x25);
xdot(26) =g_HSC*3*(x25-x26);
xdot(27) =+2*b_HSC*3*x17-(b_HSC*3+a_HSC_MPP*3+a_HSC_MEP*3+g_HSC*3)*x27;
xdot(28) =+b_HSC*3*(x27-x28);
xdot(29) =+b_HSC*3*(x28-x29);
xdot(30) =+b_HSC*3*(x29-x30);
xdot(31) =a_HSC_MPP*3*(x27-x31);
xdot(32) =a_HSC_MPP*3*(x31-x32);
xdot(33) =a_HSC_MPP*3*(x32-x33);
xdot(34) =a_HSC_MEP*3*(x27-x34);
xdot(35) =a_HSC_MEP*3*(x34-x35);
xdot(36) =a_HSC_MEP*3*(x35-x36);
xdot(37) =g_HSC*3*(x27-x37);
xdot(38) =g_HSC*3*(x37-x38);
xdot(39) =g_HSC*3*(x38-x39);
xdot(40) =+2*b_HSC*3*x30-(b_HSC*3+a_HSC_MPP*3+a_HSC_MEP*3+g_HSC*3)*x40;
xdot(41) =+b_HSC*3*(x40-x41);
xdot(42) =+b_HSC*3*(x41-x42);
xdot(43) =+b_HSC*3*(x42-x43);
xdot(44) =a_HSC_MPP*3*(x40-x44);
xdot(45) =a_HSC_MPP*3*(x44-x45);
xdot(46) =a_HSC_MPP*3*(x45-x46);
xdot(47) =a_HSC_MEP*3*(x40-x47);
xdot(48) =a_HSC_MEP*3*(x47-x48);
xdot(49) =a_HSC_MEP*3*(x48-x49);
xdot(50) =g_HSC*3*(x40-x50);
xdot(51) =g_HSC*3*(x50-x51);
xdot(52) =g_HSC*3*(x51-x52);
xdot(53) =+2*b_HSC*3*x43-(b_HSC*3+a_HSC_MPP*3+a_HSC_MEP*3+g_HSC*3)*x53;
xdot(54) =+b_HSC*3*(x53-x54);
xdot(55) =+b_HSC*3*(x54-x55);
xdot(56) =+b_HSC*3*(x55-x56);
xdot(57) =a_HSC_MPP*3*(x53-x57);
xdot(58) =a_HSC_MPP*3*(x57-x58);
xdot(59) =a_HSC_MPP*3*(x58-x59);
xdot(60) =a_HSC_MEP*3*(x53-x60);
xdot(61) =a_HSC_MEP*3*(x60-x61);
xdot(62) =a_HSC_MEP*3*(x61-x62);
xdot(63) =g_HSC*3*(x53-x63);
xdot(64) =g_HSC*3*(x63-x64);
xdot(65) =g_HSC*3*(x64-x65);
xdot(66) =+2*b_HSC*3*x56-(b_HSC*3+a_HSC_MPP*3+a_HSC_MEP*3+g_HSC*3)*x66;
xdot(67) =+b_HSC*3*(x66-x67);
xdot(68) =+b_HSC*3*(x67-x68);
xdot(69) =+b_HSC*3*(x68-x69);
xdot(70) =a_HSC_MPP*3*(x66-x70);
xdot(71) =a_HSC_MPP*3*(x70-x71);
xdot(72) =a_HSC_MPP*3*(x71-x72);
xdot(73) =a_HSC_MEP*3*(x66-x73);
xdot(74) =a_HSC_MEP*3*(x73-x74);
xdot(75) =a_HSC_MEP*3*(x74-x75);
xdot(76) =g_HSC*3*(x66-x76);
xdot(77) =g_HSC*3*(x76-x77);
xdot(78) =g_HSC*3*(x77-x78);
xdot(79) =+2*b_HSC*3*x69+2*b_HSC*3*x82-(b_HSC*3+a_HSC_MPP*3+a_HSC_MEP*3+g_HSC*3)*x79;
xdot(80) =+b_HSC*3*(x79-x80);
xdot(81) =+b_HSC*3*(x80-x81);
xdot(82) =+b_HSC*3*(x81-x82);
xdot(83) =a_HSC_MPP*3*(x79-x83);
xdot(84) =a_HSC_MPP*3*(x83-x84);
xdot(85) =a_HSC_MPP*3*(x84-x85);
xdot(86) =a_HSC_MEP*3*(x79-x86);
xdot(87) =a_HSC_MEP*3*(x86-x87);
xdot(88) =a_HSC_MEP*3*(x87-x88);
xdot(89) =g_HSC*3*(x79-x89);
xdot(90) =g_HSC*3*(x89-x90);
xdot(91) =g_HSC*3*(x90-x91);

%MPP
xdot(92) =a_HSC_MPP*3*x7-(b_MPP*3++a_MPP_CMP*3+a_MPP_MLP*3+a_MPP_MEP*3+g_MPP*3)*x92;
xdot(93) =+b_MPP*3*(x92-x93);
xdot(94) =+b_MPP*3*(x93-x94);
xdot(95) =+b_MPP*3*(x94-x95);
xdot(96) =a_MPP_CMP*3*(x92-x96);
xdot(97) =a_MPP_CMP*3*(x96-x97);
xdot(98) =a_MPP_CMP*3*(x97-x98);
xdot(99) =a_MPP_MLP*3*(x92-x99);
xdot(100) =a_MPP_MLP*3*(x99-x100);
xdot(101) =a_MPP_MLP*3*(x100-x101);
xdot(102) =a_MPP_MEP*3*(x92-x102);
xdot(103) =a_MPP_MEP*3*(x102-x103);
xdot(104) =a_MPP_MEP*3*(x103-x104);
xdot(105) =g_MPP*3*(x92-x105);
xdot(106) =g_MPP*3*(x105-x106);
xdot(107) =g_MPP*3*(x106-x107);
xdot(108) =a_HSC_MPP*3*x20+2*b_MPP*3*x95-(b_MPP*3++a_MPP_CMP*3+a_MPP_MLP*3+a_MPP_MEP*3+g_MPP*3)*x108;
xdot(109) =+b_MPP*3*(x108-x109);
xdot(110) =+b_MPP*3*(x109-x110);
xdot(111) =+b_MPP*3*(x110-x111);
xdot(112) =a_MPP_CMP*3*(x108-x112);
xdot(113) =a_MPP_CMP*3*(x112-x113);
xdot(114) =a_MPP_CMP*3*(x113-x114);
xdot(115) =a_MPP_MLP*3*(x108-x115);
xdot(116) =a_MPP_MLP*3*(x115-x116);
xdot(117) =a_MPP_MLP*3*(x116-x117);
xdot(118) =a_MPP_MEP*3*(x108-x118);
xdot(119) =a_MPP_MEP*3*(x118-x119);
xdot(120) =a_MPP_MEP*3*(x119-x120);
xdot(121) =g_MPP*3*(x108-x121);
xdot(122) =g_MPP*3*(x121-x122);
xdot(123) =g_MPP*3*(x122-x123);
xdot(124) =a_HSC_MPP*3*x33+2*b_MPP*3*x111-(b_MPP*3++a_MPP_CMP*3+a_MPP_MLP*3+a_MPP_MEP*3+g_MPP*3)*x124;
xdot(125) =+b_MPP*3*(x124-x125);
xdot(126) =+b_MPP*3*(x125-x126);
xdot(127) =+b_MPP*3*(x126-x127);
xdot(128) =a_MPP_CMP*3*(x124-x128);
xdot(129) =a_MPP_CMP*3*(x128-x129);
xdot(130) =a_MPP_CMP*3*(x129-x130);
xdot(131) =a_MPP_MLP*3*(x124-x131);
xdot(132) =a_MPP_MLP*3*(x131-x132);
xdot(133) =a_MPP_MLP*3*(x132-x133);
xdot(134) =a_MPP_MEP*3*(x124-x134);
xdot(135) =a_MPP_MEP*3*(x134-x135);
xdot(136) =a_MPP_MEP*3*(x135-x136);
xdot(137) =g_MPP*3*(x124-x137);
xdot(138) =g_MPP*3*(x137-x138);
xdot(139) =g_MPP*3*(x138-x139);
xdot(140) =a_HSC_MPP*3*x46+2*b_MPP*3*x127-(b_MPP*3++a_MPP_CMP*3+a_MPP_MLP*3+a_MPP_MEP*3+g_MPP*3)*x140;
xdot(141) =+b_MPP*3*(x140-x141);
xdot(142) =+b_MPP*3*(x141-x142);
xdot(143) =+b_MPP*3*(x142-x143);
xdot(144) =a_MPP_CMP*3*(x140-x144);
xdot(145) =a_MPP_CMP*3*(x144-x145);
xdot(146) =a_MPP_CMP*3*(x145-x146);
xdot(147) =a_MPP_MLP*3*(x140-x147);
xdot(148) =a_MPP_MLP*3*(x147-x148);
xdot(149) =a_MPP_MLP*3*(x148-x149);
xdot(150) =a_MPP_MEP*3*(x140-x150);
xdot(151) =a_MPP_MEP*3*(x150-x151);
xdot(152) =a_MPP_MEP*3*(x151-x152);
xdot(153) =g_MPP*3*(x140-x153);
xdot(154) =g_MPP*3*(x153-x154);
xdot(155) =g_MPP*3*(x154-x155);
xdot(156) =a_HSC_MPP*3*x59+2*b_MPP*3*x143-(b_MPP*3++a_MPP_CMP*3+a_MPP_MLP*3+a_MPP_MEP*3+g_MPP*3)*x156;
xdot(157) =+b_MPP*3*(x156-x157);
xdot(158) =+b_MPP*3*(x157-x158);
xdot(159) =+b_MPP*3*(x158-x159);
xdot(160) =a_MPP_CMP*3*(x156-x160);
xdot(161) =a_MPP_CMP*3*(x160-x161);
xdot(162) =a_MPP_CMP*3*(x161-x162);
xdot(163) =a_MPP_MLP*3*(x156-x163);
xdot(164) =a_MPP_MLP*3*(x163-x164);
xdot(165) =a_MPP_MLP*3*(x164-x165);
xdot(166) =a_MPP_MEP*3*(x156-x166);
xdot(167) =a_MPP_MEP*3*(x166-x167);
xdot(168) =a_MPP_MEP*3*(x167-x168);
xdot(169) =g_MPP*3*(x156-x169);
xdot(170) =g_MPP*3*(x169-x170);
xdot(171) =g_MPP*3*(x170-x171);
xdot(172) =a_HSC_MPP*3*x72+2*b_MPP*3*x159-(b_MPP*3++a_MPP_CMP*3+a_MPP_MLP*3+a_MPP_MEP*3+g_MPP*3)*x172;
xdot(173) =+b_MPP*3*(x172-x173);
xdot(174) =+b_MPP*3*(x173-x174);
xdot(175) =+b_MPP*3*(x174-x175);
xdot(176) =a_MPP_CMP*3*(x172-x176);
xdot(177) =a_MPP_CMP*3*(x176-x177);
xdot(178) =a_MPP_CMP*3*(x177-x178);
xdot(179) =a_MPP_MLP*3*(x172-x179);
xdot(180) =a_MPP_MLP*3*(x179-x180);
xdot(181) =a_MPP_MLP*3*(x180-x181);
xdot(182) =a_MPP_MEP*3*(x172-x182);
xdot(183) =a_MPP_MEP*3*(x182-x183);
xdot(184) =a_MPP_MEP*3*(x183-x184);
xdot(185) =g_MPP*3*(x172-x185);
xdot(186) =g_MPP*3*(x185-x186);
xdot(187) =g_MPP*3*(x186-x187);
xdot(188) =a_HSC_MPP*3*x85+2*b_MPP*3*x175+2*b_MPP*3*x191-(b_MPP*3++a_MPP_CMP*3+a_MPP_MLP*3+a_MPP_MEP*3+g_MPP*3)*x188;
xdot(189) =+b_MPP*3*(x188-x189);
xdot(190) =+b_MPP*3*(x189-x190);
xdot(191) =+b_MPP*3*(x190-x191);
xdot(192) =a_MPP_CMP*3*(x188-x192);
xdot(193) =a_MPP_CMP*3*(x192-x193);
xdot(194) =a_MPP_CMP*3*(x193-x194);
xdot(195) =a_MPP_MLP*3*(x188-x195);
xdot(196) =a_MPP_MLP*3*(x195-x196);
xdot(197) =a_MPP_MLP*3*(x196-x197);
xdot(198) =a_MPP_MEP*3*(x188-x198);
xdot(199) =a_MPP_MEP*3*(x198-x199);
xdot(200) =a_MPP_MEP*3*(x199-x200);
xdot(201) =g_MPP*3*(x188-x201);
xdot(202) =g_MPP*3*(x201-x202);
xdot(203) =g_MPP*3*(x202-x203);

%MLP
xdot(204) =a_MPP_MLP*3*x101-(b_MLP*3+a_MLP*3+a_MLP_GMP*3)*x204;
xdot(205) =+b_MLP*3*(x204-x205);
xdot(206) =+b_MLP*3*(x205-x206);
xdot(207) =+b_MLP*3*(x206-x207);
xdot(208) =a_MLP*3*(x204-x208);
xdot(209) =a_MLP*3*(x208-x209);
xdot(210) =a_MLP*3*(x209-x210);
xdot(211) =a_MLP_GMP*3*(x204-x211);
xdot(212) =a_MLP_GMP*3*(x211-x212);
xdot(213) =a_MLP_GMP*3*(x212-x213);
xdot(214) =a_MPP_MLP*3*x117+2*b_MLP*3*x207-(b_MLP*3+a_MLP*3+a_MLP_GMP*3)*x214;
xdot(215) =+b_MLP*3*(x214-x215);
xdot(216) =+b_MLP*3*(x215-x216);
xdot(217) =+b_MLP*3*(x216-x217);
xdot(218) =a_MLP*3*(x214-x218);
xdot(219) =a_MLP*3*(x218-x219);
xdot(220) =a_MLP*3*(x219-x220);
xdot(221) =a_MLP_GMP*3*(x214-x221);
xdot(222) =a_MLP_GMP*3*(x221-x222);
xdot(223) =a_MLP_GMP*3*(x222-x223);
xdot(224) =a_MPP_MLP*3*x133+2*b_MLP*3*x217-(b_MLP*3+a_MLP*3+a_MLP_GMP*3)*x224;
xdot(225) =+b_MLP*3*(x224-x225);
xdot(226) =+b_MLP*3*(x225-x226);
xdot(227) =+b_MLP*3*(x226-x227);
xdot(228) =a_MLP*3*(x224-x228);
xdot(229) =a_MLP*3*(x228-x229);
xdot(230) =a_MLP*3*(x229-x230);
xdot(231) =a_MLP_GMP*3*(x224-x231);
xdot(232) =a_MLP_GMP*3*(x231-x232);
xdot(233) =a_MLP_GMP*3*(x232-x233);
xdot(234) =a_MPP_MLP*3*x149+2*b_MLP*3*x227-(b_MLP*3+a_MLP*3+a_MLP_GMP*3)*x234;
xdot(235) =+b_MLP*3*(x234-x235);
xdot(236) =+b_MLP*3*(x235-x236);
xdot(237) =+b_MLP*3*(x236-x237);
xdot(238) =a_MLP*3*(x234-x238);
xdot(239) =a_MLP*3*(x238-x239);
xdot(240) =a_MLP*3*(x239-x240);
xdot(241) =a_MLP_GMP*3*(x234-x241);
xdot(242) =a_MLP_GMP*3*(x241-x242);
xdot(243) =a_MLP_GMP*3*(x242-x243);
xdot(244) =a_MPP_MLP*3*x165+2*b_MLP*3*x237-(b_MLP*3+a_MLP*3+a_MLP_GMP*3)*x244;
xdot(245) =+b_MLP*3*(x244-x245);
xdot(246) =+b_MLP*3*(x245-x246);
xdot(247) =+b_MLP*3*(x246-x247);
xdot(248) =a_MLP*3*(x244-x248);
xdot(249) =a_MLP*3*(x248-x249);
xdot(250) =a_MLP*3*(x249-x250);
xdot(251) =a_MLP_GMP*3*(x244-x251);
xdot(252) =a_MLP_GMP*3*(x251-x252);
xdot(253) =a_MLP_GMP*3*(x252-x253);
xdot(254) =a_MPP_MLP*3*x181+2*b_MLP*3*x247-(b_MLP*3+a_MLP*3+a_MLP_GMP*3)*x254;
xdot(255) =+b_MLP*3*(x254-x255);
xdot(256) =+b_MLP*3*(x255-x256);
xdot(257) =+b_MLP*3*(x256-x257);
xdot(258) =a_MLP*3*(x254-x258);
xdot(259) =a_MLP*3*(x258-x259);
xdot(260) =a_MLP*3*(x259-x260);
xdot(261) =a_MLP_GMP*3*(x254-x261);
xdot(262) =a_MLP_GMP*3*(x261-x262);
xdot(263) =a_MLP_GMP*3*(x262-x263);
xdot(264) =a_MPP_MLP*3*x197+2*b_MLP*3*x257+2*b_MLP*3*x267-(b_MLP*3+a_MLP*3+a_MLP_GMP*3)*x264;
xdot(265) =+b_MLP*3*(x264-x265);
xdot(266) =+b_MLP*3*(x265-x266);
xdot(267) =+b_MLP*3*(x266-x267);
xdot(268) =a_MLP*3*(x264-x268);
xdot(269) =a_MLP*3*(x268-x269);
xdot(270) =a_MLP*3*(x269-x270);
xdot(271) =a_MLP_GMP*3*(x264-x271);
xdot(272) =a_MLP_GMP*3*(x271-x272);
xdot(273) =a_MLP_GMP*3*(x272-x273);

%CMP
xdot(274) =a_MPP_CMP*3*x98-(b_CMP*3+a_CMP_MEP*3+a_CMP_GMP*3+g_CMP*3)*x274;
xdot(275) =+b_CMP*3*(x274-x275);
xdot(276) =+b_CMP*3*(x275-x276);
xdot(277) =+b_CMP*3*(x276-x277);
xdot(278) =a_CMP_MEP*3*(x274-x278);
xdot(279) =a_CMP_MEP*3*(x278-x279);
xdot(280) =a_CMP_MEP*3*(x279-x280);
xdot(281) =a_CMP_GMP*3*(x274-x281);
xdot(282) =a_CMP_GMP*3*(x281-x282);
xdot(283) =a_CMP_GMP*3*(x282-x283);
xdot(284) =g_CMP*3*(x274-x284);
xdot(285) =g_CMP*3*(x284-x285);
xdot(286) =g_CMP*3*(x285-x286);
xdot(287) =a_MPP_CMP*3*x114+2*b_CMP*3*x277-(b_CMP*3+a_CMP_MEP*3+a_CMP_GMP*3+g_CMP*3)*x287;
xdot(288) =+b_CMP*3*(x287-x288);
xdot(289) =+b_CMP*3*(x288-x289);
xdot(290) =+b_CMP*3*(x289-x290);
xdot(291) =a_CMP_MEP*3*(x287-x291);
xdot(292) =a_CMP_MEP*3*(x291-x292);
xdot(293) =a_CMP_MEP*3*(x292-x293);
xdot(294) =a_CMP_GMP*3*(x287-x294);
xdot(295) =a_CMP_GMP*3*(x294-x295);
xdot(296) =a_CMP_GMP*3*(x295-x296);
xdot(297) =g_CMP*3*(x287-x297);
xdot(298) =g_CMP*3*(x297-x298);
xdot(299) =g_CMP*3*(x298-x299);
xdot(300) =a_MPP_CMP*3*x130+2*b_CMP*3*x290-(b_CMP*3+a_CMP_MEP*3+a_CMP_GMP*3+g_CMP*3)*x300;
xdot(301) =+b_CMP*3*(x300-x301);
xdot(302) =+b_CMP*3*(x301-x302);
xdot(303) =+b_CMP*3*(x302-x303);
xdot(304) =a_CMP_MEP*3*(x300-x304);
xdot(305) =a_CMP_MEP*3*(x304-x305);
xdot(306) =a_CMP_MEP*3*(x305-x306);
xdot(307) =a_CMP_GMP*3*(x300-x307);
xdot(308) =a_CMP_GMP*3*(x307-x308);
xdot(309) =a_CMP_GMP*3*(x308-x309);
xdot(310) =g_CMP*3*(x300-x310);
xdot(311) =g_CMP*3*(x310-x311);
xdot(312) =g_CMP*3*(x311-x312);
xdot(313) =a_MPP_CMP*3*x146+2*b_CMP*3*x303-(b_CMP*3+a_CMP_MEP*3+a_CMP_GMP*3+g_CMP*3)*x313;
xdot(314) =+b_CMP*3*(x313-x314);
xdot(315) =+b_CMP*3*(x314-x315);
xdot(316) =+b_CMP*3*(x315-x316);
xdot(317) =a_CMP_MEP*3*(x313-x317);
xdot(318) =a_CMP_MEP*3*(x317-x318);
xdot(319) =a_CMP_MEP*3*(x318-x319);
xdot(320) =a_CMP_GMP*3*(x313-x320);
xdot(321) =a_CMP_GMP*3*(x320-x321);
xdot(322) =a_CMP_GMP*3*(x321-x322);
xdot(323) =g_CMP*3*(x313-x323);
xdot(324) =g_CMP*3*(x323-x324);
xdot(325) =g_CMP*3*(x324-x325);
xdot(326) =a_MPP_CMP*3*x162+2*b_CMP*3*x316-(b_CMP*3+a_CMP_MEP*3+a_CMP_GMP*3+g_CMP*3)*x326;
xdot(327) =+b_CMP*3*(x326-x327);
xdot(328) =+b_CMP*3*(x327-x328);
xdot(329) =+b_CMP*3*(x328-x329);
xdot(330) =a_CMP_MEP*3*(x326-x330);
xdot(331) =a_CMP_MEP*3*(x330-x331);
xdot(332) =a_CMP_MEP*3*(x331-x332);
xdot(333) =a_CMP_GMP*3*(x326-x333);
xdot(334) =a_CMP_GMP*3*(x333-x334);
xdot(335) =a_CMP_GMP*3*(x334-x335);
xdot(336) =g_CMP*3*(x326-x336);
xdot(337) =g_CMP*3*(x336-x337);
xdot(338) =g_CMP*3*(x337-x338);
xdot(339) =a_MPP_CMP*3*x178+2*b_CMP*3*x329-(b_CMP*3+a_CMP_MEP*3+a_CMP_GMP*3+g_CMP*3)*x339;
xdot(340) =+b_CMP*3*(x339-x340);
xdot(341) =+b_CMP*3*(x340-x341);
xdot(342) =+b_CMP*3*(x341-x342);
xdot(343) =a_CMP_MEP*3*(x339-x343);
xdot(344) =a_CMP_MEP*3*(x343-x344);
xdot(345) =a_CMP_MEP*3*(x344-x345);
xdot(346) =a_CMP_GMP*3*(x339-x346);
xdot(347) =a_CMP_GMP*3*(x346-x347);
xdot(348) =a_CMP_GMP*3*(x347-x348);
xdot(349) =g_CMP*3*(x339-x349);
xdot(350) =g_CMP*3*(x349-x350);
xdot(351) =g_CMP*3*(x350-x351);
xdot(352) =a_MPP_CMP*3*x194+2*b_CMP*3*x342+2*b_CMP*3*x355-(b_CMP*3+a_CMP_MEP*3+a_CMP_GMP*3+g_CMP*3)*x352;
xdot(353) =+b_CMP*3*(x352-x353);
xdot(354) =+b_CMP*3*(x353-x354);
xdot(355) =+b_CMP*3*(x354-x355);
xdot(356) =a_CMP_MEP*3*(x352-x356);
xdot(357) =a_CMP_MEP*3*(x356-x357);
xdot(358) =a_CMP_MEP*3*(x357-x358);
xdot(359) =a_CMP_GMP*3*(x352-x359);
xdot(360) =a_CMP_GMP*3*(x359-x360);
xdot(361) =a_CMP_GMP*3*(x360-x361);
xdot(362) =g_CMP*3*(x352-x362);
xdot(363) =g_CMP*3*(x362-x363);
xdot(364) =g_CMP*3*(x363-x364);

%GMP
xdot(365) =a_CMP_GMP*3*x283+a_MLP_GMP*3*x213-(b_GMP*3+a_GMP_mat*3+g_GMP*3)*x365;
xdot(366) =+b_GMP*3*(x365-x366);
xdot(367) =+b_GMP*3*(x366-x367);
xdot(368) =+b_GMP*3*(x367-x368);
xdot(369) =a_GMP_mat*3*(x365-x369);
xdot(370) =a_GMP_mat*3*(x369-x370);
xdot(371) =a_GMP_mat*3*(x370-x371);
xdot(372) =g_GMP*3*(x365-x372);
xdot(373) =g_GMP*3*(x372-x373);
xdot(374) =g_GMP*3*(x373-x374);
xdot(375) =a_CMP_GMP*3*x296+a_MLP_GMP*3*x223+2*b_GMP*3*x368-(b_GMP*3+a_GMP_mat*3+g_GMP*3)*x375;
xdot(376) =+b_GMP*3*(x375-x376);
xdot(377) =+b_GMP*3*(x376-x377);
xdot(378) =+b_GMP*3*(x377-x378);
xdot(379) =a_GMP_mat*3*(x375-x379);
xdot(380) =a_GMP_mat*3*(x379-x380);
xdot(381) =a_GMP_mat*3*(x380-x381);
xdot(382) =g_GMP*3*(x375-x382);
xdot(383) =g_GMP*3*(x382-x383);
xdot(384) =g_GMP*3*(x383-x384);
xdot(385) =a_CMP_GMP*3*x309+a_MLP_GMP*3*x233+2*b_GMP*3*x378-(b_GMP*3+a_GMP_mat*3+g_GMP*3)*x385;
xdot(386) =+b_GMP*3*(x385-x386);
xdot(387) =+b_GMP*3*(x386-x387);
xdot(388) =+b_GMP*3*(x387-x388);
xdot(389) =a_GMP_mat*3*(x385-x389);
xdot(390) =a_GMP_mat*3*(x389-x390);
xdot(391) =a_GMP_mat*3*(x390-x391);
xdot(392) =g_GMP*3*(x385-x392);
xdot(393) =g_GMP*3*(x392-x393);
xdot(394) =g_GMP*3*(x393-x394);
xdot(395) =a_CMP_GMP*3*x322+a_MLP_GMP*3*x243+2*b_GMP*3*x388-(b_GMP*3+a_GMP_mat*3+g_GMP*3)*x395;
xdot(396) =+b_GMP*3*(x395-x396);
xdot(397) =+b_GMP*3*(x396-x397);
xdot(398) =+b_GMP*3*(x397-x398);
xdot(399) =a_GMP_mat*3*(x395-x399);
xdot(400) =a_GMP_mat*3*(x399-x400);
xdot(401) =a_GMP_mat*3*(x400-x401);
xdot(402) =g_GMP*3*(x395-x402);
xdot(403) =g_GMP*3*(x402-x403);
xdot(404) =g_GMP*3*(x403-x404);
xdot(405) =a_CMP_GMP*3*x335+a_MLP_GMP*3*x253+2*b_GMP*3*x398-(b_GMP*3+a_GMP_mat*3+g_GMP*3)*x405;
xdot(406) =+b_GMP*3*(x405-x406);
xdot(407) =+b_GMP*3*(x406-x407);
xdot(408) =+b_GMP*3*(x407-x408);
xdot(409) =a_GMP_mat*3*(x405-x409);
xdot(410) =a_GMP_mat*3*(x409-x410);
xdot(411) =a_GMP_mat*3*(x410-x411);
xdot(412) =g_GMP*3*(x405-x412);
xdot(413) =g_GMP*3*(x412-x413);
xdot(414) =g_GMP*3*(x413-x414);
xdot(415) =a_CMP_GMP*3*x348+a_MLP_GMP*3*x263+2*b_GMP*3*x408-(b_GMP*3+a_GMP_mat*3+g_GMP*3)*x415;
xdot(416) =+b_GMP*3*(x415-x416);
xdot(417) =+b_GMP*3*(x416-x417);
xdot(418) =+b_GMP*3*(x417-x418);
xdot(419) =a_GMP_mat*3*(x415-x419);
xdot(420) =a_GMP_mat*3*(x419-x420);
xdot(421) =a_GMP_mat*3*(x420-x421);
xdot(422) =g_GMP*3*(x415-x422);
xdot(423) =g_GMP*3*(x422-x423);
xdot(424) =g_GMP*3*(x423-x424);
xdot(425) =a_CMP_GMP*3*x361+a_MLP_GMP*3*x273+2*b_GMP*3*x418+2*b_GMP*3*x428-(b_GMP*3+a_GMP_mat*3+g_GMP*3)*x425;
xdot(426) =+b_GMP*3*(x425-x426);
xdot(427) =+b_GMP*3*(x426-x427);
xdot(428) =+b_GMP*3*(x427-x428);
xdot(429) =a_GMP_mat*3*(x425-x429);
xdot(430) =a_GMP_mat*3*(x429-x430);
xdot(431) =a_GMP_mat*3*(x430-x431);
xdot(432) =g_GMP*3*(x425-x432);
xdot(433) =g_GMP*3*(x432-x433);
xdot(434) =g_GMP*3*(x433-x434);

%MEP
xdot(435) =a_HSC_MEP*3*x10+a_MPP_MEP*3*x104+a_CMP_MEP*3*x280-(b_MEP*3+a_MEP_mat*3+g_MEP*3)*x435;
xdot(436) =+b_MEP*3*(x435-x436);
xdot(437) =+b_MEP*3*(x436-x437);
xdot(438) =+b_MEP*3*(x437-x438);
xdot(439) =a_MEP_mat*3*(x435-x439);
xdot(440) =a_MEP_mat*3*(x439-x440);
xdot(441) =a_MEP_mat*3*(x440-x441);
xdot(442) =g_MEP*3*(x435-x442);
xdot(443) =g_MEP*3*(x442-x443);
xdot(444) =g_MEP*3*(x443-x444);
xdot(445) =a_HSC_MEP*3*x23+a_MPP_MEP*3*x120+a_CMP_MEP*3*x293+2*b_MEP*3*x438-(b_MEP*3+a_MEP_mat*3+g_MEP*3)*x445;
xdot(446) =+b_MEP*3*(x445-x446);
xdot(447) =+b_MEP*3*(x446-x447);
xdot(448) =+b_MEP*3*(x447-x448);
xdot(449) =a_MEP_mat*3*(x445-x449);
xdot(450) =a_MEP_mat*3*(x449-x450);
xdot(451) =a_MEP_mat*3*(x450-x451);
xdot(452) =g_MEP*3*(x445-x452);
xdot(453) =g_MEP*3*(x452-x453);
xdot(454) =g_MEP*3*(x453-x454);
xdot(455) =a_HSC_MEP*3*x36+a_MPP_MEP*3*x136+a_CMP_MEP*3*x306+2*b_MEP*3*x448-(b_MEP*3+a_MEP_mat*3+g_MEP*3)*x455;
xdot(456) =+b_MEP*3*(x455-x456);
xdot(457) =+b_MEP*3*(x456-x457);
xdot(458) =+b_MEP*3*(x457-x458);
xdot(459) =a_MEP_mat*3*(x455-x459);
xdot(460) =a_MEP_mat*3*(x459-x460);
xdot(461) =a_MEP_mat*3*(x460-x461);
xdot(462) =g_MEP*3*(x455-x462);
xdot(463) =g_MEP*3*(x462-x463);
xdot(464) =g_MEP*3*(x463-x464);
xdot(465) =a_HSC_MEP*3*x49+a_MPP_MEP*3*x152+a_CMP_MEP*3*x319+2*b_MEP*3*x458-(b_MEP*3+a_MEP_mat*3+g_MEP*3)*x465;
xdot(466) =+b_MEP*3*(x465-x466);
xdot(467) =+b_MEP*3*(x466-x467);
xdot(468) =+b_MEP*3*(x467-x468);
xdot(469) =a_MEP_mat*3*(x465-x469);
xdot(470) =a_MEP_mat*3*(x469-x470);
xdot(471) =a_MEP_mat*3*(x470-x471);
xdot(472) =g_MEP*3*(x465-x472);
xdot(473) =g_MEP*3*(x472-x473);
xdot(474) =g_MEP*3*(x473-x474);
xdot(475) =a_HSC_MEP*3*x62+a_MPP_MEP*3*x168+a_CMP_MEP*3*x332+2*b_MEP*3*x468-(b_MEP*3+a_MEP_mat*3+g_MEP*3)*x475;
xdot(476) =+b_MEP*3*(x475-x476);
xdot(477) =+b_MEP*3*(x476-x477);
xdot(478) =+b_MEP*3*(x477-x478);
xdot(479) =a_MEP_mat*3*(x475-x479);
xdot(480) =a_MEP_mat*3*(x479-x480);
xdot(481) =a_MEP_mat*3*(x480-x481);
xdot(482) =g_MEP*3*(x475-x482);
xdot(483) =g_MEP*3*(x482-x483);
xdot(484) =g_MEP*3*(x483-x484);
xdot(485) =a_HSC_MEP*3*x75+a_MPP_MEP*3*x184+a_CMP_MEP*3*x345+2*b_MEP*3*x478-(b_MEP*3+a_MEP_mat*3+g_MEP*3)*x485;
xdot(486) =+b_MEP*3*(x485-x486);
xdot(487) =+b_MEP*3*(x486-x487);
xdot(488) =+b_MEP*3*(x487-x488);
xdot(489) =a_MEP_mat*3*(x485-x489);
xdot(490) =a_MEP_mat*3*(x489-x490);
xdot(491) =a_MEP_mat*3*(x490-x491);
xdot(492) =g_MEP*3*(x485-x492);
xdot(493) =g_MEP*3*(x492-x493);
xdot(494) =g_MEP*3*(x493-x494);
xdot(495) =a_HSC_MEP*3*x88+a_MPP_MEP*3*x200+a_CMP_MEP*3*x358+2*b_MEP*3*x488+2*b_MEP*3*x498-(b_MEP*3+a_MEP_mat*3+g_MEP*3)*x495;
xdot(496) =+b_MEP*3*(x495-x496);
xdot(497) =+b_MEP*3*(x496-x497);
xdot(498) =+b_MEP*3*(x497-x498);
xdot(499) =a_MEP_mat*3*(x495-x499);
xdot(500) =a_MEP_mat*3*(x499-x500);
xdot(501) =a_MEP_mat*3*(x500-x501);
xdot(502) =g_MEP*3*(x495-x502);
xdot(503) =g_MEP*3*(x502-x503);
xdot(504) =g_MEP*3*(x503-x504);

%mat
xdot(505) =a_MEP_mat*3*x441+a_GMP_mat*3*x371-(b_mat*3+g_mat*3)*x505;
xdot(506) =+b_mat*3*(x505-x506);
xdot(507) =+b_mat*3*(x506-x507);
xdot(508) =+b_mat*3*(x507-x508);
xdot(509) =g_mat*3*(x505-x509);
xdot(510) =g_mat*3*(x509-x510);
xdot(511) =g_mat*3*(x510-x511);
xdot(512) =a_MEP_mat*3*x451+a_GMP_mat*3*x381+2*b_mat*3*x508-(b_mat*3+g_mat*3)*x512;
xdot(513) =+b_mat*3*(x512-x513);
xdot(514) =+b_mat*3*(x513-x514);
xdot(515) =+b_mat*3*(x514-x515);
xdot(516) =g_mat*3*(x512-x516);
xdot(517) =g_mat*3*(x516-x517);
xdot(518) =g_mat*3*(x517-x518);
xdot(519) =a_MEP_mat*3*x461+a_GMP_mat*3*x391+2*b_mat*3*x515-(b_mat*3+g_mat*3)*x519;
xdot(520) =+b_mat*3*(x519-x520);
xdot(521) =+b_mat*3*(x520-x521);
xdot(522) =+b_mat*3*(x521-x522);
xdot(523) =g_mat*3*(x519-x523);
xdot(524) =g_mat*3*(x523-x524);
xdot(525) =g_mat*3*(x524-x525);
xdot(526) =a_MEP_mat*3*x471+a_GMP_mat*3*x401+2*b_mat*3*x522-(b_mat*3+g_mat*3)*x526;
xdot(527) =+b_mat*3*(x526-x527);
xdot(528) =+b_mat*3*(x527-x528);
xdot(529) =+b_mat*3*(x528-x529);
xdot(530) =g_mat*3*(x526-x530);
xdot(531) =g_mat*3*(x530-x531);
xdot(532) =g_mat*3*(x531-x532);
xdot(533) =a_MEP_mat*3*x481+a_GMP_mat*3*x411+2*b_mat*3*x529-(b_mat*3+g_mat*3)*x533;
xdot(534) =+b_mat*3*(x533-x534);
xdot(535) =+b_mat*3*(x534-x535);
xdot(536) =+b_mat*3*(x535-x536);
xdot(537) =g_mat*3*(x533-x537);
xdot(538) =g_mat*3*(x537-x538);
xdot(539) =g_mat*3*(x538-x539);
xdot(540) =a_MEP_mat*3*x491+a_GMP_mat*3*x421+2*b_mat*3*x536-(b_mat*3+g_mat*3)*x540;
xdot(541) =+b_mat*3*(x540-x541);
xdot(542) =+b_mat*3*(x541-x542);
xdot(543) =+b_mat*3*(x542-x543);
xdot(544) =g_mat*3*(x540-x544);
xdot(545) =g_mat*3*(x544-x545);
xdot(546) =g_mat*3*(x545-x546);
xdot(547) =a_MEP_mat*3*x501+a_GMP_mat*3*x431+2*b_mat*3*x543+2*b_mat*3*x550-(b_mat*3+g_mat*3)*x547;
xdot(548) =+b_mat*3*(x547-x548);
xdot(549) =+b_mat*3*(x548-x549);
xdot(550) =+b_mat*3*(x549-x550);
xdot(551) =g_mat*3*(x547-x551);
xdot(552) =g_mat*3*(x551-x552);
xdot(553) =g_mat*3*(x552-x553);

%D



% INITIAL CONDITIONS
x0 = sym(zeros(size(x)));
x0([1,92,204,274,365,435,505])=exp(p(1:7))-1;

% OBSERVABLES
y= sym(zeros(49,1));
for i=1:7
y(0+i) = log(sum(x((i-1)*13+1:i*13+1-1))+1);
end
for i=1:7
y(7+i) = log(sum(x((i-1)*16+92:i*16+92-1))+1);
end
for i=1:7
y(14+i) = log(sum(x((i-1)*10+204:i*10+204-1))+1);
end
for i=1:7
y(21+i) = log(sum(x((i-1)*13+274:i*13+274-1))+1);
end
for i=1:7
y(28+i) = log(sum(x((i-1)*10+365:i*10+365-1))+1);
end
for i=1:7
y(35+i) = log(sum(x((i-1)*10+435:i*10+435-1))+1);
end
for i=1:7
y(42+i) = log(sum(x((i-1)*7+505:i*7+505-1))+1);
end


% SYSTEM STRUCT
model.sym.x = x;
model.sym.k = k;
model.sym.xdot = xdot;
model.sym.p = p;
model.sym.x0 = x0;
model.sym.y = y;
model.sym.sigma_y = 0;











































































































































































































































































