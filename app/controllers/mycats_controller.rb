class MycatsController < ApplicationController
  before_action :set_cat, only: %i[ show edit update ]
  def new
    @cat = Cat.new
  end

  def show; end

  def create
    @cat = current_user.build_cat(cat_params)
    if @cat.save
      redirect_to profile_mycat_path, success: t('.success')
    else
      flash.now[:error] = t('.fail')
      render :new
    end
  end

  def edit; end

  def update
    if @cat.update(cat_params)
      redirect_to profile_mycat_path, success: t('.success')
    else
      flash.now[:error] = t('.fail')
      render :edit
    end
  end

  private

  def set_cat
    @cat = current_user.cat
  end

  def cat_params
    params.require(:cat).permit(:name, :sex, :character, :birth_date, :avatar)
  end
end
