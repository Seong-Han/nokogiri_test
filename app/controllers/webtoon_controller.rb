class WebtoonController < ApplicationController
  def index
    require 'open-uri'
    doc = Nokogiri::HTML(open("http://comic.naver.com/webtoon/weekday.nhn"))
    webtoon_content = Array.new
    webtoon_image = Array.new

  if List.count == 0
    #이름
         doc.css('div.list_area.daily_all > div.col>div.col_inner > ul > li > a').each do |y|
                webtoon_content.push(y.text())
         end
    #url     
         doc.css('div.list_area.daily_all > div.col>div.col_inner > ul > li > div.thumb').each do |x|
             count = 0
             x.css('a > img').each do |y|
                 if count>0
                   break
                 else
                  webtoon_image.push(y.attr('src'))
                  count += 1
                 end
             end
         end
  end  
   
    
     count = webtoon_content.length
     for i in (0..count-1)
      webtoon = List.new
      webtoon.content = webtoon_content[i]
      webtoon.url = webtoon_image[i]
      webtoon.save
     end
   

     @content = List.all
  
     
      
         
  end

  def create
  end

  def destroy
      @one_webtoon = List.find(params[:id])
      @one_webtoon.destroy
      redirect_to :root
  end

  def edit
      @some_webtoon = List.find(params[:id])
    
      
  end

  def update
      @some_webtoon = List.find(params[:id])
      @some_webtoon.content = params[:content]
      @some_webtoon.save
      redirect_to :root
  end
end
     