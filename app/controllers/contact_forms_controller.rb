class ContactFormsController < ApplicationController
  def new
  	 @contact_form = ContactForm.new
  end

  def create
  	@contact_form = ContactForm.new(params[:contact_form])
  	@contact_form.request = request
  	@contact_form.deliver
  end 
end
