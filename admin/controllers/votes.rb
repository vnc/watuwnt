Admin.controllers :votes do

  get :index do
    @votes = Vote.all
    render 'votes/index'
  end

  get :new do
    @vote = Vote.new
    render 'votes/new'
  end

  post :create do
    @vote = Vote.new(params[:vote])
    if @vote.save
      flash[:notice] = 'Vote was successfully created.'
      redirect url(:votes, :edit, :id => @vote.id)
    else
      render 'votes/new'
    end
  end

  get :edit, :with => :id do
    @vote = Vote.get(params[:id])
    render 'votes/edit'
  end

  put :update, :with => :id do
    @vote = Vote.get(params[:id])
    if @vote.update(params[:vote])
      flash[:notice] = 'Vote was successfully updated.'
      redirect url(:votes, :edit, :id => @vote.id)
    else
      render 'votes/edit'
    end
  end

  delete :destroy, :with => :id do
    vote = Vote.get(params[:id])
    if vote.destroy
      flash[:notice] = 'Vote was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Vote!'
    end
    redirect url(:votes, :index)
  end
end