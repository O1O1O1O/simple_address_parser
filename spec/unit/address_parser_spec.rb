require 'lob/address_parser'
describe AddressParser do
  subject {
    described_class.new
  }

  describe '#parse_line2' do
    context "when line2 is present" do
      it "parses line 2" do
        expect(subject.parse_line2("779 Francis Ave Apt 42")).to eq(["Apt 42", "779 Francis Ave"])
      end
    end

    context "when line2 is not present" do
      it "parses line 2" do
        expect(subject.parse_line2("779 Francis Ave")).to eq(["", "779 Francis Ave"])
      end
    end

    context "when street name contains a street suffix" do
      context "when line2 is present" do
        it "parses line 2" do
          expect(subject.parse_line2("779 St Francis Ave Apt 42")).to eq(["Apt 42", "779 St Francis Ave"])
        end
      end

      context "when line2 is not present" do
        it "parses line 2" do
          expect(subject.parse_line2("779 St Francis Ave")).to eq(["", "779 St Francis Ave"])
        end
      end
    end
  end

  describe "#parse_city" do
    context "when line2 is not present" do
      it "parses city" do
        expect(subject.parse_city("185 Berry St Daly City")).to eq(["Daly City", "185 Berry St"])
      end

      context "when city name contains a street suffix" do
        it "parses city" do
          expect(subject.parse_city("185 Berry St Plaza City")).to eq(["Plaza City", "185 Berry St"])
        end
      end
    end

    context "when line2 is present" do
      it "parses city" do
        expect(subject.parse_city("185 Berry St Suite 6600 Daly City")).to eq(["Daly City", "185 Berry St Suite 6600"])
      end

      context "when city name contains a street suffix" do
        it "parses city" do
          expect(subject.parse_city("185 Berry St Suite 6600 Plaza City")).to eq(["Plaza City", "185 Berry St Suite 6600"])
        end
      end
    end

    context "when line1 starts with a suffix" do
      it "parses city" do
        expect(subject.parse_city("185 St Francis St Daly City")).to eq(["Daly City", "185 St Francis St"])
      end
    end
  end

  describe '#parse_zip' do
    it "parses the zip" do
      expect(subject.parse_zip("San Francisco CA 94107")).to eq (["94107", "San Francisco CA"])
    end
  end

  describe '#parse_state' do
    it "parses the state" do
      expect(subject.parse_state("San Francisco CA")).to eq (["CA", "San Francisco"])
    end
  end
end