package Code::TidyAll::Plugin::JSBeautify;
use IPC::System::Simple qw(run);
use Moo;
use Try::Tiny;
extends 'Code::TidyAll::Plugin';

sub _build_cmd { 'js-beautify' }

sub transform_file {
    my ( $self, $file ) = @_;

    try {
        run( sprintf( "%s --replace %s %s", $self->cmd, $self->argv, $file ) );
    }
    catch {
        die sprintf( "%s exited with error - possibly bad arg list '%s'", $self->cmd, $self->argv );
    };
}

1;

__END__

=pod

=head1 NAME

Code::TidyAll::Plugin::JSBeautify - use js-beautify with tidyall

=head1 SYNOPSIS

   In tidyall.ini:

   [JSBeautify]
   select = static/**/*.js
   argv = --indent-size 2 --brace-style expand

=head1 DESCRIPTION

Runs L<js-beautify|https://npmjs.org/package/js-beautify>, a JavaScript tidier.

=head1 INSTALLATION

Install L<npm|https://npmjs.org/>, then run

    npm install js-beautify -g

Do not confuse this with the C<jsbeautify> package (without the dash).

=head1 CONFIGURATION

=over

=item argv

Arguments to pass to js-beautify

=item cmd

Full path to js-beautify

=back
