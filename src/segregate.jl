include("./fetch.jl")
include("./parsedata.jl")
choice=0; s_start=1; s_end=-1; s_name=""
function setseries(name::AbstractString, ch::AbstractString="single", st::Int64=1,  en::Int64=-1)
    global choice, s_start, s_end, s_name
    s_name=name
    if (ch=="series")
        choice=1
    elseif (ch=="single")
        choice=2
    else
        error("Pl. set type as \"single\" or \"series\" only.")
    end
    s_start=st
    s_end=en
    return 0
end

function segdata(name::AbstractString, typedata::AbstractString, dir::AbstractString)
    s_start=1; s_end=-1; s_name=""; files=[]
    if (choice==1)
        i=0; flag=0
        for i in 1:length(s_name)
            if s_name[i]=='*'
                flag=1
                break
            end
        end
        if (flag==0) i+=1 end
        for j in (s_start:s_end)
            file="$(dir)/$(s_name[1:i-1])"
            file*="$(j)"
            file*="$(s_name[i+1:end])"
            push!(files,file)
        end
    elseif (choice==2)
        files=["$(s_name)"]
    else
        error("Please call setseries() first.")
        return
    end
    fileflag=0
    for file in readdir(dir)
        if (isfile(joinpath(dir,file)))
            fileflag=1
            break
        end
    end
    if(fileflag==0)
        error("Please call add(<url>) to download dataset first.")
    end
    data = UInt8[]
    for file in files
        append!(data, open(read,file))
    end
    if (typedata=="matrix")
      readMat(data)
    else
      readLine(dir, files)
    end
end

function traindata(name::AbstractString, typedata::AbstractString="matrix", dir::AbstractString="")
    if(dir=="")
      dir=joinpath(Pkg.dir("DataDeps"), "datasets/$(name)")
    end
    try
        f=open(joinpath(Pkg.dir("DataDeps"),"datasets/downloads.json"), "r")
        dicttxt = readstring(f)
        close(f)
        dictall=JSON.parse(dicttxt)
        dir=dictall[name]
    end
    segdata(name,typedata,dir)
end
#=
function testdata(name::AbstractString, dir="")
    segdata(name,dir)
end
=#
