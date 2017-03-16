using DataDeps
using Base.Test

@testset "Downloading and unpacking" begin
  @test DataDeps.add("https://www.cs.toronto.edu/~kriz/cifar-10-binary.tar.gz", "test") == 0
end


@testset "List" begin
  @test DataDeps.list()=="test\n"
end

x=0; y=0
@testset "Segregate" begin
  @test DataDeps.setseries("data_batch_*.bin", "series", 1, 5)==0
  global x,y
  x,y=DataDeps.traindata("test")
end

println("X: ")
println(x)
println("Y: ")
println(y)
