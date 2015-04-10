a=["1" "1"; "1" "2"; "2" "3"; "3" "w"]
println(a)
#filter(x[:,1]-> contains(x[:,2],"2"),a[:,1])
#b=(a[[1,3:end],:])
new=Array(String,0,2)
new=vcat(new,a[2,:])
new=vcat(new,a[1,:])
println(new)
