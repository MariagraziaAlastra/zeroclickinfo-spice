package DDG::Spice::SeatGeek::Sports;
# ABSTRACT: Returns upcoming sport events for a given team/performer.

use DDG::Spice;

primary_example_queries "UEFA Champions League events", "Bayern-Munich upcoming matches";
description "Upcoming sport events from SeatGeek";
name "SeatGeek Sports";
code_url "https://github.com/duckduckgo/zeroclickinfo-spice/blob/master/lib/DDG/Spice/SeatGeek/Sports.pm";
category "entertainment";
topics "entertainment";
attribution github => ['https://github.com/MariagraziaAlastra','MariagraziaAlastra'];

triggers startend => 'upcoming matches', 'events', 'event', 'upcoming match';

spice to => 'http://api.seatgeek.com/2/events?performers.slug=$1&taxonomies.name=sports';
spice wrap_jsonp_callback => 1;

handle remainder_lc => sub {
    # Removes triggers from the query
    $_ =~ s/^(:?(upcoming\s*)?(match(es)?))|(events?)$//gi;
    # Removes spaces from the beginning of the query
    $_ =~ s/^\s+//;
    # Removes spaces from the end of the query
    $_ =~ s/\s+$//;
    # Replaces spaces between words with dashes, because the API requires it
    #$_ =~ s/\s/\-/g;
    return $_ if $_;
    return;
};

1;