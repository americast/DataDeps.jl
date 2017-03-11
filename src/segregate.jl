include("./fetch.jl")

function readdata(data::Vector{UInt8})
    n = Int(length(data)/3073)
    x = Array(Float64, 3072, n)
    y = Array(Int, n)
    for i = 1:n
        k = (i-1) * 3073 + 1
        y[i] = Int(data[k])
        x[:,i] = data[k+1:k+3072] / 255
    end
    x = reshape(x, 32, 32, 3, n)
    x, y
end

function segdata(name::AbstractString, dir="")
    if(dir=="")
      dir=joinpath(Pkg.dir("DataDeps"), "datasets/$(name)")
    end
    println("Train data in series or single file ?\n1) Series\n2) Single\n")
    choice=parse(Int,readline(STDIN))
    s_start=1; s_end=-1; s_name=""; files=[]
    if (choice==1)
        println("Series start: ")
        s_start=parse(Int,readline(STDIN))
        println("Series end: ")
        s_end=parse(Int,readline(STDIN))
        println("Series name, replace iteration with *: ")
        s_name=chomp(readline(STDIN))
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
        println("Single name: ")
        s_name=readline(STDIN)
        files=["$(s_name)"]
    else
        println("Invalid choice")
        return
    end
    fileflag=0
    for file in readdir(dir)
        println(file)
        if (isfile(joinpath(dir,file)))
            fileflag=1
            break
        end
    end
    if(fileflag==0)
        getdata()
    end
    data = UInt8[]
    for file in files
        append!(data, open(read,file))
    end
    readdata(data)
end

function traindata(name::AbstractString, dir="")
    try
        f=open(joinpath(Pkg.dir("DataDeps"),"datasets/downloads.json"), "r")
        dicttxt = readstring(f)
        close(f)
        dictall=JSON.parse(dicttxt)
        dir=dictall[name]
    end
    segdata(name,dir)
end
#=
function testdata(name::AbstractString, dir="")
    segdata(name,dir)
end
=#
