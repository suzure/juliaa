#в этой версии SL и TP ставятся и не меняются. Условие срабатывает постоянно.
function isInBounds(tick,bounds)
        return p=((tick-bounds[2])/(bounds[1]-bounds[2])-0.5)*(2)
end
#грузим тики, в будущем посмотреть как грузить с типами
#позже посчитаю распределение (куда идет точка после касания границы отрезка)
#позже сдесь будет цикл, проходящий по датам
#позже надо поименовать столбцы: hh,mm,ss,price,vol
path="SPFB.RTS_141117_141117.csv"
data=readcsv(path)

#парсим время на hh, mm, ss
#позже делим их на три периода 10:02-13:59, 14:05-18:44, 19:02-23:48
#позже попробовать devectorize
ss=data[:,2]%100
mm=(data[:,2]%10000-ss)/100
hh=(data[:,2]-ss-mm*100)/10000
data=hcat(hh,mm,ss,data[:,3:4])
#чистим память
hh=0
mm=0
ss=0
gc()

#main loop начинаем со второго тика, последним закрываем
high=data[2,4]+10000
low=data[2,4]-10000
newHigh=newLow=higherExit=lowerExit=data[2,4]
boundSelector=[true,true,false,false]
bounds=[high,low,higherExit,lowerExit]
deals=Float64[]

notThisShitAgain=0#этот костыль надо убрать

for i=2:size(data,1)-1
        tick=data[i,4]
        if data[i,2]!=data[i-1,2]   #каждый тик проверяем на окончание периода (минута меняется)
                high=newHigh        #записываем high прошедшего периода
                low=newLow          #записываем low прошедшего периода
                newHigh=tick   #сбрасываем newHigh
                newLow=tick    #сбрасываем newLow
                bounds[1]=high
                bounds[2]=low
                #место для изменения higherExit/lowerExit из-за смены периода
        elseif tick>newHigh
                newHigh=tick        #обновляем high текущего периода
        elseif tick<newLow
                newLow=tick         #обновляем low текущего периода
        end
        #проверяем, не вышла ли точка из отрезка
        p=isInBounds(tick,bounds[boundSelector])

        if abs(p)>1 #точка вышла за отрезок

                if boundSelector[1]#и это была точка входа, пишем точку и время
                                        #print(data[i,1]*10000+data[i,2]*100+data[i,3]," ",sign(p)," ",tick*sign(p)*(-1)," ")
                        push!(deals,sign(p)*(-1)*tick,data[i,1]*10000+data[i,2]*100+data[i,3])
                        higherExit=tick+high-low
                        lowerExit=tick-high+low
                        notThisShitAgain=sign(p)#это мы так запоминаем направление
                else #и это была точка выхода
                        push!(deals,tick*notThisShitAgain,data[i,1]*10000+data[i,2]*100+data[i,3])
                                        #print(data[i,1]*10000+data[i,2]*100+data[i,3]," ",sign(p)," ",tick*sign(p))
                                        #println()
                end

                #как-то даем понять, что теперь надо смотреть выход из другого отрезка
                boundSelector=!boundSelector

                #обновляем границы
                bounds=[high,low,higherExit,lowerExit]
        end
end

#закрываем последним тиком сделку, если она была
if boundSelector[3]
        push!(deals,data[end,4]*notThisShitAgain,data[end,1]*10000+data[end,2]*100+data[end,3])
end
writecsv("trades.csv",deals)
println(length(deals))
sum=0
for i=1:4:(length(deals)-2)
        sum+=deals[i]+deals[i+2]
end
println(sum)

data=0
boundSelector=0
bounds=0
deals=0
gc()
println("finish")
#есть точка (tick) и есть интервалы (границы входа, границы выхода). Интервалы изменяются после выхода точки за границы
#или после окончания периода. Как только точка пересекает границы входа, этот интервал выключается и включается выход. Процесс,
#который формирует границы интервала для следующего периода, всегда работает.
#если p>1, значит точка ниже, если p<0, значит точка выше (а зачем?).
#
#
#
