get '/' do
  # let user create new short URL, display a list of shortened URLs
  @urls = Url.all
  erb :index
end

post '/urls' do
  p @long_url = params[:url]
  @url = Url.create(:url       => @long_url)
  @urls = Url.all
  erb :index
end

get '/:short_url' do
  p params[:short_url].inspect
  p @url = Url.find_by_url_short(params[:short_url])
  # p click_plus = @url.click_count + 1
  @url.increment!(:click_count)
  # @url.update_attributes(:click_count => click_plus)

  redirect to("http://#{@url.url}")
 
end

