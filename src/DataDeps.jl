module DataDeps

import JSON
include("./segregate.jl")
export add, list, traindata, testdata

function add()
    #=
    println("Enter URL: ")
    url=chomp(readline(STDIN))
    println("Enter name of the dataset: ")
    name=chomp(readline(STDIN))
    dirhere=joinpath(Pkg.dir("DataDeps"), "datasets/$(name)")
    =#
    getdata()
end

function list(dir::AbstractString)
  dirhere=Pkg.dir("DataDeps")
  if (list!="")
    dirhere=dir
  end
  run(`ls $(dirhere)`)
end

end #module
