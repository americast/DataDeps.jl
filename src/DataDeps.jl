module DataDeps
urls=Dict(
  "CIFAR-10"  =>	"https://www.cs.toronto.edu/~kriz/cifar-10-binary.tar.gz",
  "CIFAR-100" =>	"https://www.cs.toronto.edu/~kriz/cifar-100-binary.tar.gz",
)

function getdata(dir,key)
    global urls
    mkpath(dir)
    path = download(urls[key])
    run(unpack_cmd(path,dir,".gz",".tar"))
end

function search(text::AbstractString)
    for i in urls
        if (contains(i[1],text))
            println("Found $(i[1]). Continue (Y/N)?")
            choice=readline(STDIN)
            if (choice[1]=='y' || choice[1]=='Y')
                dirhere=joinpath(Pkg.dir("DataDeps"), "datasets/$(i[1])")
      	        getdata(dirhere,i[1])
            end
        end
    end
end
end # module
