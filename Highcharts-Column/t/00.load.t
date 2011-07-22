use Test::More tests => 1;

use Highcharts::Column;

my @y_data = (
	{ name=> 'y1' , data=> "10,3,2"},{ name=> 'y2' , data=> "1,3,2"} 
);

my %sample =  (
	id	 		=> 'テスト',
	title		=> 'TiTle',
	subtitle	=> 'Sub TiTle',
	x_values	=> "10,12,1",
	xaxis_title =>"xaxis_title",
	yaxis_title =>"yaxis_title",
	y_values	=> \@y_data,

);


 my $result = Highcharts::Column->new();
 
 $result->set_data(%sample);

# can get id?

ok ( $result->draw(),"Draw");


