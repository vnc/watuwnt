Admin.controllers :votes do

  helpers do
    def json_status(code, reason)
      status code
      {
        :status => code,
        :reason => reason
      }.to_json
    end
  end

  get :index do
    @votes = Vote.all
    render 'votes/index'
  end

  get :new do
    @vote = Vote.new
    render 'votes/new'
  end

  post :create, :provides => :json do
    content_type :json
    
    @vote = Vote.new()
    @vote.credits = params[:credits]
    @vote.feature_id = params[:feature_id]
    @vote.date = Time.new
    @vote.account_id = current_account.id
    if @vote.save
      #flash[:notice] = 'Vote was successfully created.'
      status 201 # created
      {
        :status => 201,
        :new_vote_count => Feature.get(@vote.feature_id).vote_count,
        :user_balance => 0,
        :vote => @vote
      }.to_json
    else
      json_status 400, @vote.errors.to_hash
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