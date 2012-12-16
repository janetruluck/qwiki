class PagesController < ApplicationController
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        History.create(
          :page_id => @page.id,
          :user_id => @page.user.id,
          :note => "Initial Creation",
          :current_content => @page.content)
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    history = History.create(
              :page_id          => @page.id,
              :user_id          => @page.user.id,
              :note             => params[:page][:history][:note],
              :previous_content => @page.content)
    params["page"].delete(:history)

    respond_to do |format|
      if @page.update_attributes(params[:page])
        history.update_attributes(:current_content => @page.content)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
    end
  end

  def history
    @page = Page.find(params[:id])
    @histories = History.where(:page_id => params[:id]).order("created_at DESC").group_by{ |item| item.created_at.to_date }

    respond_to do |format|
      format.html
    end
  end

  def diff
    @history = History.find(params[:id])

    @diff = Diffy::Diff.new(@history.previous_content, @history.current_content, :include_plus_and_minus_in_html => true).to_s(:html_simple)


    respond_to do |format|
      format.html
    end
  end
end
