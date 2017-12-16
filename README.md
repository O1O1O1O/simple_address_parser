# Address parser

This gem is for parsing postal address strings into commponent parts.

## Accepted input

*Assumptions*
- Address is in the US with a elements `<LINE1> [<LINE2>] <CITY> <STATE> <ZIP>`
- No address components are validated against actual valid cities, states or zip codes
- `LINE1` is present and ends with a suffix which is one of `Ave`, `St`, or `Plaza` and defined in `AddressParser::LINE1_SUFFIXES`
- `LINE2` is optional but if present ends in one or more digits
- `CITY`, `STATE`, and `ZIP` are present
- No error handling for invalid inputs

### `LINE1`
Address line 1 eg. "185 View St" which must end in an accepted street name suffix as defined by `AddressParser::LINE1_SUFFIXES`
### `LINE2`
Optional address suffix must end in one or more digits
### `CITY`
City name.  Not validated against US cities so any text between the state and LINE1 or LINE2 address components
### `STATE`
Two letter state abbreviation (not validated)

### `ZIP`
5 digit or 5+4 zip code e.g. 94106 or 94106-2314
Not validated against valid US zip codes

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lob'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install test

## Usage

Require the gem with `require 'lob'`

The gem includes a single class `AddressParser`.

### Parse a single address

Parse a single address with `parse_address` method of an `AddressParser` instance passing the address as the single input parameter.  

The return value is a hash containing the keys `"line1"`, `"line2"`, `"city"`, `"state"`, `"zip"`.  If absent then the value of the `"line2"` key will be an empty string `""`.
```ruby
  parser = AddressParser.new
  parser.parse_address('185 Noname St Apt 341 Oakland CA 94607')
  => {"line1"=>"185 Noname St", "line2"=>"Apt 341", "city"=>"Oakland", "state"=>"CA", "zip"=>"94607"}
```

### Parse multiple addresses

Parse multiple addresses with `parse_addresss` method of an `AddressParser` instance pasing an array of address strings as the single input parameter.

The return value is an array of address hashes as above.

```ruby
  parser = AddressParser.new
  parser.parse_addresses(
    ['185 Noname St Apt 341 Oakland CA 94607',
     '1451 Somewhere Ave Alameda CA 94501'])
  => [{"line1"=>"185 Noname St", "line2"=>"Apt 341", "city"=>"Oakland", "state"=>"CA", "zip"=>"94607"},{"1451 Somewhere Ave", "line2"=>"", "city"=>"Alameda", "zip"=>"94501"}]
```

### Commandline

A commandline API is available from `bin/address_parser` which reads lines from standard input and outputs parsed address hashes one by one

```bash
bin/address_parser 
185 Noname St Apt 341 Oakland CA 94607
{"line1"=>"185 Noname St", "line2"=>"Apt 341", "city"=>"Oakland", "state"=>"CA", "zip"=>"94607"}
1451 Somewhere Ave Alameda CA 94501
{"line1"=>"1451 Somewhere Ave", "line2"=>"", "city"=>"Alameda", "state"=>"CA", "zip"=>"94501"}
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

