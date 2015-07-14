require 'account'

describe Account do
  let(:account) { Account.new("0123456789") }


  describe "#initialize" do
    context "with valid input" do
      it "creates a new Account" do
        expect(account).to be_an_instance_of Account
      end
    end

    context "with invalid input" do
      it "throws an InvalidAccountNumberError when acct_number has less than 10 digits" do
        expect{Account.new("01234567gfds")}.to raise_error(InvalidAccountNumberError)
      end
    end
  end

  context "when using default starting_balance" do
    describe "#transactions" do
      it "returns the default starting_balance" do
        expect(account.transactions[0]).to equal(0)
      end
    end

    describe "#balance" do
      it "is 0" do
        expect(account.balance).to equal(0)
      end
    end
  end

  context "when initialized with a starting_balance" do
    let(:account) { Account.new("1234567890", 100) }

    describe "#transactions" do
      it "returns the specified balance" do
        expect(account.transactions[0]).to equal(100)
      end
    end

    describe "#balance" do
      it "is the specified balance" do
        expect(account.balance).to equal(100)
      end
    end

    describe "#withdraw!" do
      it "decreases the balance" do
        expect(account.withdraw!(20)).to equal(80)
      end

      it "substracts positive amounts" do
        expect(account.withdraw!(-20)).to equal(80)
      end
    end
  end

  describe "#account_number" do
    it "masks the number of the account" do
      expect(account.acct_number.to_sym).to equal("******6789".to_sym)
    end
  end

  describe "deposit!" do
    let(:account) { Account.new("1234567890", 100) }
  
    it "requires a positive amount" do
      expect{Account.new("1234567890", 100).deposit!(-200)}.to raise_error(NegativeDepositError)
    end

    it "increases the balance of the account" do
      expect(account.deposit!(20)).to equal(120)
    end
  end

  describe "#withdraw!" do
    it "throws an OverdraftError when withdraw amount is bigger than balance" do
      expect{Account.new("1234567890", 100).withdraw!(200)}.to raise_error(OverdraftError)
    end
  end
end