function obs = get_obs(simu)
  %---------------------------------------------------------------
  % Compute physical length, weight, fecundity, and energy content from state variables
  %  
  % 
  % obs : (n, 5) matrix with 
  %         t: d, time,
  %			Lw: cm, physical length
  %         Ww: g, total wet weight,
  %			F: #, fecundity
  %         Ew: J/g, energy content per unit wet weight
  %     
  %
  % called by : main.m
  % 
  % 2013/03/15 - Laure Pecquerie
  %-------------------------------------------------------------


%% parameters, state variables
par = simu.par;
 

t = simu.tEVHR(:,1);
E = simu.tEVHR(:,2);
V = simu.tEVHR(:,3);
E_R = simu.tEVHR(:,5);


L_w = V.^(1/3) / par.del_M; % cm, physical length


W_V = par.d_V * V ;% dry weight of structure
W_E_and_R = par.w_E / par.mu_E * (E + E_R) ; % dry W of E and E_R
W = W_V + W_E_and_R; % total dry weight
W_w = par.w * W;% assume the same water content in structure and reserves

E_V = par.mu_V * par.d_V / par.w_V * V ;
E_w = (E_V + E + E_R) ./ W_w ;

F = par.kap_R * E_R / simu.EVHR_init(1); % Fecundity = egg number = kap_R * E_R / E_0

obs = [t , L_w , W_w, E_w, F];