class Plugins::Ecc::Admin::CodesController < Plugins::Ecc::AdminController
  before_action :set_code, :set_org, only: ['show','edit','update','destroy']
  include Plugins::Ecc

  def index
    @codes = Codes.paginate(:page => params[:page], :per_page => current_site.admin_per_page)
    render 'codes_index'
  end

  def new
    @code = Codes.new
    @orgs = Orgs.all
    render 'codes_new'
  end

  def show
    render 'codes_show'
  end

  def edit
    render 'codes_edit'
  end

  def create
    new_code = params.require(:code).permit(:code_title, :code_content, :org_id, :code_year)
    @code = Codes.new(new_code)
    r = {code: @code}; hooks_run('code_create', r)
    if @code.save
      r = {code: @code}; hooks_run('code_created', r)
      flash[:notice] = 'New Code created'
      redirect_to action: 'index'
    else
      new
    end
  end
  def destroy
    @code = Codes.find(params[:id])
    @code.destroy
    redirect_to action: 'index'
  end
  def update
    up_code = params.require(:code).permit(:code_title, :code_content)
    if @code.update(up_code)
      redirect_to action: :show
    else
      render 'edit'
    end
  end


  private
  def set_code
    @code = Codes.find(params[:id])
  end
  def set_org
    @org = Orgs.find(@code.org_id)
  end
end
