class MainController < ApplicationController
  def test
    @amount= params[:amount].to_i
    @subject_check = params[:subject_check]
    @score_check = params[:score_check]
  end

  def test1
   
   
   
    @total= params[:total]
    @subject= params[:sub]
   
  
  end

  def test2
    
    @subject= params[:subject]
    @score= params[:score]
    @z=0
    check=false
    @score_check=Array.new
    @subject_check=Array.new
    
    while @z < @score.length
      if(@score[@z]=="")
        check=true
        @score_check.append(@z+1)
        
      end
      if(@subject[@z]=="")
        check=true 
        @subject_check.append(@z+1) 
        
        
      end
      @z+=1
    end
    if(check) 
      redirect_to("/main/test/?amount=#{@subject.length()}&subject_check=#{@subject_check}&score_check=#{@score_check}")
    else
      @total = 0
   @x = 0 
   @max = @score[0].to_i
   @max_sub=@subject[0]
   
   while @x < @score.length
    @total=@total+@score[@x].to_i  
    
    #hw5
    @allSubjects = Subject.where(name: @subject[@x])
    if(@allSubjects.empty?)
      Subject.create(name: @subject[@x], score: @score[@x])
    else
      for s in @allSubjects
        s.update(score:@score[@x])
      end
    end 
    @x+=1  
    
   end
   @y=1
   while @y < @score.length
    
    
    if(@max<@score[@y].to_i)
      @max=@score[@y].to_i
      @max_sub=@subject[@y]
    end
    @y+=1
    
    
   end
      redirect_to("/main/test1/?sub=#{@max_sub}&total=#{@total}")
       
    
    end


     
  end

  def test3
    
  end

  def test4
    @allSubjects = Subject.all
    @total = 0
   @x = 0 
   @max = @allSubjects[0].score.to_i
   @max_sub=@allSubjects[0].name
   
   while @x < @allSubjects.length
    @total=@total+@allSubjects[@x].score.to_i  
    @x+=1  
    
   end
   @y=1
   while @y < @allSubjects.length
    
    
    if(@max<@allSubjects[@y].score.to_i)
      @max=@allSubjects[@y].score.to_i
      @max_sub=@allSubjects[@y].name
    end
    @y+=1
    
    
   end
  end

  def delete
    @id= params[:id].to_i
    s=Subject.find_by(id: @id)
    s.destroy
    redirect_to("/score/list")
  end

  def edit
    @id= params[:id].to_i
    @s= Subject.find_by(id: @id)
    @name = @s.name
    @score = @s.score
  end

  def save
    @id = params[:id].to_i
    @name = params[:name]
    @score = params[:score].to_i
    s=Subject.find_by(id: @id)
    s.update(name: @name, score: @score)
    redirect_to('/score/list')
  end
end
