class Admin::ToysController < Admin::BaseController
  before_action :set_search_form, only: %i[ index ]
  before_action :set_toy, only: %i[ show edit update destroy ]

  def index
    @toys = @search_toy.search
  end

  def new; end

  def create
    if params[:category].present?
      category = Category.find_by(name: params[:category])
      case params[:shop]
        when 'Cainz' then @toy = category.cainzs.new(toy_params_for_create)
        when 'Rakuten' then @toy = category.rakutens.new(toy_params_for_create)
      end
      if @toy.save
        redirect_to admin_toy_path(@toy, shop: @toy.model_name.name), success: t('defaults.message.create', item: 'おもちゃ')
      else
        flash.now[:error] = t('defaults.message.fail_create', item: 'おもちゃ')
        render :new
      end
    else
      flash.now[:error] = t('defaults.message.fail_create', item: 'おもちゃ')
      render :new
    end
  end

  def show; end

  def edit; end

  def update
   if @toy.update(toy_params)
    redirect_to admin_toy_path(@toy, shop: @toy.model_name.name), success: t('defaults.message.update', item: 'おもちゃ')
   else
    flash.now[:error] = t('defaults.message.fail_update', item: 'おもちゃ')
    render :edit
   end
  end

  def destroy
    @toy.destroy!
    redirect_to admin_toys_path, success: t('defaults.message.destroy', item: 'おもちゃ')
  end

  private

  def set_search_form
    @search_toy = SearchToysForm.new(search_params)
  end

  def search_params
    params.fetch(:q, {}).permit(:shop_name, :toy_name)
  end

  def set_toy
    case params[:shop]
      when 'Cainz' then @toy = Cainz.find(params[:id])
      when 'Rakuten' then @toy = Rakuten.find(params[:id])
    end
  end

  def toy_params
    case params[:shop]
      when 'Cainz' then params.require(:cainz).permit(:name, :url, :image)
      when 'Rakuten' then params.require(:rakuten).permit(:name, :url, :image)
    end
  end

  def toy_params_for_create
    case params[:shop]
      when 'Cainz' then params.permit(:name, :url, :image)
      when 'Rakuten' then params.permit(:name, :url, :image)
    end
  end
end
