class Point
  attr_accessor :x, :y, :on
  def initialize(x,y,on=false)
    @x = x
    @y = y
    @on = on
  end
  def inspect
    "(#{@x}, #{@y}, #{@on ? 'On' : 'Off'})"
  end
end

def point_to_rep(pt)
  x_bool = (pt.x == 0)
  y_bool = (pt.y == 0)
  if pt.on
    "*"
  elsif x_bool and y_bool
    "+"
  elsif x_bool
    "|"
  elsif y_bool
    "-"
  else
    " "
  end
end

def make_rows(f, minx, maxx, miny, maxy, step)
  norm = Proc.new {|i| Integer(i/step)}
  minx = norm.call(minx)
  maxx = norm.call(maxx)
  miny = norm.call(miny)
  maxy = norm.call(maxy)
  rows = []

  maxy.downto miny do |y|
    row = []
    minx.upto maxx do |x|
      row.push Point.new(x, y, false)
    end
    rows.push row
  end

  minx.upto(maxx) do |x|
    fval = f.call x
    if fval <= maxy && fval >= miny
      rows[maxy - fval.round][maxx + x].on = true
    end
  end
  rows
end

def vis_func(f, minx, maxx, miny, maxy, step)
  rows = make_rows f, minx, maxx, miny, maxy, step
  rows.each do |row|
    row.each do |pt|
      print point_to_rep pt
    end
    puts
  end
  nil
end

def prompt(*args)
  print(*args)
  gets
end

f = eval('lambda {|x| ' + prompt("f(x) = ") + '}')
maxx = Integer(prompt "Please enter a maximum x value: ")
minx = Integer(prompt "Please enter a minimum x value: ")
maxy = Integer(prompt "Please enter a maximum y value: ")
miny = Integer(prompt "Please enter a minimum y value: ")
step = Float(prompt "Please enter a step value: ")
vis_func(f, minx, maxx, miny, maxy, step)
