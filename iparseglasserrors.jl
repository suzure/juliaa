#я выясняю, изменилось ли что-то в точности тегирования, на основе размеров отчетов об ошибках
#в итоге получаю массив, который загоню в эксель: дата, размер, особенности
#что интересует: особенности
#получаю список файлов из архива, создаю массив, в который последовательно пишу дату и размер.
        path="C:\\work\\архив\\ошибки тегирования\\"
        fileNames = readdir(path)
        #проходим по списку и для каждого файла запоминаю дату и размер
        xxx=Array((Float64,Int64),0)

    #    println(typeof(stat(string(path,fileNames[1])).ctime))
    #    println(typeof(stat(string(path,fileNames[1])).size))
    #    push!(xxx,(stat(string(path,fileNames[1])).ctime,stat(string(path,fileNames[1])).size))
     #   println(xxx)
     #   push!(xxx,(3,3))
      #  println(xxx)
 #  println(unix2datetime(stat(string(path,fileNames[1])).ctime))

     #   println(unix2datetime(stat(string(path,fileNames[1]).ctime))

        for i=1:length(fileNames)
               push!(xxx,(stat(string(path,fileNames[i])).ctime,stat(string(path,fileNames[i])).size))
        end
        println(length(xxx))
        #println(string(path,fileNames[1]))
        #ctime(file) stat(file).ctime
        #filesize(path...) stat(file).size
