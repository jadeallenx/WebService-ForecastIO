use 5.014;

package WebService::ForecastIO::Request;

use Moo::Role;
use HTTP::Tiny;
use JSON;

# ABSTRACT: Request role for WebService::ForecaseIO

=head1 OVERVIEW

This is a role which implements requests to the L<forecast.io> API.

=attr base_url

The base url to connect to the web service. Defaults to L<https://api.forecast.io/forecast>

=cut

has 'base_url' => (
    is => 'ro',
    default => sub { "https://api.forecast.io/forecast" },
);

has 'api_key' => (
    is => 'ro',
    required => 1
);

=attr ua

The user agent for the role. Uses L<HTTP::Tiny>.

=cut

has 'ua' => (
    is => 'ro',
    default => sub {
        HTTP::Tiny->new(
            agent => "WebService::ForecastIO/$WebService::ForecastIO::VERSION ",
            SSL_options => {
                SSL_hostname => "",
                SSL_verify_mode => 0
            },
        );
    },
    lazy => 1,
);

=attr decoder

The library to deserialize JSON responses. Uses L<JSON>.

=cut

has 'decoder' => (
    is => 'ro',
    default => sub {
        JSON->new();
    },
    lazy => 1,
);

sub request {
    my $self = shift;

    my $url = $self->base_url . "/" . $self->api_key . "/" . (join ",", @_);

    my $qp = join "&", (map {; "$_=" . $self->$_() } 
                        grep {; defined $self->$_() } qw(exclude units));

    if ( $qp ) {
        $url .= "?$qp";
    }

    my $response = $self->ua->get($url);

    if ( $response->{success} ) {
        $self->decoder->decode($response->{content});
    }
    else {
        die "Request to $url returned $response->{status}: $response->{content}\n";
    }
}

1;
