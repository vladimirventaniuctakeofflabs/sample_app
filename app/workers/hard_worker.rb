class HardWorker
    include Sidekiq::Worker
    sidekiq_options retry: false
    def perform(user_id, action, token)
      # do something
        begin
            user = User.find(user_id)
           
            if action.eql? "send_activation_email"   
                puts "SIDEKIQ SENDING AN ACTIVATION EMAIL"
                user.activation_token = token
                UserMailer.account_activation(user).deliver_now
            else
                puts "SIDEKIQ SENDING A PASSWORD RESET EMAIL"
                user.reset_token = token
                UserMailer.password_reset(user).deliver_now
            end
        rescue => e
            puts e, e.backtrace
        end
    end
  end