Admin.controllers :users do

  get :index do
    @users = User.all
    render 'users/index'
  end

  get :new do
    @user = User.new
    render 'users/new'
  end

  post :create do
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect url(:users, :edit, :id => @user.id)
    else
      render 'users/new'
    end
  end

  get :edit, :with => :id do
    @user = User.get(params[:id])
    render 'users/edit'
  end

  put :update, :with => :id do
    @user = User.get(params[:id])
    if @user.update(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect url(:users, :edit, :id => @user.id)
    else
      render 'users/edit'
    end
  end

  delete :destroy, :with => :id do
    user = User.get(params[:id])
    if user.destroy
      flash[:notice] = 'User was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy User!'
    end
    redirect url(:users, :index)
  end
end