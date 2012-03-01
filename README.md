# ActiveRecordInstanceCount

Rack middleware to log the number of instantiated ActiveRecord models in a request. Helpful to see how many objects you're instantiating. First step to recognize you have a problem.

Logs a message like:

```
Instantiation Breakdown: Total: 3 | UserSession: 1 | User: 1 | UserDevice: 1
```

## Installation

Add to your `Gemfile`:

```
gem 'active-record-instance-count'
```

Then provide an initializer, like `config/initializers/active_record_instance_counter.rb`:

```
YourApp::Application.middleware.use( ActiveRecordInstanceCount::Middleware, :logger => Rails.logger )
```

Provide a different `Logger` instance if you would like to redirect the output somewhere else. But keep in mind that no more context will be provided (e.g. the request details) so it might be fairly useless.

## Credits

_Heavily_ inspired from [Oink](https://github.com/noahd1/oink)
