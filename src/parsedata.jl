function readMat(data::Vector{UInt8})
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
function readLine(dir, files)
  lines = open(readlines, joinpath(dir,files[1]))
  x=map(l -> Vector{String}(split(chomp(l))), lines)
  y=copy(x) #Needs improvement
  x, y
end
