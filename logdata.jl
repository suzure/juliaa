#эта функция из тиковых данных делает логарифмы приращений
#то есть вместо p(n) -> ln(p(n)/p(n-1)), все остальное прежнее.
#function convertTickToLn(path)
#        return lnTickData
#end
path="SPFB.RTS_141117_141117.csv"
#читаем файл
tickData=readcsv(path)
#проходим по всей таблице, начиная со второго до предпоследнего тика, и правим ее же
for i=2:length(tickData[:,1])-1
        tickData[i,1]=tickData[i+1,1]
        tickData[i,2]=tickData[i+1,2]
        tickData[i,3]=ln(tickData[i+1,3]/tickData[i,3])
        tickData[i,4]=tickData[i+1,4]
end
