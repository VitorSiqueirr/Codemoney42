require 'spec_helper'
require_relative '../Bank/account'

RSpec.describe Account do
  subject(:account) { described_class.new }
  subject(:bank) { described_class.new }

  describe '#withdraw' do
    let(:holders_name) { 'Vitor' }

    context "when amount is greater than zero and there's balance" do
      let(:amount) { 1000.00 }
      it 'decrease amount balance successfully' do
        expect(account.withdraw(account: { number: 0o001,
                                           name: holders_name,
                                           balance: 100_000 }, amount:))
          .to eq({ balance: 99_000.0, name: 'Vitor', number: 1 })
      end
    end

    context 'when the balance become negative' do
      let(:amount) { 1000.00 }
      it 'decrease amount balance successfully' do
        expect do
          account.withdraw(account: { number: 0o001,
                                      name: holders_name,
                                      balance: 0 }, amount:)
                 .to raise_error(CannotWithdrawError, 'Balance cannot be negative')
        end
      end
    end
  end
end
