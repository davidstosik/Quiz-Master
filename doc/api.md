Quiz Master API Documentation
=============================

This is the documentation to the API exposed by the Quiz Master
application.

In the current state, all endpoints are totally open.
A real-life application would require more work to secure those endpoints:

- setup an authentication system with user accounts (suggestions:
  [Devise](https://github.com/plataformatec/devise) and/or
  [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper))
- setup permission policies (suggestion:
  [Pundit](https://github.com/elabs/pundit))
- throttle abusive requests
  ([Rack::Attack](https://github.com/kickstarter/rack-attack))

This API is based on Rail's system and returns simple JSON responses. Only
simple endpoints are implemented.
If the API was about to grow significantly with more complex requests, I would
suggest switching to the [JSON API specification](http://jsonapi.org), supported
by the [JSONAPI::Resources](https://github.com/cerebris/jsonapi-resources) gem.
Many [client implementations](http://jsonapi.org/implementations/) are also
available, and would provide a quick and easy way to build both API server and
clients.
