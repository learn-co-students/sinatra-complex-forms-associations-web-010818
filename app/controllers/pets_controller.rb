class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params[:pet][:name])

    if !params["owner"]["name"].empty?
      new_owner = Owner.create(params["owner"])
      @pet.owner = new_owner
    else
      owner_name = params[:pet][:owner]
      @pet.owner = Owner.find_by(name: owner_name)
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owner = Owner.find(@pet.owner.id)
    erb :'pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.name = params[:pet][:name]
    @pet.owner = Owner.find_by(name: params[:pet][:owner])
    #binding.pry
    #binding.pry
   if !params["owner"]["name"].empty?
      new_owner = Owner.create(params["owner"])
      @pet.owner = new_owner
    else
    #  @pet.owner = Owner.find_by(name: params[:pet][:owner])
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
