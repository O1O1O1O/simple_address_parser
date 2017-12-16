require 'lob/address_parser'
describe AddressParser do
  subject {
    described_class.new
  }

  describe '#parse_line1' do
    it "parses line 1" do
      expect(subject.parse_line1("185 Berry St Suite 6600 San Francisco CA 94107")).to eq(["185 Berry St", "Suite 6600 San Francisco CA 94107"])
    end

    context "when stret name contains a street suffix" do
      it "parses line 1 " do
        expect(subject.parse_line1("779 St Francis Ave Novato CA 94947")).to eq(["779 St Francis Ave", "Novato CA 94947"])
      end
    end

    context "when city name contains a street suffix" do
      # Came up with this test that is not trivial to fix:
      
      #it "parses line 1" do
      #  expect(subject.parse_line1("185 Berry St Suite 6600 Plaza City CA 94107")).to eq(["185 Berry St", "Suite 6600 Plaza City CA 94107"])
      #end

      # Although not part of the acceptance tests I think what we need to solve this is
      # first remove zip and then state.  At that point we have something that is:
      #  line1 city
      #  line1 line 2 city
      # and the second case is parsed by
      #   /(.* \d+) (\D+)$/
      # and if that doesn't match then the first case is parsed by
      #  /(.* (Ave|St|Plaza)) (.+))$/
      #
      # So we need to update the parsing sequence to...
      #   parse_zip(input) -> [zip, remainder]
      #   parse_state(remainder) -> [state, remainder]
      #   parse_city -> [city, remainder]
      #   parse_line1(remainder) -> [line1, remainder]
      #   parse_line2(remainder) -> line2
    end
  end

  describe '#parse_line2' do
    it "parsing line 2 returns the correct result" do
      expect(subject.parse_line2("Suite 6600 San Francisco CA 94107")).to eq(["Suite 6600", "San Francisco CA 94107"])
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