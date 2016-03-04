function par = set_par
  %--------------------------------------------------------------- 
  % Parameters (values, unit and description)
  % pars: n-vector of parameters
  %    
  % called by : init.m
  %
  % 2013/03/15 - Laure Pecquerie
  % notation corresponds to the add_my_pet routines
  % Reference: <http://www.bio.vu.nl/thb/deb/deblab/add_my_pet/add_my_pet.pdf *add_my_pet manual*> 

  %--------------------------------------------------------------- 
 
  % temperature correction
  par.T1 = 293;  % 1, K, Reference temperature ; 
  par.TA = 8000; % 2, K, Arrhenius temperature ;
   
  % feeding & assimilation
  par.F_m = 6.5 * 0.85;       % 3, l/d.cm^2, {F_m} max spec searching rate
  par.kap_X = 0.8;     % 4, -, digestion efficiency of food to reserve
  par.p_Am = 289.0469;       % 5, J/cm^2/d, maximum surface-specific assimilation rate

  % mobilisation, maintenance, growth & reproduction
  par.v = 0.05469;     % 6, cm/d, energy conductance
  par.kap = 0.6679;    % 7, -, allocation fraction to soma = growth + somatic maintenance
  par.kap_R = 0.95;    % 8, -, reproduction efficiency
  par.p_M = 12.32;     % 9, J/d.cm^3, [p_M], vol-specific somatic maintenance
  par.p_T = 0;         % 10, J/d.cm^2, {p_T}, surface-specific som maintenance
  par.k_J = 0.002;   % 11, 1/d, maturity maint rate coefficient
  par.E_G =  5238;      % 12, J/cm^3, [E_G], spec cost for structure

  % life stages: E_H is the cumulated energy from reserve invested in maturation
  par.E_Hb = 6.829e4; % 13, J, E_H^b, maturity at birth
  par.E_Hp = 4.461e5;  % 14, J, E_H^p, maturity at puberty

  % param to compute observable quantities
  par.del_M = 0.3043;   % 15, -, shape coefficient to convert vol-length to physical length

  par.d_V  = 0.2; 	   % 16, g/cm^3, specific density of structure (dry weight)
  par.mu_V = 500000;   % 17, J/mol
  par.mu_E = 550000;   % 18 , J/mol
  par.w_V = 23.9;       % 19, g/mol
  par.w_E =  23.9;     % 20 , g/mol
  par.w = 5;            % 21  wet / dry weight coefficient
  
  % compounds parameters
  par.K = par.p_Am/ (par.kap_X * par.F_m);  % 22, same unit as food, half-saturation coefficient

  
