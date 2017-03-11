using BinDeps

function getdata(dir::AbstractString="",name::AbstractString="", url::AbstractString="")
    if (url=="")
      println("Enter URL: ")
      url=chomp(readline(STDIN))
    end
    if (name=="")
      println("Enter name of the dataset: ")
      name=chomp(readline(STDIN))
    end
    if(dir=="")
        dir=joinpath(Pkg.dir("DataDeps"), "datasets/$(name)")
    end
    mkpath(dir)
    println(url)
    path = download(url)
    run(unpack_cmd(path,dir,".gz",".tar"))
    if(isdir(readdir(dir)[1]))
        dirnext=readdir(dir)[1]
        dir=joinpath(dir,dirnext)
    end
    dictall = Dict()
    cd(joinpath(Pkg.dir("DataDeps"),"datasets"))
    try
        f=open("downloads.json", "r")
        dicttxt = readall(f)
        f.close()
        dictall=JSON.parse(dicttxt)
    end
    dictall[name]=dir
    stringdata = JSON.json(dictall)
    f=open("downloads.json", "w")
    write(f, stringdata)
    close(f)
end
