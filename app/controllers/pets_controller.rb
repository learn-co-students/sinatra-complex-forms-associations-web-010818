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
    @pet = Pet.create(params[:pet])
    if params[:owner][:owner_id] != nil
      @owner = Owner.find(params[:owner][:owner_id])
      @owner.pets << @pet
      @owner.save
    elsif params[:owner][:name] != nil
      @owner = Owner.create(params[:owner])
      @owner.pets << @pet
      @owner.save
    else
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owner = Owner.all
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    @pet.save
    if !params[:owner_name].empty?
      @owner = Owner.create(name: params[:owner_name])
      @owner.pets << @pet
      @owner.save
    elsif !params[:pet][:owner_id].empty? && params[:pet][:owner_id].to_s != @pet.owner_id
      @owner = Owner.find(params[:pet][:owner_id])
      @owner.pets << @pet
      @owner.save
    end
    redirect to "pets/#{@pet.id}"
  end
end
