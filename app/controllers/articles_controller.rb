# frozen_string_literal: true

class ArticlesController < ApplicationController
  respond_to :html, :xml, :json, :od
  before_action :get_article, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show index]

  #  around_action :wrap_in_transaction, only: :show

  def index
    @articles = Article.all.order('created_at DESC')
    respond_with @articles
  end

  def show
    respond_to do |format|
      format.html
      format.pdf { render pdf: generate_pdf(@article) }
      format.json { render json: @article }
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_params
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy

    redirect_to articles_path
  end

  private

  def generate_pdf(article)
    Prawn::Document.new do
      text article.title, align: :center
      text "Body: #{article.text}"
    end.render
    end

  def get_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text)
  end

  # def wrap_in_transaction
  #   ActiveRecord::Base.transaction do
  #     begin
  #       yield
  #     ensure
  #       raise ActiveRecord::Rollback
  #     end
  #   end
  # end
end
