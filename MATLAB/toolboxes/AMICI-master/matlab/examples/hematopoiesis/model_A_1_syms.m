function [model] = model_A_1_syms()
% set the parametrisation of the problem options are 'log', 'log10' and
% 'lin' (default).
% model.param = 'log10';

%%
% STATES

% create state syms
syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20 x21 x22 x23 x24 x25 x26 x27 x28 x29 x30 x31 x32 x33 x34 x35 x36 x37 x38 x39 x40 x41 x42 x43 x44 x45 x46 x47 x48 x49

% create state vector
x = [
 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20 x21 x22 x23 x24 x25 x26 x27 x28 x29 x30 x31 x32 x33 x34 x35 x36 x37 x38 x39 x40 x41 x42 x43 x44 x45 x46 x47 x48 x49
];

%%
% PARAMETERS ( for these sensitivities will be computed )

% create parameter syms
syms x0_1 x0_2 x0_3 x0_4 x0_5 x0_6 x0_7 a_HSC_MPP b_HSC g_HSC a_MPP_MLP a_MPP_CMP b_MPP g_MPP a_MLP b_MLP a_CMP_GMP a_CMP_MEP b_CMP g_CMP a_GMP_mat b_GMP g_GMP a_MEP_mat b_MEP g_MEP b_mat g_mat

% create parameter vector 
p= [x0_1 x0_2 x0_3 x0_4 x0_5 x0_6 x0_7 a_HSC_MPP b_HSC g_HSC a_MPP_MLP a_MPP_CMP b_MPP g_MPP a_MLP b_MLP a_CMP_GMP a_CMP_MEP b_CMP g_CMP a_GMP_mat b_GMP g_GMP a_MEP_mat b_MEP g_MEP b_mat g_mat];

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
xdot(1) = -(b_HSC+a_HSC_MPP+g_HSC)*x1;
xdot(2) = 2*b_HSC*x1-(b_HSC+a_HSC_MPP+g_HSC)*x2;
xdot(3) = 2*b_HSC*x2-(b_HSC+a_HSC_MPP+g_HSC)*x3;
xdot(4) = 2*b_HSC*x3-(b_HSC+a_HSC_MPP+g_HSC)*x4;
xdot(5) = 2*b_HSC*x4-(b_HSC+a_HSC_MPP+g_HSC)*x5;
xdot(6) = 2*b_HSC*x5-(b_HSC+a_HSC_MPP+g_HSC)*x6;
xdot(7) = 2*b_HSC*x6+2*b_HSC*x7-(b_HSC+a_HSC_MPP+g_HSC)*x7;

%MPP
xdot(8) = a_HSC_MPP*x1-(b_MPP+a_MPP_MLP+a_MPP_CMP+g_MPP)*x8;
xdot(9) = 2*b_MPP*x8+a_HSC_MPP*x2-(b_MPP+a_MPP_MLP+a_MPP_CMP+g_MPP)*x9;
xdot(10) = 2*b_MPP*x9+a_HSC_MPP*x3-(b_MPP+a_MPP_MLP+a_MPP_CMP+g_MPP)*x10;
xdot(11) = 2*b_MPP*x10+a_HSC_MPP*x4-(b_MPP+a_MPP_MLP+a_MPP_CMP+g_MPP)*x11;
xdot(12) = 2*b_MPP*x11+a_HSC_MPP*x5-(b_MPP+a_MPP_MLP+a_MPP_CMP+g_MPP)*x12;
xdot(13) = 2*b_MPP*x12+a_HSC_MPP*x6-(b_MPP+a_MPP_MLP+a_MPP_CMP+g_MPP)*x13;
xdot(14) = 2*b_MPP*x13+a_HSC_MPP*x7+2*b_MPP*x14-(b_MPP+a_MPP_MLP+a_MPP_CMP+g_MPP)*x14;

%MLP
xdot(15) = a_MPP_MLP*x8-(b_MLP+a_MLP)*x15;
xdot(16) = 2*b_MLP*x15+a_MPP_MLP*x9-(b_MLP+a_MLP)*x16;
xdot(17) = 2*b_MLP*x16+a_MPP_MLP*x10-(b_MLP+a_MLP)*x17;
xdot(18) = 2*b_MLP*x17+a_MPP_MLP*x11-(b_MLP+a_MLP)*x18;
xdot(19) = 2*b_MLP*x18+a_MPP_MLP*x12-(b_MLP+a_MLP)*x19;
xdot(20) = 2*b_MLP*x19+a_MPP_MLP*x13-(b_MLP+a_MLP)*x20;
xdot(21) = 2*b_MLP*x20+a_MPP_MLP*x14+2*b_MLP*x21-(b_MLP+a_MLP)*x21;

