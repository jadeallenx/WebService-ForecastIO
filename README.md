# NAME

WebService::ForecastIO - Perl client for api.forecast.io

# VERSION

version 0.01

# SYNOPSIS

    use 5.014;

    my $forecast = WebService::ForecastIO->new(
            api_key => 'secret',
            units => 'si', # metric units
            exclude => 'hourly,minutely,currently,flags', # get 7 day forecast only
    );

    #                             latitude          longitude
    my $json = $forecast->request(29.7492738082192, -95.4709680410959);

    # Human readable summary of daily data
    say $json->{daily}->{summary};

# OVERVIEW

This is a Perl client for [forecast.io API](https://developer.forecast.io). Forecast.io 
applies "big data" analysis techniques to publicly available weather data including 
radar image analysis.  One of the things it attempts to predict is _when_ certain
weather events like rain will start, and the duration of those events.

This library requires an API key which can be obtained for free from the 
[developer web site](https://developer.forecast.io). The first 1,000 calls
per day are allowed without charge.  (More calls can be made if payment arrangements
are made.)

See the [API docs](https://developer.forecast.io/docs/v2) for full details about
what data is provided and what granularity data sets are offered.

__NOTE__: Errors are fatal. Please use something like [Try::Tiny](http://search.cpan.org/perldoc?Try::Tiny) if you
want to handle errors some other way.

# ATTRIBUTES

## units

This attribute overrides the default units of `us`. Available units are:

- `si`

Metric units (windspeed in meters/second)

- `ca`

Metric units, except windspeed in km/h

- `uk`

Metric units, except windspeed in mi/h

- `auto`

Unit selection based on request IP geolocation

## exclude

A comma delimited list of data sets to exclude. Choices are:

`minutely`, `currently`, `hourly`, `daily`, `alerts`, `flags`

See the API docs for information about what these data blocks represent.

Spaces should be omitted between exclusions.

## api\_key

Holds the API key for the forecast.io service.

# METHODS

## request

This method takes two or three parameters.

The first two parameters are `latitude` and `longitude` expressed
as floats. The optional third parameter is a `time` value. The time
value can be expressed as either epoch seconds or as an iso8601
format time. 

Data sets up to 60 years old are available. (Such times should
be expressed as iso8601 format times since epoch seconds start
at midnight, January 1, 1970.)

## to\_timepiece

A convenience method that takes epoch seconds and returns a
new [Time::Piece](http://search.cpan.org/perldoc?Time::Piece) object.  You can stringify this object to
iso8601 format by calling the `datetime()` method on it.

## parse\_datetime

A convenience method that takes an iso8601 formatted string
and returns a new [Time::Piece](http://search.cpan.org/perldoc?Time::Piece) object. This object can output
epoch seconds by calling the `epoch()` method on it.

# SEE ALSO

- [WebService::ForecastIO::Request](http://search.cpan.org/perldoc?WebService::ForecastIO::Request)
- [API docs](https://developer.forecast.io/docs/v2)

# AUTHOR

Mark Allen <mrallen1@yahoo.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Mark Allen.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
