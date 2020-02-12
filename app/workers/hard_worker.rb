class HardWorker
    include Sidekiq::Worker
    sidekiq_options retry: false
    def perform(user_id, action)
      # do something
        begin
            user = User.find(user_id)
            
            if action.eql? "send_activation_email"
                puts "SIDEKIQ SENDING AN ACTIVATION EMAIL"
                UserMailer.account_activation(user).deliver_now
            else
                puts "SIDEKIQ SENDING AN PASSWORD RESET EMAIL"
                UserMailer.password_reset(user).deliver_now
            end
        rescue => e
            debugger
            puts e, e.backtrace
        end
    end
  end