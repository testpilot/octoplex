# Octoplex

A lightweight wrapper around Github's v3 API

## Installation

    gem 'octoplex'
    
## Usage

Octoplex provides both authenticated and unauthenticated usage, however it assumes you have
acquired an OAuth token from another service, e.g. using Omniauth and Devise.

### Authenticated

Initialize the client with an auth token:

    Octoplex.client(:token => "OAUTH_TOKEN")
    
Request this users details:

    Octoplex.user
    
Request a specific users details:

    Octoplex.users('ivanvanderbyl')
    
Alternatively you can use `Octoplex` as a connection wrapper for the API:

    Octoplex.get('/user')
    Octoplex.get('/user/repos')
    
All requests return a `Hashr` object or `Array` of `Hashr` objects

All requests on the new v3 API are rate limited, to find out your current usage you can query
these two methods after each request:

    Octoplex.rate_limit #=> 5000
    Octoplex.rate_limit_remaining #=> 4999
    
    