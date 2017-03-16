module DataDeps

import JSON
include("./segregate.jl")
export add, list, traindata, testdata, setseries

function add(url::AbstractString, name::AbstractString, dir::AbstractString="")
    if (dir=="")
        dir=joinpath(Pkg.dir("DataDeps"), "datasets/$(name)")
    end
    getdata(dir, name, url)
    return 0
end

function list(dir::AbstractString="")
    dirhere=joinpath(Pkg.dir("DataDeps"), "datasets")
    if (dir=="")
        dir=dirhere
    end
    dictall=Dict()
    try
        f=open(joinpath(dirhere, "downloads.json"), "r")
        dicttxt = readstring(f)
        close(f)
        dictall=JSON.parse(dicttxt)
    end
    textout=""
    for i in dictall
        if (dir==i[2][1:length(dir)])
            textout*="$(i[1])\n"
        end
    end
    println(textout)
    return textout
end

end #module
