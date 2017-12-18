require 'lob/address_parser'
describe AddressParser do
  subject {
    described_class.new
  }

  describe '#parse_line1' do
    it "returns the line 1 text" do
      expect(subject.parse_line1("185 Berry St Suite 6600 San Francisco CA 94107")).to eq(["185 Berry St", "Suite 6600 San Francisco CA 94107"])
    end

    context "when street name contains a street suffix" do
      it "returns only the line 1 text" do
        expect(subject.parse_line1("779 St Francis Ave Novato CA 94947")).to eq(["779 St Francis Ave", "Novato CA 94947"])
      end
    end
  end

  describe '#parse_line2' do
    it "returns the line 2 text" do
      expect(subject.parse_line2("Suite 6600 San Francisco CA 94107")).to eq(["Suite 6600", "San Francisco CA 94107"])
    end

    context "when line 2 is not present" do
      it "returns empty string" do
        expect(subject.parse_line2("San Francisco CA 94107")).to eq(["", "San Francisco CA 94107"])
      end
    end
  end

  describe '#parse_zip' do
    context "when 5+4 zip specified" do
      it "returns all nine digits" do
        expect(subject.parse_zip("San Francisco CA 94107-4321")).to eq (["94107-4321", "San Francisco CA"])
      end
    end
    context "when 5 digits zip specified" do
      it "returns five digits" do
        expect(subject.parse_zip("San Francisco CA 94107")).to eq (["94107", "San Francisco CA"])
      end
    end
  end

  describe '#parse_state' do
    it "returns the two-letter abbreviation" do
      expect(subject.parse_state("San Francisco CA")).to eq (["CA", "San Francisco"])
    end
  end
end