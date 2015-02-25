#функция для конвертации файла с тиками, который лежит в path,
#в массив хо с размером бокса boxSize и разворотом в reverseSize, время и объем не учитываются
#отсчет начинается с первого тика. Потом можно будет искать привязку к круглым уровням
function tickstopnffix(path::String,boxSize,reverseSize::Int64)
        #грузим таблицу в память и оставляем в ней только цены
        data=readcsv(path)
        data=data[:,3]
        #инициализируем выходной массив хо
        pnf=Float64[]
        #запоминаем первое значение
        t0=data[1]
        push!(pnf,t0)
        #получаем первичное направление в цикле
        dir=0
        i=2
        while true
                if data[i]>=t0+boxSize#это вверх
                        t0=data[i]
                        push!(pnf,t0)
                        dir=1#это направление, 1 - вверх, -1 - вниз
                        break
                end
                if data[i]<=t0-boxSize#это вниз
                        t0=data[i]
                        push!(pnf,t0)
                        dir=-1
                        break
                end
                i+=1
        end

        #границы, при прохождении которых отмечаем хо
        supUp=t0+boxSize#новый х
        infUp=t0-boxSize*reverseSize#разворот на росте
        supDown=t0+boxSize*reverseSize#разворот на падении
        infDown=t0-boxSize#новый о

        #проходим по каждому тику, начиная с того места, где остановились, и проверяем, не зашел ли он за границу
        for j=i:length(data)
                if dir==1
                        if data[j]>=supUp#новый х
                                t0=data[j]#новая точка отсчета
                                push!(pnf,t0)
                                supUp=t0+boxSize#новая граница для следующего х
                                infUp=t0-boxSize*reverseSize#новая граница для разворота на росте
                        end
                        if data[j]<=infUp#разворот на росте
                                t0=data[j]#новая точка отсчета
                                push!(pnf,t0)
                                dir=-1#смена направления
                                supDown=t0+boxSize*reverseSize#новая граница для разворота на падении
                                infDown=t0-boxSize#новая граница для следующего o
                        end
                end
                if dir==-1
                        if data[j]<=infDown#новый o
                                t0=data[j]#новая точка отсчета
                                push!(pnf,t0)
                                supDown=t0+boxSize*reverseSize#новая граница для разворота на падении
                                infDown=t0-boxSize#новая граница для следующего o
                        end
                        if data[j]>=supDown#разворот на падении
                                t0=data[j]#новая точка отсчета
                                push!(pnf,t0)
                                dir=1#смена направления
                                supUp=t0+boxSize#новая граница для следующего х
                                infUp=t0-boxSize*reverseSize#новая граница для разворота на росте
                        end
                end
        end
        return pnf
end
