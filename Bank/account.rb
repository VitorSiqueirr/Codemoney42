class Account
  def initialize
    @account_number = 0
  end

  def create_account(account_name:)
    @account_number += 1
    { number: @account_number.to_s.rjust(4, '0'), name: account_name, balance: 0 }
  end

  def deposit(account:, amount:)
    account[:balance] += amount
    account
  end

  def withdraw(account:, amount:)
    raise CannotWithdrawError, 'Balance cannot be negative' if (account[:balance] - amount).negative?

    account[:balance] -= amount
    account
  end
end

class CannotWithdrawError < StandardError; end
