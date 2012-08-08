# ActiveRecordInstanceCount

Rack middleware to log the number of instantiated ActiveRecord models in a request. Helpful to see how many objects you're instantiating. First step to recognize you have a problem.

Logs a message like (notice the last line):

```
Started GET "/wines/7016/pricing" for 192.168.255.9 at 2012-08-07 06:26:00 +0000
Processing by WineBookPricingController#index as HTML
  Parameters: {"wine_book_id"=>"7016"}
  Rendered wine_book_pricing/index.html.haml within layouts/application (9.7ms)
  Rendered shared/_analytics.html.erb (0.0ms)
  Rendered shared/_ajax_status.html.haml (0.1ms)
  Rendered shared/_navbar.html.haml (1.8ms)
  Rendered shared/_alerts.html.haml (0.4ms)
Completed 200 OK in 71ms (Views: 35.7ms | ActiveRecord: 21.5ms)
Instantiation Breakdown: Total: 7 | WineBook: 4 | User: 1 | Group: 1 | Producer: 1
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
