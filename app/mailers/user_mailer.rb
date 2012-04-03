class UserMailer < ActionMailer::Base
  layout 'email' # use email.(html|text).erb as the layout
  default :from => "noreply@ichmagrot.de"
  
  def welcome_email(user,book)
    @user = user
    @book = book
    @owner = book.user
    @url  = book_url(@book, {:authkey => user.key})
    mail(:to => user.email,
         :subject => "Hey #{user.email}, schreib in mein Buch „#{@book.title}“!")
  end
  
  def send_key_email(book)
    @user = book.user
    @book = book
    @url  = book_url(@book, {:authkey => @user.key})
    mail(:to => @user.email,
         :subject => "#{@user.name}, hier ist dein persönlicher Link für „#{@book.title}“!")
  end
end
