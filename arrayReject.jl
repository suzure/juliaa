#функция оставляет в обеих таблицах только совпадающие строки
#в датасете строчку определяет сочетание date+time
function diffBarSets!(set1,set2)
        excessIndeces=Int64[]#здесь копятся индексы уникальных строк
        #запоминаем, что есть в set1, чего нет в set2 и наоборот
        signSet1=set1[:,1]+set1[:,2]
        signSet2=set2[:,1]+set2[:,2]
        uniqueRows=setdiff(signSet1,signSet2)

        println(length(uniqueRows))
        println(length(set1[:,2]))
        println(length(set2[:,2]))
        #ищем индексы на удаление в set1
        excessIndeces=findin(signSet1,uniqueRows)
        #удаляем уникальное из set1
        newSet1=set1[1:excessIndeces[1]-1,:]
        for i=1:length(excessIndeces)-1
                newSet1=vcat(newSet1,set1[excessIndeces[i]+1:excessIndeces[i+1]-1,:])
        end
        #println(length(newSet1))
        set1=newSet1
        #ищем индексы на удаление в set2
        excessIndeces=findin(set2[:,1+2],uniqueSet1Rows)
        #удаляем уникальное из set2
        newSet2=set2[1:excessIndeces[1]-1,:]
        for i=1:length(excessIndeces)-1
                newSet2=vcat(newSet1,set2[excessIndeces[i]+1:excessIndeces[i+1]-1,:])
        end
        #println(length(newSet2))
        set2=newSet2
end

