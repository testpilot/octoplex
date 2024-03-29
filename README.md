# Octoplex

A lightweight wrapper around Github's v3 API

## Installation

``` ruby
gem 'octoplex'
```

## Usage

Octoplex provides both authenticated and unauthenticated usage, however authenticated usage assumes you have
acquired an OAuth token for your user from another service, e.g. using Omniauth and Devise.

If you haven't already done so, register your application with the Github API at [https://github.com/account/applications](https://github.com/account/applications)

### Authenticated

Initialise the client with an auth token:

``` ruby
Octoplex.client(:token => "OAUTH_TOKEN")
```

Request this users details:

``` ruby
Octoplex.user
```

Request a specific users details:

``` ruby
Octoplex.users('ivanvanderbyl')
```

All client methods are designed to match closely to the [Github v3 API](http://developer.github.com/v3/users/) REST methods.

Example: Calling `Octoplex.user` will make an API call equivalent to `GET /user`

Alternatively you can use `Octoplex` as a connection wrapper for the API:

``` ruby
Octoplex.get('/user')
Octoplex.get('/user/repos')
```
    
All requests return a `Hashr` object or `Array` of `Hashr` objects

All requests on the new v3 API are rate limited, to find out your current usage you can query
these two methods after each request:

``` ruby
Octoplex.rate_limit #=> 5000
Octoplex.rate_limit_remaining #=> 4999
```

There are times when you may want to run multiple instances of the `Octoplex::Client` side by side
with different tokens.

The recommended approach for this is to not use the global `Octoplex` object, rather instantiate `Octoplex::Client`
individually.

``` ruby
client = Octoplex::Client.new(:token => "AUTH_TOKEN")
client.get('/user')
```

### Configuration

You can specify a number of connection options before making your first request, but remember, the connection object is cached so you will
need to call `Octoplex.discard_client!` if you want to change anything.

Available options:
``` ruby
{
  :token => YOU OAUTH AUTHENTICATION TOKEN, Default: nil,
  :per_page => THE NUMBER OF ITEMS TO REQUEST AT ONCE, Default: 100,
  :enable_caching, ENABLE REQUEST CACHING, Default: true
}
```
Pass these to `Octoplex.client(options)`

### Repositories

Here is a quick rundown on using `Octoplex` to interact with Repositories.

**List all for a user**
``` ruby
Octoplex.repos('ivanvanderbyl')
# or, take the object orientated approach
Octoplex.users('testpilot').repos
```

**List all for the current user**
``` ruby
Octoplex.repos
# or
Octoplex.user.repos
```

**Fetch a specific repo**
``` ruby
Octoplex.repo('ivanvanderbyl/cloudist')
# or
Octoplex.repo('ivanvanderbyl', 'cloudist')
```

**List all for an Organisation**
``` ruby
Octoplex.orgs('testpilot').repos
# or
Octoplex.repos('testpilot')
```



### Language note

This library is written in International English, so if you're wondering why we've swapped your Zs for S, and added a U to colour – get a dictionary.
