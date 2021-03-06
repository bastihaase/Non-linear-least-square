using KrylovMethods
using OptimTools

include("armijo.jl")
include("Fletcher_Xu.jl")


include("Freudenstein.jl")
include("classical.jl")
include("Nielsen.jl")
include("Trig.jl")

function determine_gamma(f,df,J,r,x_0)
	gamma=[0.05*i for i=1:19]

	iter_cl=zeros(19)
	gauss_cl=zeros(19)
	bfgs_cl=zeros(19)
	
	for i=1:19
		res=Fletcher_Xu(f,df,J,r,x_0,maxIter=1000,atol=10.0^(-8),tau=gamma[i])
		iter_cl[i]=res[2]
		gauss_cl[i]=res[4][1]
		bfgs_cl[i]=res[4][2]
	end
	return iter_cl,gauss_cl,bfgs_cl
end	

function det_Classical()
	return determine_gamma(Classical,grad_Classical,J_Classical,r_Classical,[0.0,10.0,20.0])
end

function det_Freudenstein()
	return determine_gamma(Freudenstein,grad_Freudenstein,J_Freudenstein,r_Freudenstein,[5.0,6.0])
end

function det_Nielsen()
	return determine_gamma(Nielsen,grad_Nielsen,J_Nielsen,r_Nielsen,[1.0,1.0,-0.75,0.75])
end

function det_Nielsen2()
	return determine_gamma(Nielsen,grad_Nielsen,J_Nielsen,r_Nielsen,[1.0,2.0,-2.0,1.0])
end

function det_Trig()
	return determine_gamma(Trig,grad_Trig,J_Trig,r_Trig,[25.0,5.0,-1.0,-5.0])
end

