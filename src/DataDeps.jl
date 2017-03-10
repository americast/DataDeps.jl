export DataDeps

module DataDeps

include("fetch.jl")
include("segregate.jl")

function add()
    println("Enter URL: ")
    url=readline(STDIN)
    println("Enter name of the dataset: ")
    name=readline(STDIN)
    dirhere=joinpath(Pkg.dir("DataDeps"), name)
    getdata(name, url)
end

function list(dir::AbstractText)
  dirhere=Pkg.dir("DataDeps")
  if (list!="")
    dirhere=dir
  end
  run(`ls $(dirhere)`)
end
  

end #module
