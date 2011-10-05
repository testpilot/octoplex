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

### Language note

This library is written in International English, so if you're wondering why we've swapped your Zs for S, and added a U to colour – get a dictionary.
