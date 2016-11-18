class Plugins::Ecc::Front::OrgsController < Plugins::Ecc::FrontController
  include Plugins::Ecc
  def index
    @orgs = Orgs.paginate(:page => params[:page], :per_page =>current_site.admin_per_page).order('name DESC')
    render 'ecc/orgs/index'
  end

  def show
    @org = Orgs.find(params[:id])
    @codes = Codes.where("org_id = ?", @org.id)
    render 'ecc/orgs/show'
  end
  private
  def ecc_params
    params.require(:ecc).permit(:id);
  end

end
