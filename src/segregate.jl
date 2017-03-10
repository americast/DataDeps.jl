module segregate


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

function segdata(name::AbstractText, dir="")
    if(dir=="")
      dir=joinpath(Pkg.dir("DataDeps"), "datasets/$(name)")
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
        if (flag==1) i+=1 end
        for i in (s_start:s_end)
            file="$(dir)/$(s_name[1:i-1])"
            file*="$(i)"
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
    all(isfile, files) || getdata(dir)
    data = UInt8[]
    for file in files
        append!(data, open(read,file))
    end
    readdata(data)
end

function traindata(name::AbstractText, dir="")
    segdata(name,dir)
end

function testdata(name::AbstractText, dir="")
    segdata(name,dir)
end
