require 'spec_helper'
require_relative '../Bank/bank'

RSpec.describe Bank do
  subject(:bank) { described_class.new }

  describe '#create_account' do
    let(:holders_name) { 'Vitor' }

    context 'when create an account successfully' do
      it 'return successfull message' do
        expect(bank.create_account(holders_name))
          .to eq('Account created successfully!')
      end
    end

    context 'when create an account with a holder that already exists' do
      it 'raise an error' do
        bank.create_account(holders_name)
        expect(bank.create_account(holders_name))
          .to eq('This account already exists')
      end
    end

    context 'when create an account with a name equal to ""' do
      it 'raise an error' do
        expect(bank.create_account(''))
          .to eq('Holders name cannot be blank or empty')
      end
    end

    context 'when create an account with a name equal to " "' do
      it 'raise an error' do
        expect(bank.create_account(' '))
          .to eq('Holders name cannot be blank or empty')
      end
    end
  end

  describe '#change_holder' do
    let(:holders_name) { 'Vitor' }
    let(:new_holders_name) { 'Juberto' }

    context 'when changing holders successfully' do
      it 'successfull message' do
        bank.create_account(holders_name)
        expect(bank.change_holder(new_name: new_holders_name, old_name: holders_name))
          .to eq('Account changed holders successfully!')
      end
    end

    context 'when changing holder with an account that already exists' do
      it 'raise an error' do
        bank.create_account(holders_name)
        bank.create_account(new_holders_name)
        expect(bank.change_holder(new_name: new_holders_name, old_name: holders_name))
          .to eq('This account already exists')
      end
    end

    context 'when create an account with a name equal to ""' do
      it 'raises an error' do
        bank.create_account(holders_name)
        expect(bank.change_holder(new_name: '', old_name: holders_name))
          .to eq('Holders name cannot be blank or empty')
      end
    end

    context 'when create an account with a name equal to " "' do
      it 'raises an error if holder is equal to " "' do
        bank.create_account(holders_name)
        expect(bank.change_holder(new_name: '', old_name: holders_name))
          .to eq('Holders name cannot be blank or empty')
      end
    end
  end

  describe '#deposit_in_account' do
    let(:holders_name) { 'Vitor' }

    context 'when amount is greater than zero' do
      let(:amount) { 1000.00 }
      it 'increase amount balance' do
        bank.create_account(holders_name)
        expect(bank.deposit_in_account(account_name: holders_name, amount:))
          .to eq('Deposited successfully!')
      end
    end

    context 'when amount is just a little over zero' do
      let(:amount) { 0.01 }
      it 'increase amount balance' do
        bank.create_account(holders_name)
        expect(bank.deposit_in_account(account_name: holders_name, amount:))
          .to eq('Deposited successfully!')
      end
    end

    context 'when amount is less than zero' do
      let(:amount) { -1000.00 }
      it 'raise an error' do
        bank.create_account(holders_name)
        expect(bank.deposit_in_account(account_name: holders_name, amount:))
          .to eq('Amount need to be greater than zero')
      end
    end

    context 'when amount is equal to zero' do
      let(:amount) { 0.0 }
      it 'raise an error' do
        bank.create_account(holders_name)
        expect(bank.deposit_in_account(account_name: holders_name, amount:))
          .to eq('Amount need to be greater than zero')
      end
    end
  end

  describe '#withdraw_in_account' do
    let(:holders_name) { 'Vitor' }

    context "when amount is greater than zero and there's balance" do
      let(:amount) { 1000.00 }
      it 'decrease balance sucessfully' do
        bank.create_account(holders_name)
        bank.deposit_in_account(account_name: holders_name, amount:)
        expect(bank.withdraw_in_account(account_name: holders_name, amount:))
          .to eq('Withdraw successfully!')
      end
    end

    context "when amount and balance is just a little over zero and there's balance" do
      let(:amount) { 0.01 }
      it 'withdraw balance sucessfully' do
        bank.create_account(holders_name)
        bank.deposit_in_account(account_name: holders_name, amount:)
        expect(bank.withdraw_in_account(account_name: holders_name, amount:))
          .to eq('Withdraw successfully!')
      end
    end

    context "when amount is greater than zero but there's no balance" do
      let(:amount) { 1000.00 }
      it 'raise an error' do
        bank.create_account(holders_name)
        expect(bank.withdraw_in_account(account_name: holders_name, amount:))
          .to eq('Rescued: #<CannotWithdrawError: Balance cannot be negative>')
      end
    end

    context 'when amount is less than zero' do
      let(:amount) { -1000.00 }
      it 'raise an error' do
        bank.create_account(holders_name)
        bank.deposit_in_account(account_name: holders_name, amount:)
        expect(bank.withdraw_in_account(account_name: holders_name, amount:))
          .to eq('Amount need to be greater than zero')
      end
    end

    context 'when amount is equal to zero' do
      let(:amount) { 0.0 }
      it 'raise an error' do
        bank.create_account(holders_name)
        bank.deposit_in_account(account_name: holders_name, amount:)
        expect(bank.withdraw_in_account(account_name: holders_name, amount:))
          .to eq('Amount need to be greater than zero')
      end
    end
  end

  describe '#transfer_balance' do
    let(:holders_name_withdraw) { 'Vitor' }
    let(:holders_name_deposit) { 'Juberto' }

    context "when there's balance and both accounts exists" do
      let(:deposit) { 10_000 }
      let(:transfer) { 5000 }

      it 'tranfer successfully' do
        bank.create_account(holders_name_withdraw)
        bank.create_account(holders_name_deposit)
        bank.deposit_in_account(account_name: holders_name_withdraw, amount: deposit)
        expect do
          bank.transfer_balance(account_withdraw: holders_name_withdraw,
                                account_deposit: holders_name_deposit,
                                amount: transfer)
              .to eq('Transfer successfully!')
        end
      end
    end

    context 'when the amount to transfer is negative' do
      let(:deposit) { 10_000 }
      let(:transfer) { -5000 }

      it 'tranfer successfully' do
        bank.create_account(holders_name_withdraw)
        bank.create_account(holders_name_deposit)
        expect do
          bank.transfer_balance(account_withdraw: holders_name_withdraw,
                                account_deposit: holders_name_deposit,
                                amount: transfer)
              .to eq('Amount need to be greater than zero')
        end
      end
    end

    context 'when the amount to transfer is negative' do
      let(:deposit) { 10_000 }
      let(:transfer) { 0 }

      it 'tranfer successfully' do
        bank.create_account(holders_name_withdraw)
        bank.create_account(holders_name_deposit)
        expect do
          bank.transfer_balance(account_withdraw: holders_name_withdraw,
                                account_deposit: holders_name_deposit,
                                amount: transfer)
              .to eq('Amount need to be greater than zero')
        end
      end
    end

    context 'when the target account does not exists' do
      let(:deposit) { 20_000 }
      let(:transfer) { 10_000 }

      it 'raise an error' do
        bank.create_account(holders_name_withdraw)
        bank.deposit_in_account(account_name: holders_name_withdraw, amount: deposit)
        expect do
          bank.transfer_balance(account_withdraw: holders_name_withdraw,
                                account_deposit: holders_name_deposit,
                                amount: transfer)
              .to eq("Account #{holders_name_deposit} does not exists")
        end
      end
    end

    context 'when the balance would be negative' do
      let(:deposit) { 1000 }
      let(:transfer) { 10_000 }

      it 'raise an error' do
        bank.create_account(holders_name_withdraw)
        bank.create_account(holders_name_deposit)
        bank.deposit_in_account(account_name: holders_name_withdraw, amount: deposit)
        expect do
          bank.transfer_balance(account_withdraw: holders_name_withdraw,
                                account_deposit: holders_name_deposit,
                                amount: transfer)
              .to eq('Balance cannot be less than zero')
        end
      end
    end

    context 'when both accounts are the same' do
      let(:deposit) { 1000 }
      let(:transfer) { 10_000 }

      it 'raise an error' do
        bank.create_account(holders_name_withdraw)
        expect do
          bank.transfer_balance(account_withdraw: holders_name_withdraw,
                                account_deposit: holders_name_withdraw,
                                amount: transfer)
              .to eq('Is impossible to transfer to the same account')
        end
      end
    end
  end

  describe '#list_account' do
    let(:holders_name) { 'Vitor' }

    it 'list created accounts' do
      bank.create_account(holders_name)
      expect do
        bank.list_accounts
            .to not_be_empty
      end
    end

    it "not list if there's no account" do
      expect(bank.list_accounts).to be_empty
    end
  end

  describe '#account_exists?' do
    let(:holders_name) { 'Vitor' }

    it 'account exists' do
      bank.create_account(holders_name)
      expect(bank.account_exists?(holders_name)).to eq(true)
    end

    it "account don't exists" do
      expect(bank.account_exists?(holders_name)).to eq(false)
    end
  end

  describe '#exists_accounts?' do
    let(:holders_name) { 'Vitor' }

    it 'accounts exists' do
      bank.create_account(holders_name)
      expect(bank.exists_accounts?).to eq(true)
    end

    it "accounts don't exists" do
      expect(bank.exists_accounts?).to eq(false)
    end
  end
end
