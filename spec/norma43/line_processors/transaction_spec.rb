require "norma43/utils/contexts"
require "norma43/line_processors"

module Norma43
  module LineProcessors
    RSpec.describe "Transaction" do
      let(:line){ double "Line", attributes: {} }
      let(:account){ Models::Account.new }
      let(:contexts){ Contexts.new(
        [
          Models::Document.new ,
          account,
          Models::Transaction.new
        ])
      }

      it "instantiates a new transaction with the line attributes" do
        allow(Models::Transaction).to receive :new

        Transaction.call line, contexts

        expect(Models::Transaction).to have_received(:new).with line.attributes
      end

      context "when Transaction is called" do
        let(:fake_transaction) { double "Models::Transaction" }
        before do
          allow(Models::Transaction).to receive(:new) { fake_transaction }
        end
        let!(:subject) { Transaction.call line, contexts }

        it "adds the transaction to the account" do
          expect(account.transactions).to include fake_transaction
        end

        it "sets the transaction as the current context" do
          expect(subject.current).to be fake_transaction
        end
      end
    end
  end
end