class Plugins::Ecc::Front::SearchController < Plugins::Ecc::FrontController
  include Plugins::Ecc
  def index
  end

  def show
    db_ob =  ActiveRecord::Base.connection
    tokens = params[:q].split(" ");
    token_oq = token_cq = ''
    tokens.each_with_index do |token, i|
      token_oq += "UPPER(name) LIKE '%#{token.upcase}%'"
      token_cq += "UPPER(code_title) LIKE '%#{token.upcase}%'"
      if i != tokens.size - 1
        token_oq += " AND "
        token_cq += " AND "
      end
    end
    @results = Hash.new
    dat = db_ob.exec_query("SELECT name as title, id FROM plugins_ecc_orgs WHERE #{token_oq}")
    if dat.any? then @results[:orgs] =  dat else @results end
  
    dat = db_ob.exec_query("SELECT code_title as title, id FROM plugins_ecc_codes WHERE #{token_cq}")
    if dat.any? then @results[:codes] = dat  else @results end
    render 'ecc/search/search_res'
  end

  def edit
    render 'orgs_edit'
  end
end
