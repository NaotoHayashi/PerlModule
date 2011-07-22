package Highcharts::Column;

use strict;
use warnings;
our $VERSION = '0.0.2';


# 現状は入力データがUTF-8であることを前提にしている。
# コード自体はUnicodeで書いておいて他のコードの入力が着ても内部はUTF-8
# としてデータを処理できるようにすべき。
# モジュールとしては対象のJSの記述を返す形がシンプルで良いのか？
# 出力系は元のスクリプト側に任せる？

sub new {
    my $class = shift;
    my $self =  $class->_init(); 
    return bless $self, $class;
}



sub set_data{
    my $self = shift;
    my %properties = @_;
    while (my($key, $value) = each(%properties)) {
        $self->{$key} = $value ;
    }
}


sub draw  {
    my $self = shift;
    # draw header
    my $header = &_header($self);    
    my $story;
    my $cnt;    

    # draw data
    foreach my $data(@{$self->{y_values}}) {
        if( $cnt++  ne 0 ) { $story .= "                ,\n"}
        $story .= &_story ($data);
    }
    # drawa footer

    my $footer = &_footer;
    my $js = $header.$story.$footer;
    return($js);    
}

sub _init {
    my $class = shift;
    my @y_data =(
        { name=> 'y1' , data=> "1,2,3"},{ name=> 'y2' , data=> "3,2,1"} 
    );
    my $self =  {
        id          => 'Sample',
        title       => 'Title',
        subtitle    => 'Sub Title',
        x_values    => "1,2,3",
        xaxis_title => "xaxis title",
        yaxis_title => "yaxis title",
        y_values    =>  \@y_data, 
   };

    return bless $self, $class;

}
sub _header  {
    my $self = shift;
    my $header = ' ';
    $header = <<_HEADER_;
    var char;
    \$(document).ready(function() {
        chart = new Highcharts.Chart(
        {
            chart: {
                renderTo: 'chart_column_$self->{id}',
                defaultSeriesType: 'column'
            },
            title: {
                text: '$self->{title}'
            },
            subtitle: {
                text: '$self->{subtitle}'
            },
            xAxis:  {
                categories:  [ $self->{x_values} ],
                title:  { 
                    text : '$self->{xaxis_title}'
                }
            },
            yAxis: {        
                title: {
                    text: '$self->{yaxis_title}'
                }
            },
            series: [
_HEADER_

    return($header);
}
sub _story       {
    my $data = shift;
    my $story =<<_STORY_;
                { 
                    name : '$data->{name}',
                    data : [$data->{data}]
                }
_STORY_
    return($story);
}
sub _footer  {
    my $footer = <<_FOOTER_;
                ]
        }); 
    });
_FOOTER_
}

1;

__END__
=head1 NAME

Highcharts::Column 

library for Highcharts, Basic Column.


=head1 VERSION

Version 0.01

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Highcharts::Column;

    my $foo = Highcharts::Column->new();
    
	my @y_data = ({ name=> 'y1' , data=> "10,3,2"},
					{ name=> 'y2' , data=> "1,3,2"} 
			);

	my  %config = 
			id	 		=> 'Test',
			title		=> 'TiTle',
			subtitle	=> 'Sub TiTle',
			x_values	=> "10,12,1",
			xaxis_title =>"xaxis_title",
			yaxis_title =>"yaxis_title",
			y_values	=> \@y_data,
	);

	my $result = Highcharts::Column->new();

	$result->set_data(%sample);
	my $js = $result->draw();
	print $js;

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 new


=head2 set_data

=head2 draw



=head1 AUTHOR

Hayashi Naoto, C<< <Hayashi.Naoto at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-highcharts-column at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Highcharts-Column>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Highcharts::Column


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Highcharts-Column>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Highcharts-Column>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Highcharts-Column>

=item * Search CPAN

L<http://search.cpan.org/dist/Highcharts-Column/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Hayashi Naoto.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Highcharts::Column
