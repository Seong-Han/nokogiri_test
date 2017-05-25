class WebtoonController < ApplicationController
  def index
     #요일 db 작업하는 곳 하지만 요일에 넣는 걸 실패서 노의미 
     yoil = ["월","화","수","목","금","토","일"]
     yoil.each do |x|
       days = Webtoon.new
       days.day = x 
       days.save
    end
    #요일별 웹툰 작업하는 곳
    #webtoon_list db가 뭔가 잘못된듯 이따 확인하자
    
    require 'open-uri'
    doc = Nokogiri::HTML(open("http://comic.naver.com/webtoon/weekday.nhn"))
    webtoon_content = Array.new
    
    if List.count == 0
         doc.css('div.list_area.daily_all > div.col>div.col_inner > ul > li > a').each do |y|
                webtoon_content.push(y.text())
         end
     end
     
     webtoon_content.each do |y|
         lists = List.new
         lists.content = y
         lists.save
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
     