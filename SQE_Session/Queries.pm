package Queries;
use strict;
use warnings FATAL => 'all';

use Package::Constants;

use constant {

    NEW_SQE_SESSION => << 'MYSQL',
      INSERT INTO sqe_session (sqe_session_id,
                               user_id,
                               scroll_version_id)
             VALUES (?,?,?)
MYSQL


    SET_SESSION_END => << 'MYSQL',
      UPDATE sqe_session
      SET last_internal_session_end = now(),
          scroll_version_id = ?
      WHERE sqe_session_id = ?
MYSQL

    GET_SCROLLVERSION => <<'MYSQL',
      SELECT  scroll_version_id,
              scroll_version_group_id
      FROM scroll_version
      WHERE user_id like ?  AND scroll_version_id = ?;
MYSQL

    LOGIN => <<'MYSQL',
      SELECT user_id
      FROM user
      WHERE user_name like ?
      AND   pw = SHA2(?, 224);
MYSQL

};

use Exporter 'import';
our @EXPORT_OK = Package::Constants->list(__PACKAGE__);

1;
