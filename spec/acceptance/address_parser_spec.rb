require 'lob/address_parser'
describe AddressParser do
  let(:input) {
    <<EOF
185 Berry St Suite 6600 San Francisco CA 94107
185 Berry St Suite 6600 San Francisco CA 94107-1796
185 Berry St San Francisco CA 94107
779 St Francis Ave Novato CA 94947
222 W Merchandise Mart Plaza Chicago IL 60654
EOF
  }
  let(:inputs) {
    input.split("\n")
  }
  let(:outputs) {
    [
      {
        "line1": "185 Berry St",
        "line2": "Suite 6600",
        "city": "San Francisco",
        "state": "CA",
        "zip": "94107"
      },
      {
        "line1": "185 Berry St",
        "line2": "Suite 6600",
        "city": "San Francisco",
        "state": "CA",
        "zip": "94107-1796"
      },
      {
        "line1": "185 Berry St",
        "line2": "",
        "city": "San Francisco",
        "state": "CA",
        "zip": "94107"
      },
      {
        "line1": "779 St Francis Ave",
        "line2": "",
        "city": "Novato",
        "state": "CA",
        "zip": "94947"
      },
      {
        "line1": "222 W Merchandise Mart Plaza",
        "line2": "",
        "city": "Chicago",
        "state": "IL",
        "zip": "60654"
      }
    ]
  }
  subject {
    described_class.new
  }

  describe '#parse_addresses' do
    it "parses addresses" do
      expect(subject.parse_addresses(inputs)).to eq(outputs)
    end
  end
end