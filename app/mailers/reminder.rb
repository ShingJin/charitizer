class Reminder < ActionMailer::Base
  default from: "jinxin238357@outlook.com"

  def reminder_email(shop)
  	@shop = shop
  	mail(to: @shop.email, subject: '') 
  end
end
