# ExconHoneypot

This gem is a plugin to excon gem https://github.com/excon/excon .

It adds following functionality:

- default options: expects: [200, 201, 204]
- raise exception if status is not expected
- `Excon.post`, `Excon.put`, `Excon.patch` `json` helper param for requests with json bodies. Json data can be passed with `json` hash param.

Example:

    Excon.post('https://foo.bar/users', json: payload)
    Excon.put('https://foo.bar/users/5', json: payload)

- `response.parsed_body` helper method for easier parsing of json responses
- Log excon requests with rails logger
- Mask sensitive data in logs

Example:

    Excon.get('https://foo.bar/users').parsed_body

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
