class PagesController < ApplicationController
  before_filter :set_book
  before_filter :set_page, :except => [:create_multiple]
  
  before_filter :check_authenticated
  before_filter :check_has_page_in_book, :except => [:create_multiple]
  before_filter :check_page_owner, :only => [:edit, :update]
  before_filter :check_book_owner, :only => [:destroy, :create_multiple]
  
  include ActionView::Helpers::TextHelper
  
  def check_has_page_in_book
    @page.book.has_page_for_user?(current_user) ? true : redirect_to(@book)
  end

  def check_page_owner
    @page.owner?(current_user) ? true : redirect_to(@book)
  end

  def check_book_owner
    @book.owner?(current_user) ? true : redirect_to(@book)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end
  
  def set_page
    @page = Page.find(params[:id])
  end
  
  # GET /pages/1
  # GET /pages/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @book.next_step if @page.book.owner?(current_user) && @page.owner?(current_user) && @book.progress < 3
    redirect_to [@book, @page] unless @page.updateable?
  end
  
  def create_multiple
    emails = params[:emails].split(",").map {|email| email.strip }
    users = []
    emails.each do |email|
      user = User.create(:email => email, :name => 'Ich')
      page = Page.new
      page.book = @book
      page.user = user
      page.save
      UserMailer.welcome_email(user,@book).deliver if user.has_valid_email?
      users << user
    end

    respond_to do |format|
      @book.next_step if @book.in_progress?

      @users_with_mail = users.select {|u| u.has_valid_email? }.size.to_i
      notice = pluralize(@users_with_mail, 'Freund wurde', 'Freunde wurden') + " automatisch eingeladen."
      notice += " Den anderen musst du selbst Bescheid geben. Den Code findest du auf der entsprechenden Buchseite." if (users.size-@users_with_mail) > 0
                
      format.html { redirect_to(@book, :notice => notice) }
    end    
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    redirect_to([@book, @page]) && return unless @page.updateable?
    
    respond_to do |format|
      if @page.update_attributes(params[:page])
        @page.update_values(params[:fields])
        @page.updated_at = Time.now
        @page.save
        
        if @book.owner?(current_user) && @page.owner?(current_user) && @book.user.has_valid_email?
          UserMailer.send_key_email(@book).deliver
        end
        
        if @book.in_progress?
          @book.next_step if @book.progress < 4
          format.html { redirect_to(@book, :notice => 'Deine Seite wurde gespeichert.') }
        else 
          format.html { redirect_to([@book,@page], :notice => 'Deine Seite wurde gespeichert.') }
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(@book) }
      format.xml  { head :ok }
    end
  end
end
