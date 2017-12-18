class AddressParser
  LINE1_SUFFIXES = ['Ave', 'St', 'Plaza']

  def parse_addresses(input)
    input.collect do |address|
      parse_address(address)
    end
  end

  def parse_address(text)
    #   /(.* \d+) (\D+)$/
    # and if that doesn't match then the first case is parsed by
    #  /(.* (Ave|St|Plaza)) (.+))$/
    #
    # So we need to update the parsing sequence to...
    zip, remainder = parse_zip(text)
    state, remainder = parse_state(remainder)
    city, remainder = parse_city(remainder)
    line2, remainder = parse_line2(remainder)
    line1 = remainder

    {
      "line1" => line1,
      "line2" => line2,
      "city" => city,
      "state" => state,
      "zip" => zip
    }
  end

  # Given line1 [line2] city return [city, remainder]
  def parse_city(text)
    suffixes = LINE1_SUFFIXES.join('|')
    result = text.match(/^(.* (#{suffixes}|\D+ \d+)) ((?!#{suffixes}).*)$/)
    [result[3], result[1]]
  end

  def parse_line2(text)
    suffixes = LINE1_SUFFIXES.join('|')
    result = text.match(/^(.* (#{suffixes})) (\D+ \d+)$/)
    result ? [result[3], result[1]] : ['', text]
  end

  def parse_zip(text)
    result = text.match(/(.*) (\d{5}-?\d{0,4})$/)
    [result[2], result[1]]
  end

  def parse_state(text)
    result = text.match(/(.*) ([A-Z,a-z]{2})$/)
    [result[2], result[1]]
  end
end