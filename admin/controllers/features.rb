Admin.controllers :features do

  get :index do
    @unsorted_features = Feature.all
    @features = @unsorted_features.sort_by { |feature| feature.vote_count }
    @features = @features.reverse_each
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
    @feature.created = Time.new
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
  
  helpers do
    def tr_voted(votes)
      votes.sort_by! { |vote| vote.date }
      votes.reverse_each do |vote| #order votes by newest to oldest
        if (vote.account_id == current_account.id) # if we find a vote for the current user
          if (vote.credits > 0) # and that vote is for a positive number
            return 'background-color:rgb(144, 238, 144)' # return the new color for the row
          end
          return
        end
      end
      nil
    end
  end
end