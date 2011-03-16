Admin.controllers :features do

  get :index do
    @features = Feature.all
    render 'features/index'
  end

  get :new do
    if !current_account.is_admin?
      flash[:error] = 'Contact admin to add new feature.'
      redirect url(:features, :index)
    end
    @feature = Feature.new
    @accounts = Account.all
    render 'features/new'
  end

  post :create do
    if !current_account.is_admin?
      flash[:error] = 'Contact admin to add new feature.'
      redirect url(:features, :index)
    end
    @feature = Feature.new(params[:feature])
    if @feature.save
      flash[:notice] = 'Feature was successfully created.'
      redirect url(:features, :edit, :id => @feature.id)
    else
      @accounts = Account.all
      render 'features/new'
    end
  end

  get :edit, :with => :id do
    if !current_account.is_admin?
      flash[:error] = 'Contact admin to edit feature.'
      redirect url(:features, :index)
    end
    @feature = Feature.get(params[:id])
    @accounts = Account.all
    render 'features/edit'
  end

  put :update, :with => :id do
    @feature = Feature.get(params[:id])
    if @feature.update(params[:feature])
      flash[:notice] = 'Feature was successfully updated.'
      redirect url(:features, :edit, :id => @feature.id)
    else
      render 'features/edit'
    end
  end

  delete :destroy, :with => :id do
    if !current_account.is_admin?
      flash[:error] = 'Contact admin to delete feature.'
      redirect url(:features, :index)
    end
    feature = Feature.get(params[:id])
    if feature.destroy
      flash[:notice] = 'Feature was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Feature!'
    end
    redirect url(:features, :index)
  end
end