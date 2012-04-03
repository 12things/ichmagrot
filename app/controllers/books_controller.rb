class BooksController < ApplicationController
  before_filter :check_authenticated, :except => [:new, :create, :show, :imprint]
  before_filter :set_book, :except => [:new, :create, :imprint]
  before_filter :authorize,  :except => [:new, :create, :show, :imprint]
  
  def authorize
    @book.owner?(current_user) ? true : redirect_to(book_path(@book))
  end

  def set_book
    @book = Book.find(params[:id])
  end
  
  def imprint
    
  end

  # GET /books/1
  # GET /books/1.xml
  def show
    unless params[:authkey].blank?
      redirect_to(login_path({:book_id => @book.id, :key => params[:authkey]}))
      return
    end

    unless params[:skip_step].blank?
      @book.next_step
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
      format.json  { render :json => @book }
    end
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    @book = Book.new
    @templates = Templates.get_all
    @selected_template_id = @templates.first[:id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # POST /books
  # POST /books.xml
  def create
    @book = Book.new(params[:book])
    template = Templates.get_by_id(params[:template_id])
    
    @book.template = template[:id]
    @book.field_ids = template[:field_ids] if template[:field_ids]
    
    respond_to do |format|
      if @book.save
        user = User.create({:name => 'Ich'})
        user.books << @book
        page = Page.new
        page.user = user
        page.save
        @book.pages << page
        authenticate @book.user.key
        
        if @book.owner? current_user
          @book.next_step
          @book.next_step
        end

        format.html { redirect_to(@book, :notice => 'Dein Buch wurde angelegt.') }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        @templates = Templates.get_all
        @selected_template_id = params[:template_id]
        format.html { render :action => "new" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to(@book, :notice => 'Dein Buch wurde gespeichert.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(books_url) }
      format.xml  { head :ok }
    end
  end
  
  def destroy_field
    @book.field_ids.delete params[:field_id].to_i
    @book.save
    
    respond_to do |format|
      format.html { redirect_to(@book) }
      format.js do
        render :update do |page|
          page.replace_html 'book_fields', :partial => 'book_fields', :locals => {:book => @book, :addable_fields => @book.addable_fields}
        end
      end
    end    
  end

  def sort_fields
    @book.field_ids = params[:book_field_list].map {|f| f.to_i }
    @book.save
    render :nothing => true
  end
  
  def add_field
    @book.field_ids = [] if @book.field_ids.nil?
    @book.field_ids << params[:new_field].to_i
    @book.save
    
    respond_to do |format|
      format.html { redirect_to(@book) }
      format.js do
        render :update do |page|
          page.replace_html 'book_fields', :partial => 'book_fields', :locals => {:book => @book, :addable_fields => @book.addable_fields}
        end
      end
    end    
  end

end
