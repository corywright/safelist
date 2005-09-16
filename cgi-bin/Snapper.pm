package Snapper;
use base 'CGI::Application';
use HTTP::Request::Common;
use strict;

sub setup {
      my $self = shift;
      $self->start_mode('mode1');
      $self->mode_param('rm');
      $self->run_modes(
              'mode1' => 'do_snapshot',
      );
}

sub do_snapshot {
	my $self = shift;
	my $q = $self->query();
	my $id = $q->param("id");
	my $url = $q->param("url");
	my $file = &get_picture;
	#TODO: handle failures
	
	POST $url,
       Content_Type => 'form-data',
       Content      => [ 
						file	=> [$file],
                       ]
	#TODO: handle errors here, too.	
	
}

sub get_picture {
	# in here we will grab the picture, and return the path to it.
}
1;
