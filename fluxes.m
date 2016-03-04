function d = fluxes(t, EVHR, simu)
  %---------------------------------------------------------------
  % Define differential equations of the state variables
  %  
  % t: n-vector with time points
  % EVHR: 4-vector with state variables
  %         E , J, reserve energy
  %         V , cm^3, structural volume
  %         E_H , J , cumulated energy inversted into maturity
  %         E_R , J, reproduction buffer
  %         
  % d: 4-vector with d/dt E, V, E_H, E_R
  %
  % called by : indiv.m, 
  % calls : food.m, temp.m, 
  %
  % 2013/03/15 - Laure Pecquerie
  %--------------------------------------------------------------
  % Environmental conditions
  if simu.envT == 1
      T = simu.Tinit;   
  else
      T = temp(t); 
  end

  if simu.envX == 1
      X = simu.Xinit ;
  else
       X = food(t);
  end
   
  %% unpack state vars
  E  = EVHR(1); % J, reserve energy
  V  = EVHR(2); % cm^3, structural volume
  E_H  = EVHR(3); % J , cumulated energy inversted into maturity 
  E_R  = EVHR(4); % J, reproduction buffer
  
  % read parameter values
  par = simu.par;
  
  % scaled functional response
  f = X/ (X + par.K); % -,   scaled functional response
  
  % simplest temperature correction function, 
  % see Kooijman 2010 for more detailed formulation (e.g. p. 21)
  c_T = exp(par.TA/ par.T1 - par.TA/ T) ;
  p_AmT = c_T * par.p_Am ;
  v_T = c_T * par.v; % 
  p_MT = c_T * par.p_M;
  p_TT = c_T * par.p_T; % 
  k_JT = c_T * par.k_J; 
  p_XmT = p_AmT / par.kap_X;
  
  % Fluxes
  if E_H < par.E_Hb
      pX = 0;% embryo stage
  else
      pX = f * p_XmT * V^(2/3);
  end
  
  pA = par.kap_X * pX;
  pM = p_MT * V;
  pT = p_TT * V^(2/3);
  pS = pM + pT;
  pC = (E/V) * (par.E_G * v_T * V^(2/3) + pS ) / (par.kap * E/V + par.E_G ); %eq. 2.12 p.37 Kooijman 2010
  pJ = k_JT * E_H;
  
  % Differential equations
  dE = pA - pC; % dE/dt
  dV = (par.kap * pC - pS) / par.E_G;% dV/dt
  if E_H < par.E_Hp
      dH = (1 - par.kap) * pC - pJ; % dEH/dt
      dR = 0; % dER/dt
  else
      dH = 0;
      dR = (1 - par.kap) * pC - pJ;
  end
  
  d = [dE; dV; dH; dR]; 