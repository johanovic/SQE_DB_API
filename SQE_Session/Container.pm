package Container;
use strict;
use warnings FATAL => 'all';

use SQE_Session::Session;


=head2 new()

Simple constructor

=over 1

=item Parameters: none

=item Returns an Instance of Container

=back

=cut

#@returns Container
sub new {
    return bless {}, $_[0];
}

=head2 get_session_dbh_by_id($session_id)

Calls or reloads a defined a session and returns it database handler

=over 1

=item Parameters: Session id

=item Returns SQE_db || (undef, error_ref)

=back

=cut

#@returns SQE_db
sub get_session_dbh_by_id {
    my ($self, $session_id) = @_;

    my Session $session = $self->{$session_id};
    if ($session) {
        # The session was found in the container
        # Validate its databasehandler and return the session or (undef, error_ref)
        return $session->valid_dbh();
    } else {
        return (undef, SQE_Error::WRONG_SESSION_ID)
    }
}

=head2 new_session_dbh($cgi_data)

Creates a new session and returns its database handler

=over 1

=item Parameters: Hashreferenc with the CGI-Data

=item Returns SQE_db || (undef, error_ref)

=back

=cut

#@returns SQE_db
sub new_session_dbh {
    my ($self, $cgi_data) = @_;
    my (
        #@type Session
        $session,
        $error_ref
    ) = Session->new($cgi_data);
    if ($session) {
        $self->{$session->{SESSION_ID}} = $session;
        return $session->{DBH};
    } else {
        return (undef, $error_ref);
    }


}

1;