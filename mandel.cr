# Mandelbrot sample from Crystal source

def print_density(d)
  if d > 8
    print ' '
  elsif d > 4
    print '.'
  elsif d > 2
    print '*'
  else
    print '+'
  end
end

def mandelconverger(real, imag, iters, creal, cimag)
  if iters > 255 || real*real + imag*imag >= 4
    iters
  else
    mandelconverger real*real - imag*imag + creal, 2*real*imag + cimag, iters + 1, creal, cimag
  end
end

def mandelconverge(real, imag)
  mandelconverger real, imag, 0, real, imag
end

def mandelhelp(xmin, xmax, xstep, ymin, ymax, ystep)
  ymin.step(to: ymax, by: ystep) do |y|
    xmin.step(to: xmax, by: xstep) do |x|
      print_density mandelconverge(x, y)
    end
    puts
  end
end

def mandel(realstart, imagstart, realmag, imagmag)
  mandelhelp realstart, realstart + realmag*78, realmag, imagstart, imagstart + imagmag*40, imagmag
end

# `fun` allow communication between header.so and main
# Other `fun` with arguments could be like:
# ```
# fun mandel(realstart : Float64, imagstart : Float64, realmag : Float64, imagmag : Float64) : Void
#   mandel(realstart, imagstart, realmag, imagmag)
# end
# ```
fun mandel : Void
  mandel -2.3, -1.3, 0.05, 0.07
end
