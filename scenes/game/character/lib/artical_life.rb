include Math
#^‚ñ’†‚É‚«‚½‚ç”š”­‚·‚éd‘g‚İ
class Artical_life
 def initialize(x,y,c,car)
  @x=x
  @y=y
  @gun_img=Image.new(16,16,[255, 238, 44, 44])
  @flag=nil
  @cnt=c
  @car=car
 end

 def move
  if @flag
   return 
  end
  if @cnt==1
    @cnt=0
    array=Array.new()
    12.times do |n|
     array.push(Artical_life.new(@x,@y,50,n*(2*3.141592)/12))
    end
    return array
  elsif @cnt==0
    return Array.new
  end
  r=(@x-Window.width/2)**2+(@y-Window.height/2)**2

  if  sqrt(r) < @cnt
    @x=sqrt(r+40)*cos(@car)+Window.width/2
    @y=sqrt(r+40)*sin(@car)+Window.height/2
  end
  if sqrt(r).to_i==@cnt
    @flag=1
    array= Array.new()
    array.push(Artical_life.new(@x,@y,100,@car))
    return array
  end
 end

 def draw
  Window.draw(@x, @y, @gun_img) 
 end
 def x
  return @x
 end
 def y
  return @y
 end
end