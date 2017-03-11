# DataDeps
--------------
WORK IN PROGRESS
--------------

This project involves building a “BinDeps.jl for data” which would make the creation of data-providing packages easier. The package would make it easy to download / unzip large files and check their integrity them in a cross-platform way. Facilities for downloading specific datasets can then be built on top of this.

Now the package is developed in a question-answer menu driven model. This will be changed once the documentation with proper syntax is developed.

#Sample usage

`using DataDeps`  
`DataDeps.add()`  
`https://www.cs.toronto.edu/~kriz/cifar-10-binary.tar.gz`  
`test`  
`x,y = DataDeps.traindata("test")`  
`1`  
`1`  
`5`  
`data_batch_*.bin`  
