require_relative './Bank/bank'

class Menu
  # ERRORS_HANDLER = { 1 => 'Holders name cannot be blank or empty',
  #                    2 => 'This account already exists',
  #                    3 => 'Amount need to be greater than zero',
  #                    4 => 'The account you wish to tranfer to does not exists',
  #                    5 => 'Is impossible to transfer to the same account' }.freeze

  def initialize
    @user_input = ''
    @bank = Bank.new
  end

  def start
    system('clear')
    until @user_input == 'e'
      puts 'Type "s" to select an account' if @bank.exists_accounts?
      puts 'Type "a" to add an account'
      puts 'Type "e" to exit the bank'
      @user_input = gets.chomp.downcase
      case @user_input
      when 's'
        if !@bank.list_accounts.empty?
          system('clear')
          @bank.list_accounts.each do |account|
            puts account
          end
          puts 'Type the name of the account you wish to enter or type "e" to exit:'
          select_account(gets.chomp)
        else
          puts "There's no accounts yet!"
        end
      when 'a'
        system('clear')
        puts 'Type your name:'
        name = gets.chomp
        puts @bank.create_account(name)
        select_account(name)
      when 'e'
        puts 'Thanks for using our bank!'
      else
        puts 'Invalid option!'
      end
    end
  end

  # def handler(handle)
  #   case handle
  #   when 1
  #     puts 'Holders name cannot be blank or empty'
  #   when 2
  #     puts 'This account already exists'
  #   when 3
  #     'Amount need to be greater than zero'
  #   when 4
  #     'The account you wish to tranfer to does not exists'
  #   when 5
  #     'Is impossible to transfer to the same account'
  #   when is_not_a(Integer)
  #     puts handle
  #   end
  # end

  def select_account(name)
    user_input = ''
    old_name = name
    system('clear')
    until user_input == 'u'
      if @bank.account_exists?(name)
        puts @bank.print_account(name.downcase)
        puts 'Type "c" to change the holders name'
        puts 'Type "d" to deposit in the account'
        puts 'Type "w" to withdraw from the account'
        puts 'Type "t" to transfer money to another account'
        puts 'Type "u" to return to the main menu'
        case user_input = gets.chomp.downcase
        when 'c'
          system('clear')
          puts 'Write the new holders name:'
          name = gets.chomp.downcase
          puts @bank.change_holder(new_name: name, old_name:)
        when 'd'
          puts 'Write the amount you wish to deposit:'
          amount = gets.chomp
          system('clear')
          puts @bank.deposit_in_account(account_name: name.downcase, amount:)
        when 'w'
          puts 'Write the amount you wish to withdraw:'
          amount = gets.chomp
          system('clear')
          puts @bank.withdraw_in_account(account_name: name.downcase, amount:)
        when 't'
          system('clear')
          @bank.list_accounts.each do |account|
            puts account
          end
          puts 'Write the name of the account you wish to tranfer to:'
          account_deposit = gets.chomp
          puts 'Write the amount you wish to transfer'
          amount = gets.chomp.to_f
          system('clear')
          puts @bank.transfer_balance(account_withdraw: name.downcase, account_deposit: account_deposit.downcase,
                                      amount:)
        when 'u'
          system('clear')
          puts 'You unselect the account'
        else
          system('clear')
          puts 'Invalid option!'
        end
      else
        puts "This account don't exist"
        user_input = 'u'
      end
    end
  end
end

Menu.new.start
