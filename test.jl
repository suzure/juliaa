println(strftime(time())," поехали")
#грузим табличку из csv и оставляем только столбец 4. Надо найти какой-нибудь менее затратный для памяти способ, чем делать все string
carNoArray=readdlm("C:/Users/Alex/Documents/julia/ParkingSessions_Mar_2015.csv",';',String)
carNoArray=carNoArray[:,4:5]
gc()
#если в 5 столбце есть "res", сохраняем номер из 4 столбца
new=Array(String,0,2)
for i=1:length(carNoArray[:,1])
        if contains(carNoArray[i,2],"RES")
                new=vcat(new,carNoArray[i,:])
        end
end

println(length(new))
writecsv("residents.csv",new)
carNoArray=0
new=0
gc()
println(strftime(time())," готово")
