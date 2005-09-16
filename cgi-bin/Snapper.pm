package Snapper;
use base 'CGI::Application';
use HTTP::Request::Common;
use Data::Dumper;
use LWP::UserAgent;
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
	my $host = $q->param("host");
	my $file = &get_picture;
	#TODO: handle failures from get_pic
	
	my $ua = LWP::UserAgent->new;
	
	
	my $res = $ua->request(POST $url,
       Content_Type => 'form-data',
       Content      => [ 
						id	=> $id,
						file	=> [$file],
                       ]);
	#TODO: handle errors here, too.	
	print $q->redirect("http://$host/people/show/$id");
#	print "Content-type: text/html\n\n";
#	print "file is $file\n";
#	print Dumper($res);
}

sub get_picture {
	# in here we will grab the picture, and return the path to it.
	return '/var/www/test.jpg'
}
1;
