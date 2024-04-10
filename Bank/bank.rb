require_relative 'account'

class Bank
  def initialize
    @account = Account.new
    @accounts = {}
  end

  def create_account(name)
    name.downcase!
    return 'This account already exists' if @accounts.key?(name)
    return 'Holders name cannot be blank or empty' if ['', ' '].include?(name)

    @accounts[name] = @account.create_account(account_name: name)
    'Account created successfully!'
  end

  def deposit_in_account(account_name:, amount:)
    amount = amount.to_f
    return 'Amount need to be greater than zero' if check_amount(amount)

    @account.deposit(account: @accounts[account_name], amount:)
    'Deposited successfully!'
  end

  def withdraw_in_account(account_name:, amount:)
    amount = amount.to_f
    return 'Amount need to be greater than zero' if check_amount(amount)

    @account.withdraw(account: @accounts[account_name], amount:)
    'Withdraw successfully!'
  rescue CannotWithdrawError => e
    "Rescued: #{e.inspect}"
  end

  def transfer_balance(account_withdraw:, account_deposit:, amount:)
    account_withdraw.downcase!
    account_deposit.downcase!
    return 'Amount need to be greater than zero' if check_amount(amount)
    return 'The account you wish to tranfer to does not exists' unless account_exists?(account_deposit)
    return 'Is impossible to transfer to the same account' if check_same_account(account_withdraw:, account_deposit:)

    withdraw_result = withdraw_in_account(account_name: account_withdraw, amount:)
    return withdraw_result if withdraw_result.start_with?('Rescued')

    deposit_in_account(account_name: account_deposit, amount:)
    'Transfer successfully!'
  end

  def list_accounts
    return if @accounts.nil?

    account_aux = []
    i = 0
    @accounts.each_value do |account|
      account_aux[i] = print(account)
      i += 1
    end
    account_aux
  end

  def account_exists?(name)
    account = @accounts[name.downcase]
    return true if account

    false
  end

  def change_holder(new_name:, old_name:)
    return 'Holders name cannot be blank or empty' if check_holder_is_brank(new_name)
    return 'This account already exists' if check_account_exists?(new_name)

    account = @accounts.delete(old_name)
    account[:name] = new_name
    @accounts[new_name] = account
    'Account changed holders successfully!'
  end

  def print_account(name)
    print(@accounts[name])
  end

  def exists_accounts?
    !@accounts.empty?
  end

  private

  def check_account_exists?(name)
    return true if @accounts.key?(name)

    false
  end

  def check_holder_is_brank(name)
    return true if ['', ' '].include?(name)

    false
  end

  def check_amount(amount)
    return true if amount.negative? || amount.zero?

    false
  end

  def check_same_account(account_withdraw:, account_deposit:)
    return true if account_withdraw == account_deposit

    false
  end

  def print(account)
    "Account: #{account[:number]} | Name: #{account[:name].capitalize} | Balance: $#{account[:balance]}"
  end
end
