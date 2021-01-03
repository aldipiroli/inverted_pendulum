function Pd_z = dscrzoh(P_s, T)

Pd_z = c2d(P_s, T, 'zoh');
if hasdelay(Pd_z)
    Pd_z = absorbDelay(Pd_z);
end
if ~isStateSpace(Pd_z)
    Pd_z = zpk(Pd_z);
end    

end
