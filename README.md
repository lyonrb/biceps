# Biceps

Easily route your rails-based versionned API
[![Travis](https://secure.travis-ci.org/evome/biceps.png)](http://travis-ci.org/evome/biceps)

## Installation

Biceps heavily uses the convention over configuration principle.  
To install it, you just need to add it to your Gemfile.

    gem 'biceps'

## Defining routes

Once Biceps is installed, you can start adding api-versionned routes.  
Your `config/routes.rb` file could look like the following :

    MyApp:Application.routes.draw do
      root :to => "home#index"

      api_version(1) do
        get '/me' => "users#show"
      end

      api_version(2) do
        get '/user' => "users#show"
      end
    end

This will create two routes :

    GET    /me(.:format)                                 {:controller=>"v1/users", :action=>"show"}
    GET    /user(.:format)                               {:controller=>"v2/users", :action=>"show"}

As you can see in the routing, both are leading to different namespaces
: v1 and v2.  
Both namespaces are the version of your API.

## Calling the API

When you want to call the API, you need to specify the Accept header
like this :

    application/json,application/vnd.my_app;ver=1

When my_app is your application's name (based on the module name at
`MyApp::Application`).

Here is, for example, how you could do it with [faraday](https://github.com/technoweenie/faraday)

    connexion = Faraday.new(:url => 'http://api.yourapplication')
    connexion.get do |req|
      req.url '/me'
      req.headers['HTTP_ACCEPT'] = 'application/json, application/vnd.my_app;ver=1'
      req.params['access_token'] = 'xxx'
    end

Or, with jQuery, we do it like this :

    $.ajaxSetup({
      accepts: {
        my_app: "application/json,application/vnd.my_app;ver=1"
      }
    });

    $.ajax({
      url: '/me'
      dataType: 'my_app'
    }).always(function(response) {
      json = JSON.parse(response.responseText)
    });


## Contributing

We're open to any contribution. It has to be tested properly though.

* [Fork](http://help.github.com/forking/) the project
* Do your changes and commit them to your repository
* Test your changes. We won't accept any untested contributions (except if they're not testable).
* Create an [issue](https://github.com/evome/biceps/issues) with a link to your commits.

## Maintainers

* Evome ([evome.fr](http://evome.fr))
* Damien MATHIEU ([github/dmathieu](http://github.com/dmathieu), [dmathieu.com](http://dmathieu.com))

## License
MIT License. Copyright 2010 Evome. http://evome.fr
