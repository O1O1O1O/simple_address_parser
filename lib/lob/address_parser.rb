class AddressParser
  LINE1_SUFFIXES = ['Ave', 'St', 'Plaza']

  def parse_addresses(input)
    input.collect do |address|
      parse_address(address)
    end
  end

  def parse_address(text)
    line_1, remainder = *parse_line1(text)
    line_2, remainder = *parse_line2(remainder)
    zip, remainder = *parse_zip(remainder)
    state, remainder = *parse_state(remainder)
    city = remainder

    {
      "line1": line_1,
      "line2": line_2,
      "city": city,
      "state": state,
      "zip": zip
    }
  end

  def parse_line1(text)
    suffixes = LINE1_SUFFIXES.join('|')
    result = text.match(/(.* (#{suffixes})) (.*)$/)
    [result[1], result[3]]
  end

  def parse_line2(text)
    result = text.match(/(\D+ \d+) (.*)/)
    result ? [result[1], result[2]] : ['', text]
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