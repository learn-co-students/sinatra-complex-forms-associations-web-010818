class PetsController < ApplicationController

  ##READ
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  ##NEW
  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty? ##If not empty, create the new owner
      @owner = Owner.create(params["owner"])
      @owner.pets << @pet
    end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  ##UPDATE
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params["pet"]["name"])

    ## Now update owner
    if !params["owner"]["name"].empty? ## New Owner specified
      @owner = Owner.create(params["owner"])
    else ## Existing owner specified
      @owner = Owner.find(params["pet"]["owner_id"].to_i)
    end

    @owner.pets << @pet

    redirect to "pets/#{@pet.id}"
  end

  ##DELETE
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

end
