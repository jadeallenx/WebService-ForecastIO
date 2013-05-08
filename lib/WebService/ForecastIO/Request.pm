use 5.014;

package WebService::ForecastIO::Request;

use Moo::Role;
use HTTP::Tiny;
use JSON;

has 'base_url' => (
    is => 'ro',
    default => sub { "https://api.forecast.io/forecast" },
);

has 'api_key' => (
    is => 'ro',
    required => 1
);

has 'ua' => (
    is => 'ro',
    default => sub {
        HTTP::Tiny->new(
            SSL_options => {
                SSL_hostname => "",
                SSL_verify_mode => 0
            },
        );
    },
    lazy => 1,
);

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
        $self->decoder->utf8->decode($response->{content});
    }
    else {
        die "Request to $url returned $response->{status}: $response->{content}\n";
    }
}

1;
