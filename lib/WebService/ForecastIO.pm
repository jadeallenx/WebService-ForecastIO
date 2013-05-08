use 5.014;

package WebService::ForecastIO;

use Moo;
with 'WebService::ForecastIO::Request';

has 'units' => (
    is => 'ro',
);

has 'exclude' => (
    is => 'ro',
);

1;
