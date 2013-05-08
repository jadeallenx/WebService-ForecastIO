#!/usr/bin/perl

use strict;
use Test::More;

if (!eval { require Socket; Socket::inet_aton('api.forecast.io') }) {
    plan skip_all => "Cannot connect to the API server";
} 
elsif ( ! $ENV{FORECASTIO_API_KEY} ) {
    plan skip_all => "FORECASTIO_API_KEY not set";
}
else {
    plan tests => 1;
}

use WebService::ForecastIO;
use Data::Printer;

my $fc = WebService::ForecastIO->new(
    api_key => $ENV{FORECASTIO_API_KEY},
    exclude => 'flags,hourly,minutely'
);

# Houston lat, lon
my $c =  $fc->request( 29.7492738082192, -95.4709680410959 );

p $c;

isnt($c, undef, "Content is truthy"); 
