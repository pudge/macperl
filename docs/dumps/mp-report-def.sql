DROP TABLE IF EXISTS users;
CREATE TABLE users (
        id              INT(6) NOT NULL AUTO_INCREMENT,
        user            VARCHAR(32) NOT NULL,
        email           VARCHAR(64) NOT NULL,
        pass            CHAR(32) NOT NULL,
        sf_match        TINYINT(1) NOT NULL DEFAULT '0',
        PRIMARY KEY (id),
        UNIQUE (user)
);

DROP TABLE IF EXISTS tests;
CREATE TABLE tests (
        id              INT(6) NOT NULL AUTO_INCREMENT,
        test            VARCHAR(32) NOT NULL,
        status          INT(6) NOT NULL DEFAULT '0',
        PRIMARY KEY (id),
        UNIQUE (test)
);

DROP TABLE IF EXISTS code_param;
CREATE TABLE code_param (
        id              INT(6) NOT NULL AUTO_INCREMENT,
        type            VARCHAR(12) NOT NULL,
        name            VARCHAR(32) NOT NULL,
        PRIMARY KEY (id)
);

DROP TABLE IF EXISTS user_tests;
CREATE TABLE user_tests (
        id              INT(6) NOT NULL AUTO_INCREMENT,
        user_id         INT(6) NOT NULL,
        test_id         INT(6) NOT NULL,
        config_id       INT(6) NOT NULL,
        status          INT(6) NOT NULL,
        compiler        INT(6) NOT NULL,
        is_tool         TINYINT(1) NOT NULL DEFAULT '0',
        date            TIMESTAMP,
        notes           TEXT,
        results         BLOB,
        PRIMARY KEY (id)
);

DROP TABLE IF EXISTS configs;
CREATE TABLE configs (
        id              INT(6) NOT NULL AUTO_INCREMENT,
        user_id         INT(6) NOT NULL,
        processor       INT(6) NOT NULL,
        ram             INT(6) NOT NULL,
        version         INT(6) NOT NULL,
        cvs             TINYINT(1) NOT NULL DEFAULT '0',
        build           TINYINT(1) NOT NULL DEFAULT '0',
        mwc             TINYINT(1) NOT NULL DEFAULT '0',
        mpw             TINYINT(1) NOT NULL DEFAULT '0',
        date            TIMESTAMP,
        name            VARCHAR(32) NOT NULL,
        notes           TEXT,
        results         BLOB,
        PRIMARY KEY (id)
);

INSERT INTO code_param (type, name) VALUES ("compiler", "SC");
INSERT INTO code_param (type, name) VALUES ("compiler", "MrC");
INSERT INTO code_param (type, name) VALUES ("compiler", "MWC68K");
INSERT INTO code_param (type, name) VALUES ("compiler", "MWCPPC");

INSERT INTO code_param (type, name) VALUES ("processor", "68020");
INSERT INTO code_param (type, name) VALUES ("processor", "68030");
INSERT INTO code_param (type, name) VALUES ("processor", "68040");
INSERT INTO code_param (type, name) VALUES ("processor", "601");
INSERT INTO code_param (type, name) VALUES ("processor", "603");
INSERT INTO code_param (type, name) VALUES ("processor", "604");
INSERT INTO code_param (type, name) VALUES ("processor", "G3");
INSERT INTO code_param (type, name) VALUES ("processor", "G4");

INSERT INTO code_param (type, name) VALUES ("status", "OK");
INSERT INTO code_param (type, name) VALUES ("status", "Some porting needed");
INSERT INTO code_param (type, name) VALUES ("status", "Major porting needed");
INSERT INTO code_param (type, name) VALUES ("status", "Not applicable to platform");

INSERT INTO code_param (type, name) VALUES ("version", "5.6.1d2");

