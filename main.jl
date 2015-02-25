include("arrayReject.jl")
dataMIX=readcsv("C:/Users/Alex/Documents/julia/SPFB.MIX-12.14_141110_141112.csv")
dataRTS=readcsv("C:/Users/Alex/Documents/julia/SPFB.RTS_141110_141112.csv")
dataSi=readcsv("C:/Users/Alex/Documents/julia/SPFB.Si-12.14_141110_141112.csv")
#в ммвб не все минутки есть, и в си тоже, из других датасетов их надо выкинуть
#setdiff не работает, тк у нас больше одного дня, поэтому
#время сравнивается попарно, как только появляется несовпадение, время записывается и от итератора ммвб -1

#diffBarSets!(dataRTS,dataMIX)

#println(length(dataMIX[:,2]),length(dataRTS[:,2]))
#println(dataMIX[155,2],"   ",newRTS[155,2],"   ",newSi[155,2])
x=4
println(x)
chang!(x)
println(x)
