class ContactForm < MailForm::Base
  attribute :name
  attribute :email
  attribute :message

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "My Contact Form",
      #:to => "shabbirun@google.com",
      :to => "jinxin238357@outlook.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end