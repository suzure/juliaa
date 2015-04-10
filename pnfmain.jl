include("tickstopnf.jl")
include("doubletoptest.jl")

#@time
boxSize=50
rev=1
path=pwd()*"\\rtscsv"

fileNames = readdir(path)
println(fileNames)
i=1
for fileName in fileNames
println(i,"/",length(fileNames))
i+=1

println(finddoubletop(tickstopnffix(path*"\\"*fileName,boxSize,rev),boxSize,rev))
end
#pnfdata=tickstopnffix("C:/Users/Alex/Documents/julia/SPFB.RTS_141117_141117.csv",boxSize,rev)
#pnfdata=tickstopnffix("testpnf.csv",1,3)

#println(pnfdata)

