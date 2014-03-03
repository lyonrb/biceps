# Biceps

Easily route your versioned API
[![Travis](https://secure.travis-ci.org/lyonrb/biceps.png)](http://travis-ci.org/lyonrb/biceps)

## Installation

Biceps heavily uses the convention over configuration principle.
To install it, you just need to add it to your Gemfile.

    gem 'biceps'

## Rails

### Defining routes

Once Biceps is installed, you can start adding api-versioned routes.
Your `config/routes.rb` file could look like the following :

```ruby
MyApp::Application.routes.draw do
  root :to => "home#index"

  api_version(1) do
    get '/me' => "users#show"
  end

  api_version(2) do
    get '/user' => "users#show"
  end
end
```

This will create two routes :

    GET    /me(.:format)                                 {:controller=>"v1/users", :action=>"show"}
    GET    /user(.:format)                               {:controller=>"v2/users", :action=>"show"}

As you can see in the routing, both are leading to different namespaces
: v1 and v2.  
Both namespaces are the version of your API.


### Routes Testing

You will want to be able to add routing tests to your versionned API. We provide an helper for that.  
Include `Biceps::TestHelper` in your routing specs, and use the `mock_api_version` method.

Example :

    require 'spec_helper'

    describe V1::MyApiController do
      include Biceps::TestHelper
      mock_api_version(1)

      it "GET index" do
        get('/my_api').should route_to({:controller => 'v1/my_api', :action => 'index'})
      end
    end

#### Protip
You can include this helper in all your routing specs by editing your `spec/spec_helper.rb` file with the following :

    RSpec.configure do |config|
      config.include Biceps::TestHelper,    :type => :routing
    end

## Rack-based apps

Internally, biceps is just a rack middleware, which means you can use it with the ruby framework of your choice, including bare rack apps.  
We will add a rack env parameter called `biceps.versions`, which is an array of strings containing all versions specified in the Accept HTTP header.

You can then manage your routing as you wish inside your application.

## Calling the API

When you want to call the API, you need to specify the Accept header
like this :

    application/json,application/vnd.biceps;ver=1

Here is, for example, how you could do it with [faraday](https://github.com/technoweenie/faraday)

```ruby
connexion = Faraday.new(:url => 'http://api.yourapplication')
connexion.get do |req|
  req.url '/me'
  req.headers['ACCEPT'] = 'application/json, application/vnd.biceps;ver=1'
  req.params['access_token'] = 'xxx'
end
```

Or, with jQuery, we do it like this :

```javascript
$.ajaxSetup({
  accepts: {
    biceps: "application/json,application/vnd.biceps;ver=1"
  }
});

$.ajax({
  url: '/me'
  dataType: 'biceps'
}).always(function(response) {
  json = JSON.parse(response.responseText)
});
```

## Changing the app's name

You can change the app's name used to detect the Accept token easily.

    Biceps.app_name = 'example'

## Contributing

We're open to any contribution. It has to be tested properly though.

* [Fork](http://help.github.com/forking/) the project
* Do your changes and commit them to your repository
* Test your changes. We won't accept any untested contributions (except if they're not testable).
* Create an [issue](https://github.com/lyonrb/biceps/issues) with a link to your commits.

## Maintainers

* Damien MATHIEU ([github/dmathieu](http://github.com/dmathieu), [dmathieu.com](http://dmathieu.com))
* Franck VERROT ([github.com/franckverrot](http://github.com/franckverrot),[franck.verrot.fr](http://franck.verrot.fr/))

## License
MIT License. Copyright 2011 Evome. http://evome.fr
