class OwnersController < ApplicationController

  ## READ
  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end


  ## NEW
  get '/owners/new' do
    @pets = Pet.all

    erb :'/owners/new'
  end

  post '/owners' do
    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    @owner.save
    redirect to "owners/#{@owner.id}"
  end

  ## UPDATE
  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  post '/owners/:id' do
    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect to "owners/#{@owner.id}"
  end

  ## DELETE
  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  delete '/owners/:id/delete' do
    binding.pry
    @owner = Owner.find(params[:id])
    @owner.delete
    erb '/owners'
  end
end
