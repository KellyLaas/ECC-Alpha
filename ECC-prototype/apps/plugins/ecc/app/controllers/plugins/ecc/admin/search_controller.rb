class Plugins::Ecc::Admin::SearchController < Plugins::Ecc::AdminController
  include Plugins::Ecc
  def index

  def new
  end

  def show
    db_ob 
    render 'orgs_show'
  end

  def edit
    render 'orgs_edit'
  end
