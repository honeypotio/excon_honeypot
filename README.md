# ExconHoneypot

This gem is a plugin to excon gem https://github.com/excon/excon .

It adds following functionality:

- default options: expects: [200, 201, 204]
- `Excon.post_json`, `Excon.put_json` helper methods for requests with json bodies. Json data can be passed with `json` hash param.

Example:

    Excon.post_json('https://foo.bar/users', json: payload)

- `response.parsed_body` helper method for easier parsing of responses

Example:

    Excon.get('https://foo.bar/users').parsed_body

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
