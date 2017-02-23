class FiguresController < ApplicationController

  get '/figures/new' do
    erb :'figures/new'
  end

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if !params[:landmark][:name].empty?
      params[:landmark][:figure_id] = @figure.id
      @landmark = Landmark.create(params[:landmark])
      @figure.landmarks << @landmark
      @figure.save
    end
    redirect to "/figures/#{@figure.id}"
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if !params[:landmark][:name].empty?
      params[:landmark][:figure_id] = @figure.id
      @landmark = Landmark.create(params[:landmark])
      @figure.landmarks << @landmark
    end
    if !params[:title][:name].empty?
      @title = Title.create(params[:title])
      @figure.titles << @title
    end
    @figure.save
  end

end
