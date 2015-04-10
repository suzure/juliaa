#здесь мы тестируем базовый алгоритм и проходим по каждому дню в определенном периоде
#пробуем вариации: размер sl и tp, подтягивание sl и tp, выход по времени, ограничение торгового времени
#
include("another2.jl")
#собираем список дней из папки rtscsv, которые хотим обсчитать
path=pwd()*"\\rtscsv"
fileNames = readdir(path)
println(length(fileNames))
#проходим по каждому и записываем выходные данные в общий массив
#xxx=strategy(path*"\\"*fileNames[5])
#println(length(xxx))
equities=Float64[]
        i=1
for fileName in fileNames

        println(i,"/",length(fileNames))
        i+=1
        push!(equities,strategy(path*"\\"*fileName))
end
writecsv("eq.csv",equities)
println(sum(equities))
