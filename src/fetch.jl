using BinDeps

function getdata(dir::AbstractString,name::AbstractString, url::AbstractString)
    mkpath(dir)
    println(url)
    path = download(url)
    run(unpack_cmd(path,dir,".gz",".tar"))
    dirnext=readdir(dir)[1]
    dirnext=joinpath(dir,dirnext)
    if(isdir(dirnext))
        dir=dirnext
    end
    dictall = Dict()
    cd(joinpath(Pkg.dir("DataDeps"),"datasets"))
    try
        f=open("downloads.json", "r")
        dicttxt = readall(f)
        close(f)
        dictall=JSON.parse(dicttxt)
    end
    dictall[name]=dir
    stringdata = JSON.json(dictall)
    f=open("downloads.json", "w")
    write(f, stringdata)
    close(f)
end
