class ArticlesController < ApplicationController
  
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
  
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  # renders form to create new article
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create #saves new article to database using the new.html.erb form
      @article = Article.new(article_params)

# We have to whitelist our controller parameters to prevent wrongful mass assignment. In this case, we want to both allow and require the title and text parameters for valid use of create. 
      if @article.save
      redirect_to @article
      #Create action uses the new "Article" model to save the data in the database.
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  #don't want to create a delete view. redirect to articles index instead
end

private  #strong parameters
  def article_params
    params.require(:article).permit(:title, :text)
  end

end
