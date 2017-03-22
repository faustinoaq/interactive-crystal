@[Link(ldflags: "#{__DIR__}/header.so")]

lib Fun
  fun run(Void*) : Void*
end

FILE = "./mandel.so"

def get_timestamp
  File.stat(FILE).mtime
end

def dynamic
  dlfile = LibC.dlopen(FILE, LibC::RTLD_NOW)
  mandel = LibC.dlsym(dlfile, "mandel")
  if LibC.dlerror
    raise "Error opening #{FILE}"
  end
  {get_timestamp, mandel, dlfile}
end

timestamp, mandel, dlfile = dynamic
loop do
  Fun.run(mandel)
  sleep 1
  if timestamp != get_timestamp
    LibC.dlclose(dlfile)
    timestamp, mandel, dlfile = dynamic
  end
end