INSERT INTO tests (test) VALUES ("base/cond");
INSERT INTO tests (test) VALUES ("base/if");
INSERT INTO tests (test) VALUES ("base/lex");
INSERT INTO tests (test) VALUES ("base/pat");
INSERT INTO tests (test) VALUES ("base/rs");
INSERT INTO tests (test) VALUES ("base/term");
INSERT INTO tests (test) VALUES ("cmd/elsif");
INSERT INTO tests (test) VALUES ("cmd/for");
INSERT INTO tests (test) VALUES ("cmd/mod");
INSERT INTO tests (test) VALUES ("cmd/subval");
INSERT INTO tests (test) VALUES ("cmd/switch");
INSERT INTO tests (test) VALUES ("cmd/while");
INSERT INTO tests (test) VALUES ("comp/bproto");
INSERT INTO tests (test) VALUES ("comp/cmdopt");
INSERT INTO tests (test) VALUES ("comp/colon");
INSERT INTO tests (test) VALUES ("comp/cpp");
INSERT INTO tests (test) VALUES ("comp/decl");
INSERT INTO tests (test) VALUES ("comp/multiline");
INSERT INTO tests (test) VALUES ("comp/package");
INSERT INTO tests (test) VALUES ("comp/proto");
INSERT INTO tests (test) VALUES ("comp/redef");
INSERT INTO tests (test) VALUES ("comp/require");
INSERT INTO tests (test) VALUES ("comp/script");
INSERT INTO tests (test) VALUES ("comp/term");
INSERT INTO tests (test) VALUES ("comp/use");
INSERT INTO tests (test) VALUES ("io/argv");
INSERT INTO tests (test) VALUES ("io/dup");
INSERT INTO tests (test) VALUES ("io/fs");
INSERT INTO tests (test) VALUES ("io/inplace");
INSERT INTO tests (test) VALUES ("io/iprefix");
INSERT INTO tests (test) VALUES ("io/nargv");
INSERT INTO tests (test) VALUES ("io/open");
INSERT INTO tests (test) VALUES ("io/openpid");
INSERT INTO tests (test) VALUES ("io/pipe");
INSERT INTO tests (test) VALUES ("io/print");
INSERT INTO tests (test) VALUES ("io/read");
INSERT INTO tests (test) VALUES ("io/tell");
INSERT INTO tests (test) VALUES ("lib/abbrev");
INSERT INTO tests (test) VALUES ("lib/ansicolor");
INSERT INTO tests (test) VALUES ("lib/anydbm");
INSERT INTO tests (test) VALUES ("lib/attrs");
INSERT INTO tests (test) VALUES ("lib/autoloader");
INSERT INTO tests (test) VALUES ("lib/b");
INSERT INTO tests (test) VALUES ("lib/basename");
INSERT INTO tests (test) VALUES ("lib/bigfloat");
INSERT INTO tests (test) VALUES ("lib/bigfltpm");
INSERT INTO tests (test) VALUES ("lib/bigint");
INSERT INTO tests (test) VALUES ("lib/bigintpm");
INSERT INTO tests (test) VALUES ("lib/cgi-esc");
INSERT INTO tests (test) VALUES ("lib/cgi-form");
INSERT INTO tests (test) VALUES ("lib/cgi-function");
INSERT INTO tests (test) VALUES ("lib/cgi-html");
INSERT INTO tests (test) VALUES ("lib/cgi-pretty");
INSERT INTO tests (test) VALUES ("lib/cgi-request");
INSERT INTO tests (test) VALUES ("lib/charnames");
INSERT INTO tests (test) VALUES ("lib/checktree");
INSERT INTO tests (test) VALUES ("lib/class-struct");
INSERT INTO tests (test) VALUES ("lib/complex");
INSERT INTO tests (test) VALUES ("lib/db-btree");
INSERT INTO tests (test) VALUES ("lib/db-hash");
INSERT INTO tests (test) VALUES ("lib/db-recno");
INSERT INTO tests (test) VALUES ("lib/dirhand");
INSERT INTO tests (test) VALUES ("lib/dosglob");
INSERT INTO tests (test) VALUES ("lib/dprof");
INSERT INTO tests (test) VALUES ("lib/dumper-ovl");
INSERT INTO tests (test) VALUES ("lib/dumper");
INSERT INTO tests (test) VALUES ("lib/english");
INSERT INTO tests (test) VALUES ("lib/env-array");
INSERT INTO tests (test) VALUES ("lib/env");
INSERT INTO tests (test) VALUES ("lib/errno");
INSERT INTO tests (test) VALUES ("lib/fatal");
INSERT INTO tests (test) VALUES ("lib/fields");
INSERT INTO tests (test) VALUES ("lib/filecache");
INSERT INTO tests (test) VALUES ("lib/filecopy");
INSERT INTO tests (test) VALUES ("lib/filefind");
INSERT INTO tests (test) VALUES ("lib/filefunc");
INSERT INTO tests (test) VALUES ("lib/filehand");
INSERT INTO tests (test) VALUES ("lib/filepath");
INSERT INTO tests (test) VALUES ("lib/filespec");
INSERT INTO tests (test) VALUES ("lib/findbin");
INSERT INTO tests (test) VALUES ("lib/ftmp-mktemp");
INSERT INTO tests (test) VALUES ("lib/ftmp-posix");
INSERT INTO tests (test) VALUES ("lib/ftmp-security");
INSERT INTO tests (test) VALUES ("lib/ftmp-tempfile");
INSERT INTO tests (test) VALUES ("lib/gdbm");
INSERT INTO tests (test) VALUES ("lib/getopt");
INSERT INTO tests (test) VALUES ("lib/glob-basic");
INSERT INTO tests (test) VALUES ("lib/glob-case");
INSERT INTO tests (test) VALUES ("lib/glob-global");
INSERT INTO tests (test) VALUES ("lib/glob-taint");
INSERT INTO tests (test) VALUES ("lib/gol-basic");
INSERT INTO tests (test) VALUES ("lib/gol-compat");
INSERT INTO tests (test) VALUES ("lib/gol-linkage");
INSERT INTO tests (test) VALUES ("lib/gol-oo");
INSERT INTO tests (test) VALUES ("lib/h2ph");
INSERT INTO tests (test) VALUES ("lib/hostname");
INSERT INTO tests (test) VALUES ("lib/io_const");
INSERT INTO tests (test) VALUES ("lib/io_dir");
INSERT INTO tests (test) VALUES ("lib/io_dup");
INSERT INTO tests (test) VALUES ("lib/io_linenum");
INSERT INTO tests (test) VALUES ("lib/io_multihomed");
INSERT INTO tests (test) VALUES ("lib/io_pipe");
INSERT INTO tests (test) VALUES ("lib/io_poll");
INSERT INTO tests (test) VALUES ("lib/io_sel");
INSERT INTO tests (test) VALUES ("lib/io_sock");
INSERT INTO tests (test) VALUES ("lib/io_taint");
INSERT INTO tests (test) VALUES ("lib/io_tell");
INSERT INTO tests (test) VALUES ("lib/io_udp");
INSERT INTO tests (test) VALUES ("lib/io_unix");
INSERT INTO tests (test) VALUES ("lib/io_xs");
INSERT INTO tests (test) VALUES ("lib/ipc_sysv");
INSERT INTO tests (test) VALUES ("lib/ndbm");
INSERT INTO tests (test) VALUES ("lib/odbm");
INSERT INTO tests (test) VALUES ("lib/opcode");
INSERT INTO tests (test) VALUES ("lib/open2");
INSERT INTO tests (test) VALUES ("lib/open3");
INSERT INTO tests (test) VALUES ("lib/ops");
INSERT INTO tests (test) VALUES ("lib/parsewords");
INSERT INTO tests (test) VALUES ("lib/peek");
INSERT INTO tests (test) VALUES ("lib/ph");
INSERT INTO tests (test) VALUES ("lib/posix");
INSERT INTO tests (test) VALUES ("lib/safe1");
INSERT INTO tests (test) VALUES ("lib/safe2");
INSERT INTO tests (test) VALUES ("lib/sdbm");
INSERT INTO tests (test) VALUES ("lib/searchdict");
INSERT INTO tests (test) VALUES ("lib/selectsaver");
INSERT INTO tests (test) VALUES ("lib/selfloader");
INSERT INTO tests (test) VALUES ("lib/socket");
INSERT INTO tests (test) VALUES ("lib/soundex");
INSERT INTO tests (test) VALUES ("lib/symbol");
INSERT INTO tests (test) VALUES ("lib/syslfs");
INSERT INTO tests (test) VALUES ("lib/syslog");
INSERT INTO tests (test) VALUES ("lib/textfill");
INSERT INTO tests (test) VALUES ("lib/texttabs");
INSERT INTO tests (test) VALUES ("lib/textwrap");
INSERT INTO tests (test) VALUES ("lib/thr5005");
INSERT INTO tests (test) VALUES ("lib/tie-push");
INSERT INTO tests (test) VALUES ("lib/tie-refhash");
INSERT INTO tests (test) VALUES ("lib/tie-splice");
INSERT INTO tests (test) VALUES ("lib/tie-stdarray");
INSERT INTO tests (test) VALUES ("lib/tie-stdhandle");
INSERT INTO tests (test) VALUES ("lib/tie-stdpush");
INSERT INTO tests (test) VALUES ("lib/tie-substrhash");
INSERT INTO tests (test) VALUES ("lib/timelocal");
INSERT INTO tests (test) VALUES ("lib/trig");
INSERT INTO tests (test) VALUES ("op/64bitint");
INSERT INTO tests (test) VALUES ("op/anonsub");
INSERT INTO tests (test) VALUES ("op/append");
INSERT INTO tests (test) VALUES ("op/args");
INSERT INTO tests (test) VALUES ("op/arith");
INSERT INTO tests (test) VALUES ("op/array");
INSERT INTO tests (test) VALUES ("op/assignwarn");
INSERT INTO tests (test) VALUES ("op/attrs");
INSERT INTO tests (test) VALUES ("op/auto");
INSERT INTO tests (test) VALUES ("op/avhv");
INSERT INTO tests (test) VALUES ("op/bop");
INSERT INTO tests (test) VALUES ("op/chars");
INSERT INTO tests (test) VALUES ("op/chop");
INSERT INTO tests (test) VALUES ("op/closure");
INSERT INTO tests (test) VALUES ("op/cmp");
INSERT INTO tests (test) VALUES ("op/concat");
INSERT INTO tests (test) VALUES ("op/cond");
INSERT INTO tests (test) VALUES ("op/context");
INSERT INTO tests (test) VALUES ("op/defins");
INSERT INTO tests (test) VALUES ("op/delete");
INSERT INTO tests (test) VALUES ("op/die");
INSERT INTO tests (test) VALUES ("op/die_exit");
INSERT INTO tests (test) VALUES ("op/do");
INSERT INTO tests (test) VALUES ("op/each");
INSERT INTO tests (test) VALUES ("op/eval");
INSERT INTO tests (test) VALUES ("op/exec");
INSERT INTO tests (test) VALUES ("op/exists_sub");
INSERT INTO tests (test) VALUES ("op/exp");
INSERT INTO tests (test) VALUES ("op/fh");
INSERT INTO tests (test) VALUES ("op/filetest");
INSERT INTO tests (test) VALUES ("op/flip");
INSERT INTO tests (test) VALUES ("op/fork");
INSERT INTO tests (test) VALUES ("op/glob");
INSERT INTO tests (test) VALUES ("op/goto");
INSERT INTO tests (test) VALUES ("op/goto_xs");
INSERT INTO tests (test) VALUES ("op/grent");
INSERT INTO tests (test) VALUES ("op/grep");
INSERT INTO tests (test) VALUES ("op/groups");
INSERT INTO tests (test) VALUES ("op/gv");
INSERT INTO tests (test) VALUES ("op/hashwarn");
INSERT INTO tests (test) VALUES ("op/inc");
INSERT INTO tests (test) VALUES ("op/index");
INSERT INTO tests (test) VALUES ("op/int");
INSERT INTO tests (test) VALUES ("op/join");
INSERT INTO tests (test) VALUES ("op/length");
INSERT INTO tests (test) VALUES ("op/lex_assign");
INSERT INTO tests (test) VALUES ("op/lfs");
INSERT INTO tests (test) VALUES ("op/list");
INSERT INTO tests (test) VALUES ("op/local");
INSERT INTO tests (test) VALUES ("op/lop");
INSERT INTO tests (test) VALUES ("op/magic");
INSERT INTO tests (test) VALUES ("op/method");
INSERT INTO tests (test) VALUES ("op/misc");
INSERT INTO tests (test) VALUES ("op/mkdir");
INSERT INTO tests (test) VALUES ("op/my");
INSERT INTO tests (test) VALUES ("op/my_stash");
INSERT INTO tests (test) VALUES ("op/nothr5005");
INSERT INTO tests (test) VALUES ("op/numconvert");
INSERT INTO tests (test) VALUES ("op/oct");
INSERT INTO tests (test) VALUES ("op/ord");
INSERT INTO tests (test) VALUES ("op/pack");
INSERT INTO tests (test) VALUES ("op/pat");
INSERT INTO tests (test) VALUES ("op/pos");
INSERT INTO tests (test) VALUES ("op/push");
INSERT INTO tests (test) VALUES ("op/pwent");
INSERT INTO tests (test) VALUES ("op/quotemeta");
INSERT INTO tests (test) VALUES ("op/rand");
INSERT INTO tests (test) VALUES ("op/range");
INSERT INTO tests (test) VALUES ("op/read");
INSERT INTO tests (test) VALUES ("op/readdir");
INSERT INTO tests (test) VALUES ("op/recurse");
INSERT INTO tests (test) VALUES ("op/ref");
INSERT INTO tests (test) VALUES ("op/regexp");
INSERT INTO tests (test) VALUES ("op/regexp_noamp");
INSERT INTO tests (test) VALUES ("op/regmesg");
INSERT INTO tests (test) VALUES ("op/repeat");
INSERT INTO tests (test) VALUES ("op/reverse");
INSERT INTO tests (test) VALUES ("op/runlevel");
INSERT INTO tests (test) VALUES ("op/sleep");
INSERT INTO tests (test) VALUES ("op/sort");
INSERT INTO tests (test) VALUES ("op/splice");
INSERT INTO tests (test) VALUES ("op/split");
INSERT INTO tests (test) VALUES ("op/sprintf");
INSERT INTO tests (test) VALUES ("op/stat");
INSERT INTO tests (test) VALUES ("op/study");
INSERT INTO tests (test) VALUES ("op/subst");
INSERT INTO tests (test) VALUES ("op/subst_amp");
INSERT INTO tests (test) VALUES ("op/subst_wamp");
INSERT INTO tests (test) VALUES ("op/substr");
INSERT INTO tests (test) VALUES ("op/sysio");
INSERT INTO tests (test) VALUES ("op/taint");
INSERT INTO tests (test) VALUES ("op/tie");
INSERT INTO tests (test) VALUES ("op/tiearray");
INSERT INTO tests (test) VALUES ("op/tiehandle");
INSERT INTO tests (test) VALUES ("op/time");
INSERT INTO tests (test) VALUES ("op/tr");
INSERT INTO tests (test) VALUES ("op/undef");
INSERT INTO tests (test) VALUES ("op/universal");
INSERT INTO tests (test) VALUES ("op/unshift");
INSERT INTO tests (test) VALUES ("op/utf8decode");
INSERT INTO tests (test) VALUES ("op/vec");
INSERT INTO tests (test) VALUES ("op/ver");
INSERT INTO tests (test) VALUES ("op/wantarray");
INSERT INTO tests (test) VALUES ("op/write");
INSERT INTO tests (test) VALUES ("pragma/constant");
INSERT INTO tests (test) VALUES ("pragma/diagnostics");
INSERT INTO tests (test) VALUES ("pragma/locale");
INSERT INTO tests (test) VALUES ("pragma/overload");
INSERT INTO tests (test) VALUES ("pragma/strict");
INSERT INTO tests (test) VALUES ("pragma/sub_lval");
INSERT INTO tests (test) VALUES ("pragma/subs");
INSERT INTO tests (test) VALUES ("pragma/utf8");
INSERT INTO tests (test) VALUES ("pragma/warnings");
