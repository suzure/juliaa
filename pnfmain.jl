include("tickstopnf.jl")
include("doubletoptest.jl")

#@time
boxSize=100
rev=2
pnfdata=tickstopnffix("C:/Users/Alex/Documents/julia/SPFB.RTS_141117_141117.csv",boxSize,rev)
#pnfdata=tickstopnffix("testpnf.csv",1,3)

#println(pnfdata)
println(finddoubletop(pnfdata,boxSize,rev))
