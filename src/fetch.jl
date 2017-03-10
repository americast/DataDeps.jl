module fetch

function getdata(dir,key)
    global urls
    mkpath(dir)
    path = download(url)
    run(unpack_cmd(path,dir,".gz",".tar"))
end

end
