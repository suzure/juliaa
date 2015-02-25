#функция ищет двойную вершину или дно и возвращает кол-во. Строго предыдущий экстремум
#далее - не только рядом, но и на расстоянии (если цена возвращается после смены направления)
#можно расширить, задавая количество вершин, их удаленность, или удаленности давать вес

#если идем вверх и текущая цена выше предыдущего макс, значит: фигура есть, дальше на превышение не проверяем, идем вниз,
#ждем разворота как только случился разворот, последнюю цену считаем макс, после разворота наверх сравниваем с ним

function finddoubletop (pnfdata,boxSize,rev)
        counter=0#счетчик фигур
        counter2=0
        maxpro=0#все движение в сторону пробоя
        #проходим последовательно и ищем локальные максимумы
        #точка отсчета
        previousmax=maximum(pnfdata)
        previousmin=minimum(pnfdata)

        for i=2:length(pnfdata)-1
                if pnfdata[i-1]<pnfdata[i]&&pnfdata[i+1]<pnfdata[i]#локальный максимум
                        if pnfdata[i]>previousmax
                                counter+=1
                                maxpro+=pnfdata[i]-previousmax-boxSize
                                if pnfdata[i]-previousmax==boxSize#это мы считаем неудачные пробои
                                       counter2+=1
                                end
                        end
                        previousmax=pnfdata[i]

                end
                if pnfdata[i-1]>pnfdata[i]&&pnfdata[i+1]>pnfdata[i]#локальный минимум
                        if pnfdata[i]<previousmin
                                counter+=1
                                maxpro+=previousmin-pnfdata[i]-boxSize
                                if previousmin-pnfdata[i]==boxSize#это мы считаем неудачные пробои
                                       counter2+=1
                                end
                                #println(previousmin-pnfdata[i]-boxSize)
                        end
                        previousmin=pnfdata[i]
                end
        end
        i+=1
        #доп.проверка последнего значения
        if pnfdata[i]>previousmax
                counter+=1
                maxpro+=pnfdata[i]-previousmax-boxSize
        end
        if pnfdata[i]<previousmin
                counter+=1
                maxpro+=previousmin-pnfdata[i]-boxSize
        end
        #return (counter, maxpro-counter*boxSize*3)
        #return (counter,maxpro/counter, (counter-counter2*rev)*boxSize)
        #return(counter,(4*counter-counter2*rev)*boxSize,3*counter)
        return(counter,boxSize*(counter-counter2)-counter2*rev*boxSize,3*counter)
        #return(counter,counter2)
end

#функция ищет двойную вершину или дно и возвращает кол-во. Строго предыдущий экстремум
#статистика - какова вероятность следующего х или о в определенных позициях (близость к лок. или предыдущему экстремуму)
function finddoubletop (pnfdata, boxSize, mek,mer)
        counter=0#счетчик фигур
        maxpro=0#все движение в сторону пробоя
        #проходим последовательно и ищем локальные максимумы
        #точка отсчета
        previousmax=pnfdata[1]
        previousmin=pnfdata[1]

        for i=2:length(pnfdata)-1
                if previousmax<pnfdata[i]#максимум
                        previousmax=
                        if pnfdata[i]>previousmax
                                counter+=1
                                maxpro+=pnfdata[i]-previousmax-boxSize
                        end
                        previousmax=pnfdata[i]

                end
                if pnfdata[i-1]>pnfdata[i]&&pnfdata[i+1]>pnfdata[i]#локальный минимум
                        if pnfdata[i]<previousmin
                                counter+=1
                                maxpro+=previousmin-pnfdata[i]-boxSize
                                #println(previousmin-pnfdata[i]-boxSize)
                        end
                        previousmin=pnfdata[i]
                end
        end
        i+=1
        #доп.проверка последнего значения
        if pnfdata[i]>previousmax
                counter+=1
                maxpro+=pnfdata[i]-previousmax-boxSize
                println("yes")
        end
        if pnfdata[i]<previousmin
                counter+=1
                maxpro+=previousmin-pnfdata[i]-boxSize
                                println("yes")
        end
        return (counter, maxpro)

end
