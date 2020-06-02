require "faker"

RSpec.describe Permafrost do
  it "has a version number" do
    expect(Permafrost::VERSION).not_to be nil
  end

  describe ".freeze(env = nil)" do
    it "does not change the environment variables outside the block" do
      Permafrost.freeze do
        ENV.clear
      end

      expect(ENV).not_to be_empty
    end

    it "replaces the environment variables inside the block" do
      env = { Faker::Lorem.word => Faker::Lorem.word }

      Permafrost.freeze(env) do
        expect(ENV.to_h).to eq env
      end
    end

    it "passes exceptions from the block" do
      expect do
        Permafrost.freeze do
          raise StandardError
        end
      end.to raise_error StandardError
    end
  end

  describe ".merge(env)" do
    it "merges the provided environment into the current one" do
      env = { Faker::Lorem.word => Faker::Lorem.word }

      Permafrost.merge(env) do
        expect(ENV.to_h).not_to eq env
        expect(ENV.to_h).to include env
      end
    end
  end
end
