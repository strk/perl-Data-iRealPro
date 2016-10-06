#! perl

# Data::iRealPro::Output::HTML -- produce iRealPro HTML data

# Author          : Johan Vromans
# Created On      : Fri Sep 30 19:36:29 2016
# Last Modified By: Johan Vromans
# Last Modified On: Thu Oct  6 21:23:41 2016
# Update Count    : 50
# Status          : Unknown, Use with caution!

################ Common stuff ################

use strict;
use warnings;
use Carp;
use utf8;

package Data::iRealPro::Output::HTML;

use parent qw( Data::iRealPro::Output::Base );

our $VERSION = "0.02";

use Data::iRealPro::URI;
use Data::iRealPro::Playlist;
use Encode qw( encode_utf8 );
use HTML::Entities;
use File::Path qw( make_path );

my $regtest = $ENV{IRP_REGTEST};

sub options {
    my $self = shift;
    [ @{ $self->SUPER::options }, qw( split dir ) ];
}

sub process {
    my ( $self, $u, $options ) = @_;

    unless ( $self->{split} ) {

	$self->{output} ||= $options->{output} || "__new__.html";

	if ( ref( $self->{output} ) ) {
	    ${ $self->{output} } = to_html($u);
	}
	else {
	    open( my $fd, ">:utf8", $self->{output} )
	      or croak( "Cannot create ", $self->{output}, " [$!]\n" );
	    print $fd to_html($u);
	    close($fd);
	}
	return;
    }

    my $outdir = $self->{dir} || "";
    $outdir .= "/" if $outdir && $outdir !~ m;/$;;
    make_path( $outdir, {} ) unless -d $outdir;

    foreach my $song ( @{ $u->{playlist}->{songs} } ) {

	# Make a playlist with just this song.
	my $pls = Data::iRealPro::Playlist->new( song => $song );

	# Make an URI for this playlist.
	my $uri = Data::iRealPro::URI->new( playlist => $pls );

	# Write it out.
	my $title = $song->{title};
	# Mask dangerous characters.
	$title =~ s/[:?\\\/*"<>|]/@/g;
	my $file = $outdir.$title.".html";
	my $out = encode_utf8($file);
	open( my $fd, '>:utf8', $out )
	  or die( "$out: $!\n" );
	print $fd to_html($uri);
	close($fd);
	warn( "Wrote $out\n" )
	  if $self->{verbose};
    }
}

sub to_html {
    my ( $u ) = @_;

    my $pl = $u->{playlist};
    my $title;
    if ( $pl->{name} ) {
	$title = _html($pl->{name});
    }
    else {
	$title = _html($pl->{songs}->[0]->{title});
    }
    my $vv = $regtest ? "" : " version $Data::iRealPro::VERSION";
    my $html = <<EOD;
<!DOCTYPE html>
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>$title</title>
  <style type="text/css">
  body {
    color: rgb(230, 227, 218);
    background-color: rgb(27, 39, 48);
    font-family: Helvetica,Arial,sans-serif;
  }
  a         { text-decoration: none }
  a:active  { color: #b2e0ff }
  a:link    { color: #94d5ff }
  a:visited { color: #b2e0ff }
  .info {
    font-size: small;
    color: #999999;
  }
  </style>
</head>
<body>
  <h1>$title</h1>
EOD

    if ( $pl->{name} || @{ $pl->{songs} } > 1 ) {
	$html .= "  <p><a href=\"" . $u->as_string(1) .
	  "\" target=\"_blank\">(All songs)</a></p>\n  <ol>\n";
	foreach my $s ( @{ $pl->{songs} } ) {
	    my @c = split(' ', $s->{composer});
	    my $c = @c == 2 ? "$c[1] $c[0]" : $s->{composer};
	    $html .= "    <li><a href=\"irealb://" .
	      _esc($s->as_string) .
		"\" target=\"_blank\">" .
		  _html($s->{title}) .
		    "</a> - " .
		      _html($c) .
			( $s->{ts} ? " <span class=\"info\">(@{[$s->{ts}]})</span>" : "" ) .
			  "</li>\n";
	}

	$html .= "  </ol>\n";
    }
    else {
	$html .= qq{  <p><a href="@{[ $u->as_string(1) ]}" target=\"_blank\">$title</a></p>\n};
    }

    $html .= <<EOD;
    <p class="info">Generated by <a href="https://metacpan.org/pod/Data::iRealPro" target="_blank">Data::iRealPro</a>$vv.</p>
</body>
</html>
EOD
}

sub _esc {
    goto \&Data::iRealPro::URI::esc;
}

sub _html {
    encode_entities($_[0]);
}

1;
