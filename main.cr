# Experiment with Dynamic Libraries

# Load header file with run function
@[Link(ldflags: "#{__DIR__}/header.so")]

lib Fun
  fun run(Void*) : Void*
end

# Dynamic library made in Crystal
FILE = "./mandel.so"

def get_timestamp
  File.stat(FILE).mtime.to_s("%Y%m%d%H%M%S")
end

# Load dynamic library
def dynamic
  dlfile = LibC.dlopen(FILE, LibC::RTLD_NOW)
  mandel = LibC.dlsym(dlfile, "mandel")
  if LibC.dlerror
    raise "Error opening #{FILE}"
  end
  {get_timestamp, mandel, dlfile}
end

timestamp, mandel, dlfile = dynamic
Fun.run(mandel)
loop do
  if timestamp != get_timestamp
    LibC.dlclose(dlfile)
    timestamp, mandel, dlfile = dynamic
    Fun.run(mandel)
  end
  sleep 1
end