%CMP
xdot(22) = a_MPP_CMP*x8-(b_CMP+a_CMP_GMP+a_CMP_MEP+g_CMP)*x22;
xdot(23) = 2*b_CMP*x22+a_MPP_CMP*x9-(b_CMP+a_CMP_GMP+a_CMP_MEP+g_CMP)*x23;
xdot(24) = 2*b_CMP*x23+a_MPP_CMP*x10-(b_CMP+a_CMP_GMP+a_CMP_MEP+g_CMP)*x24;
xdot(25) = 2*b_CMP*x24+a_MPP_CMP*x11-(b_CMP+a_CMP_GMP+a_CMP_MEP+g_CMP)*x25;
xdot(26) = 2*b_CMP*x25+a_MPP_CMP*x12-(b_CMP+a_CMP_GMP+a_CMP_MEP+g_CMP)*x26;
xdot(27) = 2*b_CMP*x26+a_MPP_CMP*x13-(b_CMP+a_CMP_GMP+a_CMP_MEP+g_CMP)*x27;
xdot(28) = 2*b_CMP*x27+a_MPP_CMP*x14+2*b_CMP*x28-(b_CMP+a_CMP_GMP+a_CMP_MEP+g_CMP)*x28;

%GMP
xdot(29) = a_CMP_GMP*x22-(b_GMP+a_GMP_mat+g_GMP)*x29;
xdot(30) = 2*b_GMP*x29+a_CMP_GMP*x23-(b_GMP+a_GMP_mat+g_GMP)*x30;
xdot(31) = 2*b_GMP*x30+a_CMP_GMP*x24-(b_GMP+a_GMP_mat+g_GMP)*x31;
xdot(32) = 2*b_GMP*x31+a_CMP_GMP*x25-(b_GMP+a_GMP_mat+g_GMP)*x32;
xdot(33) = 2*b_GMP*x32+a_CMP_GMP*x26-(b_GMP+a_GMP_mat+g_GMP)*x33;
xdot(34) = 2*b_GMP*x33+a_CMP_GMP*x27-(b_GMP+a_GMP_mat+g_GMP)*x34;
xdot(35) = 2*b_GMP*x34+a_CMP_GMP*x28+2*b_GMP*x35-(b_GMP+a_GMP_mat+g_GMP)*x35;

%MEP
xdot(36) = a_CMP_MEP*x22-(b_MEP+a_MEP_mat+g_MEP)*x36;
xdot(37) = 2*b_MEP*x36+a_CMP_MEP*x23-(b_MEP+a_MEP_mat+g_MEP)*x37;
xdot(38) = 2*b_MEP*x37+a_CMP_MEP*x24-(b_MEP+a_MEP_mat+g_MEP)*x38;
xdot(39) = 2*b_MEP*x38+a_CMP_MEP*x25-(b_MEP+a_MEP_mat+g_MEP)*x39;
xdot(40) = 2*b_MEP*x39+a_CMP_MEP*x26-(b_MEP+a_MEP_mat+g_MEP)*x40;
xdot(41) = 2*b_MEP*x40+a_CMP_MEP*x27-(b_MEP+a_MEP_mat+g_MEP)*x41;
xdot(42) = 2*b_MEP*x41+a_CMP_MEP*x28+2*b_MEP*x42-(b_MEP+a_MEP_mat+g_MEP)*x42;

%mat
xdot(43) = a_GMP_mat*x29+a_MEP_mat*x36-(b_mat+g_mat)*x43;
xdot(44) = 2*b_mat*x43++a_GMP_mat*x30++a_MEP_mat*x30+-(b_mat+g_mat)*x44;
xdot(45) = 2*b_mat*x44++a_GMP_mat*x31++a_MEP_mat*x31+-(b_mat+g_mat)*x45;
xdot(46) = 2*b_mat*x45++a_GMP_mat*x32++a_MEP_mat*x32+-(b_mat+g_mat)*x46;
xdot(47) = 2*b_mat*x46++a_GMP_mat*x33++a_MEP_mat*x33+-(b_mat+g_mat)*x47;
xdot(48) = 2*b_mat*x47++a_GMP_mat*x34++a_MEP_mat*x34+-(b_mat+g_mat)*x48;
xdot(49) = 2*b_mat*x48++a_GMP_mat*x35++a_MEP_mat*x35++2*b_mat*x49-(b_mat+g_mat)*x49;

%D



% INITIAL CONDITIONS
x0 = sym(zeros(size(x)));
x0(1:7:49)=exp(p(1:7))-1;

% OBSERVABLES
y= sym(zeros(49,1));
y = log(x+1);

% SYSTEM STRUCT
model.sym.x = x;
model.sym.k = k;
model.sym.xdot = xdot;
model.sym.p = p;
model.sym.x0 = x0;
model.sym.y = y;
model.sym.sigma_y = 0;

























































































































































































































































































































































































































































































































































































































































































































































































































