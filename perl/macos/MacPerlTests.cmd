# ::macos:perl -I::lib -e 'for(<:*:*.t>){open my $fh,"<$_";$t=<$fh>=~/(T)/?"-T":"  ";$s="$^X -I::lib $t $_"; print qq[echo "$s"\n$s\n]}'
set -e MACPERL ""
set -e PERL5LIB ""
perl -e '`set -e MACPERL_OLD "{{MACPERL}}"`'
perl -e '`set -e PERL5LIB_OLD "{{PERL5LIB}}"`'
perl -e '`set -e MACPERL ""`'
perl -e '`set -e PERL5LIB ""`'
echo "When finished, execute these lines to restore your environment:"
echo "perl -e '¶`set -e MACPERL ¶"¶{¶{MACPERL_OLD¶}¶}¶"¶`'"
echo "perl -e '¶`set -e PERL5LIB ¶"¶{¶{PERL5LIB_OLD¶}¶}¶"¶`'"
echo ""

echo "::macos:perl -I::lib    :base:cond.t"
::macos:perl -I::lib    :base:cond.t
echo "::macos:perl -I::lib    :base:if.t"
::macos:perl -I::lib    :base:if.t
echo "::macos:perl -I::lib    :base:lex.t"
::macos:perl -I::lib    :base:lex.t
echo "::macos:perl -I::lib    :base:pat.t"
::macos:perl -I::lib    :base:pat.t
echo "::macos:perl -I::lib    :base:rs.t"
::macos:perl -I::lib    :base:rs.t
echo "::macos:perl -I::lib    :base:term.t"
::macos:perl -I::lib    :base:term.t
echo "::macos:perl -I::lib    :cmd:elsif.t"
::macos:perl -I::lib    :cmd:elsif.t
echo "::macos:perl -I::lib    :cmd:for.t"
::macos:perl -I::lib    :cmd:for.t
echo "::macos:perl -I::lib    :cmd:mod.t"
::macos:perl -I::lib    :cmd:mod.t
echo "::macos:perl -I::lib    :cmd:subval.t"
::macos:perl -I::lib    :cmd:subval.t
echo "::macos:perl -I::lib    :cmd:switch.t"
::macos:perl -I::lib    :cmd:switch.t
echo "::macos:perl -I::lib    :cmd:while.t"
::macos:perl -I::lib    :cmd:while.t
echo "::macos:perl -I::lib    :comp:bproto.t"
::macos:perl -I::lib    :comp:bproto.t
echo "::macos:perl -I::lib    :comp:cmdopt.t"
::macos:perl -I::lib    :comp:cmdopt.t
echo "::macos:perl -I::lib    :comp:colon.t"
::macos:perl -I::lib    :comp:colon.t
echo "::macos:perl -I::lib    :comp:cpp.t"
::macos:perl -I::lib    :comp:cpp.t
echo "::macos:perl -I::lib    :comp:decl.t"
::macos:perl -I::lib    :comp:decl.t
echo "::macos:perl -I::lib    :comp:multiline.t"
::macos:perl -I::lib    :comp:multiline.t
echo "::macos:perl -I::lib    :comp:package.t"
::macos:perl -I::lib    :comp:package.t
echo "::macos:perl -I::lib    :comp:proto.t"
::macos:perl -I::lib    :comp:proto.t
echo "::macos:perl -I::lib    :comp:redef.t"
::macos:perl -I::lib    :comp:redef.t
echo "::macos:perl -I::lib    :comp:require.t"
::macos:perl -I::lib    :comp:require.t
echo "::macos:perl -I::lib    :comp:script.t"
::macos:perl -I::lib    :comp:script.t
echo "::macos:perl -I::lib    :comp:term.t"
::macos:perl -I::lib    :comp:term.t
echo "::macos:perl -I::lib    :comp:use.t"
::macos:perl -I::lib    :comp:use.t
echo "::macos:perl -I::lib    :io:argv.t"
::macos:perl -I::lib    :io:argv.t
echo "::macos:perl -I::lib    :io:dup.t"
::macos:perl -I::lib    :io:dup.t
echo "::macos:perl -I::lib    :io:fs.t"
::macos:perl -I::lib    :io:fs.t
echo "::macos:perl -I::lib    :io:inplace.t"
::macos:perl -I::lib    :io:inplace.t
echo "::macos:perl -I::lib    :io:iprefix.t"
::macos:perl -I::lib    :io:iprefix.t
echo "::macos:perl -I::lib    :io:nargv.t"
::macos:perl -I::lib    :io:nargv.t
echo "::macos:perl -I::lib    :io:open.t"
::macos:perl -I::lib    :io:open.t
echo "::macos:perl -I::lib    :io:openpid.t"
::macos:perl -I::lib    :io:openpid.t
echo "::macos:perl -I::lib    :io:pipe.t"
::macos:perl -I::lib    :io:pipe.t
echo "::macos:perl -I::lib    :io:print.t"
::macos:perl -I::lib    :io:print.t
echo "::macos:perl -I::lib    :io:read.t"
::macos:perl -I::lib    :io:read.t
echo "::macos:perl -I::lib    :io:tell.t"
::macos:perl -I::lib    :io:tell.t
echo "::macos:perl -I::lib    :lib:abbrev.t"
::macos:perl -I::lib    :lib:abbrev.t
echo "::macos:perl -I::lib    :lib:ansicolor.t"
::macos:perl -I::lib    :lib:ansicolor.t
echo "::macos:perl -I::lib    :lib:anydbm.t"
::macos:perl -I::lib    :lib:anydbm.t
echo "::macos:perl -I::lib    :lib:attrs.t"
::macos:perl -I::lib    :lib:attrs.t
echo "::macos:perl -I::lib    :lib:autoloader.t"
::macos:perl -I::lib    :lib:autoloader.t
echo "::macos:perl -I::lib    :lib:b.t"
::macos:perl -I::lib    :lib:b.t
echo "::macos:perl -I::lib -T :lib:basename.t"
::macos:perl -I::lib -T :lib:basename.t
echo "::macos:perl -I::lib    :lib:bigfloat.t"
::macos:perl -I::lib    :lib:bigfloat.t
echo "::macos:perl -I::lib    :lib:bigfltpm.t"
::macos:perl -I::lib    :lib:bigfltpm.t
echo "::macos:perl -I::lib    :lib:bigint.t"
::macos:perl -I::lib    :lib:bigint.t
echo "::macos:perl -I::lib    :lib:bigintpm.t"
::macos:perl -I::lib    :lib:bigintpm.t
echo "::macos:perl -I::lib    :lib:cgi-esc.t"
::macos:perl -I::lib    :lib:cgi-esc.t
echo "::macos:perl -I::lib    :lib:cgi-form.t"
::macos:perl -I::lib    :lib:cgi-form.t
echo "::macos:perl -I::lib    :lib:cgi-function.t"
::macos:perl -I::lib    :lib:cgi-function.t
echo "::macos:perl -I::lib    :lib:cgi-html.t"
::macos:perl -I::lib    :lib:cgi-html.t
echo "::macos:perl -I::lib    :lib:cgi-pretty.t"
::macos:perl -I::lib    :lib:cgi-pretty.t
echo "::macos:perl -I::lib    :lib:cgi-request.t"
::macos:perl -I::lib    :lib:cgi-request.t
echo "::macos:perl -I::lib    :lib:charnames.t"
::macos:perl -I::lib    :lib:charnames.t
echo "::macos:perl -I::lib    :lib:checktree.t"
::macos:perl -I::lib    :lib:checktree.t
echo "::macos:perl -I::lib    :lib:class-struct.t"
::macos:perl -I::lib    :lib:class-struct.t
echo "::macos:perl -I::lib    :lib:complex.t"
::macos:perl -I::lib    :lib:complex.t
# echo "::macos:perl -I::lib    :lib:db-btree.t"
# ::macos:perl -I::lib    :lib:db-btree.t
# echo "::macos:perl -I::lib    :lib:db-hash.t"
# ::macos:perl -I::lib    :lib:db-hash.t
# echo "::macos:perl -I::lib    :lib:db-recno.t"
# ::macos:perl -I::lib    :lib:db-recno.t
echo "::macos:perl -I::lib    :lib:dirhand.t"
::macos:perl -I::lib    :lib:dirhand.t
# echo "::macos:perl -I::lib    :lib:dosglob.t"
# ::macos:perl -I::lib    :lib:dosglob.t
# echo "::macos:perl -I::lib    :lib:dprof.t"
# ::macos:perl -I::lib    :lib:dprof.t
echo "::macos:perl -I::lib    :lib:dumper-ovl.t"
::macos:perl -I::lib    :lib:dumper-ovl.t
echo "::macos:perl -I::lib    :lib:dumper.t"
::macos:perl -I::lib    :lib:dumper.t
echo "::macos:perl -I::lib    :lib:english.t"
::macos:perl -I::lib    :lib:english.t
echo "::macos:perl -I::lib    :lib:env-array.t"
::macos:perl -I::lib    :lib:env-array.t
echo "::macos:perl -I::lib    :lib:env.t"
::macos:perl -I::lib    :lib:env.t
echo "::macos:perl -I::lib    :lib:errno.t"
::macos:perl -I::lib    :lib:errno.t
echo "::macos:perl -I::lib    :lib:fatal.t"
::macos:perl -I::lib    :lib:fatal.t
echo "::macos:perl -I::lib    :lib:fields.t"
::macos:perl -I::lib    :lib:fields.t
echo "::macos:perl -I::lib    :lib:filecache.t"
::macos:perl -I::lib    :lib:filecache.t
echo "::macos:perl -I::lib    :lib:filecopy.t"
::macos:perl -I::lib    :lib:filecopy.t
echo "::macos:perl -I::lib -T :lib:filefind-taint.t"
::macos:perl -I::lib -T :lib:filefind-taint.t
echo "::macos:perl -I::lib    :lib:filefind.t"
::macos:perl -I::lib    :lib:filefind.t
echo "::macos:perl -I::lib    :lib:filefunc.t"
::macos:perl -I::lib    :lib:filefunc.t
echo "::macos:perl -I::lib    :lib:filehand.t"
::macos:perl -I::lib    :lib:filehand.t
echo "::macos:perl -I::lib    :lib:filepath.t"
::macos:perl -I::lib    :lib:filepath.t
echo "::macos:perl -I::lib    :lib:filespec.t"
::macos:perl -I::lib    :lib:filespec.t
echo "::macos:perl -I::lib    :lib:findbin.t"
::macos:perl -I::lib    :lib:findbin.t
# echo "::macos:perl -I::lib    :lib:ftmp-mktemp.t"
# ::macos:perl -I::lib    :lib:ftmp-mktemp.t
# echo "::macos:perl -I::lib    :lib:ftmp-posix.t"
# ::macos:perl -I::lib    :lib:ftmp-posix.t
# echo "::macos:perl -I::lib    :lib:ftmp-security.t"
# ::macos:perl -I::lib    :lib:ftmp-security.t
# echo "::macos:perl -I::lib    :lib:ftmp-tempfile.t"
# ::macos:perl -I::lib    :lib:ftmp-tempfile.t
echo "::macos:perl -I::lib    :lib:gdbm.t"
::macos:perl -I::lib    :lib:gdbm.t
echo "::macos:perl -I::lib    :lib:getopt.t"
::macos:perl -I::lib    :lib:getopt.t
echo "::macos:perl -I::lib    :lib:glob-basic.t"
::macos:perl -I::lib    :lib:glob-basic.t
echo "::macos:perl -I::lib    :lib:glob-case.t"
::macos:perl -I::lib    :lib:glob-case.t
echo "::macos:perl -I::lib    :lib:glob-global.t"
::macos:perl -I::lib    :lib:glob-global.t
echo "::macos:perl -I::lib -T :lib:glob-taint.t"
::macos:perl -I::lib -T :lib:glob-taint.t
echo "::macos:perl -I::lib    :lib:gol-basic.t"
::macos:perl -I::lib    :lib:gol-basic.t
echo "::macos:perl -I::lib    :lib:gol-compat.t"
::macos:perl -I::lib    :lib:gol-compat.t
echo "::macos:perl -I::lib    :lib:gol-linkage.t"
::macos:perl -I::lib    :lib:gol-linkage.t
echo "::macos:perl -I::lib    :lib:gol-oo.t"
::macos:perl -I::lib    :lib:gol-oo.t
echo "::macos:perl -I::lib    :lib:h2ph.t"
::macos:perl -I::lib    :lib:h2ph.t
echo "::macos:perl -I::lib    :lib:hostname.t"
::macos:perl -I::lib    :lib:hostname.t
echo "::macos:perl -I::lib    :lib:io_const.t"
::macos:perl -I::lib    :lib:io_const.t
echo "::macos:perl -I::lib    :lib:io_dir.t"
::macos:perl -I::lib    :lib:io_dir.t
echo "::macos:perl -I::lib    :lib:io_dup.t"
::macos:perl -I::lib    :lib:io_dup.t
echo "::macos:perl -I::lib    :lib:io_linenum.t"
::macos:perl -I::lib    :lib:io_linenum.t
echo "::macos:perl -I::lib    :lib:io_multihomed.t"
::macos:perl -I::lib    :lib:io_multihomed.t
echo "::macos:perl -I::lib    :lib:io_pipe.t"
::macos:perl -I::lib    :lib:io_pipe.t
echo "::macos:perl -I::lib    :lib:io_poll.t"
::macos:perl -I::lib    :lib:io_poll.t
echo "::macos:perl -I::lib    :lib:io_sel.t"
::macos:perl -I::lib    :lib:io_sel.t
echo "::macos:perl -I::lib    :lib:io_sock.t"
::macos:perl -I::lib    :lib:io_sock.t
echo "::macos:perl -I::lib -T :lib:io_taint.t"
::macos:perl -I::lib -T :lib:io_taint.t
echo "::macos:perl -I::lib    :lib:io_tell.t"
::macos:perl -I::lib    :lib:io_tell.t
echo "::macos:perl -I::lib    :lib:io_udp.t"
::macos:perl -I::lib    :lib:io_udp.t
echo "::macos:perl -I::lib    :lib:io_unix.t"
::macos:perl -I::lib    :lib:io_unix.t
echo "::macos:perl -I::lib    :lib:io_xs.t"
::macos:perl -I::lib    :lib:io_xs.t
echo "::macos:perl -I::lib    :lib:ipc_sysv.t"
::macos:perl -I::lib    :lib:ipc_sysv.t
# echo "::macos:perl -I::lib    :lib:ndbm.t"
# ::macos:perl -I::lib    :lib:ndbm.t
echo "::macos:perl -I::lib    :lib:odbm.t"
::macos:perl -I::lib    :lib:odbm.t
echo "::macos:perl -I::lib    :lib:opcode.t"
::macos:perl -I::lib    :lib:opcode.t
echo "::macos:perl -I::lib    :lib:open2.t"
::macos:perl -I::lib    :lib:open2.t
echo "::macos:perl -I::lib    :lib:open3.t"
::macos:perl -I::lib    :lib:open3.t
echo "::macos:perl -I::lib    :lib:ops.t"
::macos:perl -I::lib    :lib:ops.t
echo "::macos:perl -I::lib    :lib:parsewords.t"
::macos:perl -I::lib    :lib:parsewords.t
echo "::macos:perl -I::lib    :lib:peek.t"
::macos:perl -I::lib    :lib:peek.t
echo "::macos:perl -I::lib    :lib:ph.t"
::macos:perl -I::lib    :lib:ph.t
# echo "::macos:perl -I::lib    :lib:posix.t"
# ::macos:perl -I::lib    :lib:posix.t
echo "::macos:perl -I::lib    :lib:safe1.t"
::macos:perl -I::lib    :lib:safe1.t
echo "::macos:perl -I::lib    :lib:safe2.t"
::macos:perl -I::lib    :lib:safe2.t
echo "::macos:perl -I::lib    :lib:sdbm.t"
::macos:perl -I::lib    :lib:sdbm.t
echo "::macos:perl -I::lib    :lib:searchdict.t"
::macos:perl -I::lib    :lib:searchdict.t
echo "::macos:perl -I::lib    :lib:selectsaver.t"
::macos:perl -I::lib    :lib:selectsaver.t
echo "::macos:perl -I::lib    :lib:selfloader.t"
::macos:perl -I::lib    :lib:selfloader.t
echo "::macos:perl -I::lib    :lib:socket.t"
::macos:perl -I::lib    :lib:socket.t
echo "::macos:perl -I::lib    :lib:soundex.t"
::macos:perl -I::lib    :lib:soundex.t
echo "::macos:perl -I::lib    :lib:symbol.t"
::macos:perl -I::lib    :lib:symbol.t
echo "::macos:perl -I::lib    :lib:syslfs.t"
::macos:perl -I::lib    :lib:syslfs.t
echo "::macos:perl -I::lib    :lib:syslog.t"
::macos:perl -I::lib    :lib:syslog.t
echo "::macos:perl -I::lib    :lib:textfill.t"
::macos:perl -I::lib    :lib:textfill.t
echo "::macos:perl -I::lib    :lib:texttabs.t"
::macos:perl -I::lib    :lib:texttabs.t
echo "::macos:perl -I::lib    :lib:textwrap.t"
::macos:perl -I::lib    :lib:textwrap.t
echo "::macos:perl -I::lib    :lib:thr5005.t"
::macos:perl -I::lib    :lib:thr5005.t
echo "::macos:perl -I::lib    :lib:tie-push.t"
::macos:perl -I::lib    :lib:tie-push.t
echo "::macos:perl -I::lib    :lib:tie-refhash.t"
::macos:perl -I::lib    :lib:tie-refhash.t
echo "::macos:perl -I::lib    :lib:tie-splice.t"
::macos:perl -I::lib    :lib:tie-splice.t
echo "::macos:perl -I::lib    :lib:tie-stdarray.t"
::macos:perl -I::lib    :lib:tie-stdarray.t
echo "::macos:perl -I::lib    :lib:tie-stdhandle.t"
::macos:perl -I::lib    :lib:tie-stdhandle.t
echo "::macos:perl -I::lib    :lib:tie-stdpush.t"
::macos:perl -I::lib    :lib:tie-stdpush.t
echo "::macos:perl -I::lib    :lib:tie-substrhash.t"
::macos:perl -I::lib    :lib:tie-substrhash.t
echo "::macos:perl -I::lib    :lib:timelocal.t"
::macos:perl -I::lib    :lib:timelocal.t
echo "::macos:perl -I::lib    :lib:trig.t"
::macos:perl -I::lib    :lib:trig.t
echo "::macos:perl -I::lib    :op:64bitint.t"
::macos:perl -I::lib    :op:64bitint.t
echo "::macos:perl -I::lib    :op:anonsub.t"
::macos:perl -I::lib    :op:anonsub.t
echo "::macos:perl -I::lib    :op:append.t"
::macos:perl -I::lib    :op:append.t
echo "::macos:perl -I::lib    :op:args.t"
::macos:perl -I::lib    :op:args.t
echo "::macos:perl -I::lib    :op:arith.t"
::macos:perl -I::lib    :op:arith.t
echo "::macos:perl -I::lib    :op:array.t"
::macos:perl -I::lib    :op:array.t
echo "::macos:perl -I::lib    :op:assignwarn.t"
::macos:perl -I::lib    :op:assignwarn.t
echo "::macos:perl -I::lib    :op:attrs.t"
::macos:perl -I::lib    :op:attrs.t
echo "::macos:perl -I::lib    :op:auto.t"
::macos:perl -I::lib    :op:auto.t
echo "::macos:perl -I::lib    :op:avhv.t"
::macos:perl -I::lib    :op:avhv.t
echo "::macos:perl -I::lib    :op:bop.t"
::macos:perl -I::lib    :op:bop.t
echo "::macos:perl -I::lib    :op:chars.t"
::macos:perl -I::lib    :op:chars.t
echo "::macos:perl -I::lib    :op:chop.t"
::macos:perl -I::lib    :op:chop.t
echo "::macos:perl -I::lib    :op:closure.t"
::macos:perl -I::lib    :op:closure.t
echo "::macos:perl -I::lib    :op:cmp.t"
::macos:perl -I::lib    :op:cmp.t
echo "::macos:perl -I::lib    :op:concat.t"
::macos:perl -I::lib    :op:concat.t
echo "::macos:perl -I::lib    :op:cond.t"
::macos:perl -I::lib    :op:cond.t
echo "::macos:perl -I::lib    :op:context.t"
::macos:perl -I::lib    :op:context.t
echo "::macos:perl -I::lib    :op:defins.t"
::macos:perl -I::lib    :op:defins.t
echo "::macos:perl -I::lib    :op:delete.t"
::macos:perl -I::lib    :op:delete.t
echo "::macos:perl -I::lib    :op:die.t"
::macos:perl -I::lib    :op:die.t
# echo "::macos:perl -I::lib    :op:die_exit.t"
# ::macos:perl -I::lib    :op:die_exit.t
echo "::macos:perl -I::lib    :op:do.t"
::macos:perl -I::lib    :op:do.t
echo "::macos:perl -I::lib    :op:each.t"
::macos:perl -I::lib    :op:each.t
echo "::macos:perl -I::lib    :op:eval.t"
::macos:perl -I::lib    :op:eval.t
echo "::macos:perl -I::lib    :op:exec.t"
::macos:perl -I::lib    :op:exec.t
echo "::macos:perl -I::lib    :op:exists_sub.t"
::macos:perl -I::lib    :op:exists_sub.t
echo "::macos:perl -I::lib    :op:exp.t"
::macos:perl -I::lib    :op:exp.t
echo "::macos:perl -I::lib    :op:fh.t"
::macos:perl -I::lib    :op:fh.t
echo "::macos:perl -I::lib    :op:filetest.t"
::macos:perl -I::lib    :op:filetest.t
echo "::macos:perl -I::lib    :op:flip.t"
::macos:perl -I::lib    :op:flip.t
echo "::macos:perl -I::lib    :op:fork.t"
::macos:perl -I::lib    :op:fork.t
echo "::macos:perl -I::lib    :op:glob.t"
::macos:perl -I::lib    :op:glob.t
echo "::macos:perl -I::lib    :op:goto.t"
::macos:perl -I::lib    :op:goto.t
echo "::macos:perl -I::lib    :op:goto_xs.t"
::macos:perl -I::lib    :op:goto_xs.t
echo "::macos:perl -I::lib    :op:grent.t"
::macos:perl -I::lib    :op:grent.t
echo "::macos:perl -I::lib    :op:grep.t"
::macos:perl -I::lib    :op:grep.t
echo "::macos:perl -I::lib    :op:groups.t"
::macos:perl -I::lib    :op:groups.t
echo "::macos:perl -I::lib    :op:gv.t"
::macos:perl -I::lib    :op:gv.t
echo "::macos:perl -I::lib    :op:hashwarn.t"
::macos:perl -I::lib    :op:hashwarn.t
echo "::macos:perl -I::lib    :op:inc.t"
::macos:perl -I::lib    :op:inc.t
echo "::macos:perl -I::lib    :op:index.t"
::macos:perl -I::lib    :op:index.t
echo "::macos:perl -I::lib    :op:int.t"
::macos:perl -I::lib    :op:int.t
echo "::macos:perl -I::lib    :op:join.t"
::macos:perl -I::lib    :op:join.t
echo "::macos:perl -I::lib    :op:length.t"
::macos:perl -I::lib    :op:length.t
echo "::macos:perl -I::lib    :op:lex_assign.t"
::macos:perl -I::lib    :op:lex_assign.t
echo "::macos:perl -I::lib    :op:lfs.t"
::macos:perl -I::lib    :op:lfs.t
echo "::macos:perl -I::lib    :op:list.t"
::macos:perl -I::lib    :op:list.t
echo "::macos:perl -I::lib    :op:local.t"
::macos:perl -I::lib    :op:local.t
echo "::macos:perl -I::lib    :op:lop.t"
::macos:perl -I::lib    :op:lop.t
# echo "::macos:perl -I::lib    :op:magic.t"
# ::macos:perl -I::lib    :op:magic.t
echo "::macos:perl -I::lib    :op:method.t"
::macos:perl -I::lib    :op:method.t
# echo "::macos:perl -I::lib    :op:misc.t"
# ::macos:perl -I::lib    :op:misc.t
echo "::macos:perl -I::lib    :op:mkdir.t"
::macos:perl -I::lib    :op:mkdir.t
echo "::macos:perl -I::lib    :op:my.t"
::macos:perl -I::lib    :op:my.t
echo "::macos:perl -I::lib    :op:my_stash.t"
::macos:perl -I::lib    :op:my_stash.t
echo "::macos:perl -I::lib    :op:nothr5005.t"
::macos:perl -I::lib    :op:nothr5005.t
echo "::macos:perl -I::lib    :op:numconvert.t"
::macos:perl -I::lib    :op:numconvert.t
echo "::macos:perl -I::lib    :op:oct.t"
::macos:perl -I::lib    :op:oct.t
echo "::macos:perl -I::lib    :op:ord.t"
::macos:perl -I::lib    :op:ord.t
echo "::macos:perl -I::lib    :op:pack.t"
::macos:perl -I::lib    :op:pack.t
echo "::macos:perl -I::lib    :op:pat.t"
::macos:perl -I::lib    :op:pat.t
echo "::macos:perl -I::lib    :op:pos.t"
::macos:perl -I::lib    :op:pos.t
echo "::macos:perl -I::lib    :op:push.t"
::macos:perl -I::lib    :op:push.t
echo "::macos:perl -I::lib    :op:pwent.t"
::macos:perl -I::lib    :op:pwent.t
echo "::macos:perl -I::lib    :op:quotemeta.t"
::macos:perl -I::lib    :op:quotemeta.t
echo "::macos:perl -I::lib    :op:rand.t"
::macos:perl -I::lib    :op:rand.t
echo "::macos:perl -I::lib    :op:range.t"
::macos:perl -I::lib    :op:range.t
echo "::macos:perl -I::lib    :op:read.t"
::macos:perl -I::lib    :op:read.t
echo "::macos:perl -I::lib    :op:readdir.t"
::macos:perl -I::lib    :op:readdir.t
echo "::macos:perl -I::lib    :op:recurse.t"
::macos:perl -I::lib    :op:recurse.t
echo "::macos:perl -I::lib    :op:ref.t"
::macos:perl -I::lib    :op:ref.t
echo "::macos:perl -I::lib    :op:regexp.t"
::macos:perl -I::lib    :op:regexp.t
echo "::macos:perl -I::lib    :op:regexp_noamp.t"
::macos:perl -I::lib    :op:regexp_noamp.t
echo "::macos:perl -I::lib    :op:regmesg.t"
::macos:perl -I::lib    :op:regmesg.t
echo "::macos:perl -I::lib    :op:repeat.t"
::macos:perl -I::lib    :op:repeat.t
echo "::macos:perl -I::lib    :op:reverse.t"
::macos:perl -I::lib    :op:reverse.t
echo "::macos:perl -I::lib    :op:runlevel.t"
::macos:perl -I::lib    :op:runlevel.t
echo "::macos:perl -I::lib    :op:sleep.t"
::macos:perl -I::lib    :op:sleep.t
echo "::macos:perl -I::lib    :op:sort.t"
::macos:perl -I::lib    :op:sort.t
echo "::macos:perl -I::lib    :op:splice.t"
::macos:perl -I::lib    :op:splice.t
echo "::macos:perl -I::lib    :op:split.t"
::macos:perl -I::lib    :op:split.t
# echo "::macos:perl -I::lib    :op:sprintf.t"
# ::macos:perl -I::lib    :op:sprintf.t
echo "::macos:perl -I::lib    :op:stat.t"
::macos:perl -I::lib    :op:stat.t
echo "::macos:perl -I::lib    :op:study.t"
::macos:perl -I::lib    :op:study.t
echo "::macos:perl -I::lib    :op:subst.t"
::macos:perl -I::lib    :op:subst.t
echo "::macos:perl -I::lib    :op:subst_amp.t"
::macos:perl -I::lib    :op:subst_amp.t
echo "::macos:perl -I::lib    :op:subst_wamp.t"
::macos:perl -I::lib    :op:subst_wamp.t
echo "::macos:perl -I::lib    :op:substr.t"
::macos:perl -I::lib    :op:substr.t
echo "::macos:perl -I::lib    :op:sysio.t"
::macos:perl -I::lib    :op:sysio.t
echo "::macos:perl -I::lib -T :op:taint.t"
::macos:perl -I::lib -T :op:taint.t
echo "::macos:perl -I::lib    :op:tie.t"
::macos:perl -I::lib    :op:tie.t
echo "::macos:perl -I::lib    :op:tiearray.t"
::macos:perl -I::lib    :op:tiearray.t
echo "::macos:perl -I::lib    :op:tiehandle.t"
::macos:perl -I::lib    :op:tiehandle.t
echo "::macos:perl -I::lib    :op:time.t"
::macos:perl -I::lib    :op:time.t
echo "::macos:perl -I::lib    :op:tr.t"
::macos:perl -I::lib    :op:tr.t
echo "::macos:perl -I::lib    :op:undef.t"
::macos:perl -I::lib    :op:undef.t
echo "::macos:perl -I::lib    :op:universal.t"
::macos:perl -I::lib    :op:universal.t
echo "::macos:perl -I::lib    :op:unshift.t"
::macos:perl -I::lib    :op:unshift.t
echo "::macos:perl -I::lib    :op:utf8decode.t"
::macos:perl -I::lib    :op:utf8decode.t
echo "::macos:perl -I::lib    :op:vec.t"
::macos:perl -I::lib    :op:vec.t
echo "::macos:perl -I::lib    :op:ver.t"
::macos:perl -I::lib    :op:ver.t
echo "::macos:perl -I::lib    :op:wantarray.t"
::macos:perl -I::lib    :op:wantarray.t
echo "::macos:perl -I::lib    :op:write.t"
::macos:perl -I::lib    :op:write.t
echo "::macos:perl -I::lib    :pod:emptycmd.t"
::macos:perl -I::lib    :pod:emptycmd.t
echo "::macos:perl -I::lib    :pod:find.t"
::macos:perl -I::lib    :pod:find.t
echo "::macos:perl -I::lib    :pod:for.t"
::macos:perl -I::lib    :pod:for.t
echo "::macos:perl -I::lib    :pod:headings.t"
::macos:perl -I::lib    :pod:headings.t
echo "::macos:perl -I::lib    :pod:include.t"
::macos:perl -I::lib    :pod:include.t
echo "::macos:perl -I::lib    :pod:included.t"
::macos:perl -I::lib    :pod:included.t
echo "::macos:perl -I::lib    :pod:lref.t"
::macos:perl -I::lib    :pod:lref.t
echo "::macos:perl -I::lib    :pod:multiline_items.t"
::macos:perl -I::lib    :pod:multiline_items.t
echo "::macos:perl -I::lib    :pod:nested_items.t"
::macos:perl -I::lib    :pod:nested_items.t
echo "::macos:perl -I::lib    :pod:nested_seqs.t"
::macos:perl -I::lib    :pod:nested_seqs.t
echo "::macos:perl -I::lib    :pod:oneline_cmds.t"
::macos:perl -I::lib    :pod:oneline_cmds.t
echo "::macos:perl -I::lib    :pod:pod2usage.t"
::macos:perl -I::lib    :pod:pod2usage.t
echo "::macos:perl -I::lib    :pod:poderrs.t"
::macos:perl -I::lib    :pod:poderrs.t
echo "::macos:perl -I::lib    :pod:podselect.t"
::macos:perl -I::lib    :pod:podselect.t
echo "::macos:perl -I::lib    :pod:special_seqs.t"
::macos:perl -I::lib    :pod:special_seqs.t
echo "::macos:perl -I::lib    :pragma:constant.t"
::macos:perl -I::lib    :pragma:constant.t
echo "::macos:perl -I::lib    :pragma:diagnostics.t"
::macos:perl -I::lib    :pragma:diagnostics.t
echo "::macos:perl -I::lib -T :pragma:locale.t"
::macos:perl -I::lib -T :pragma:locale.t
echo "::macos:perl -I::lib    :pragma:overload.t"
::macos:perl -I::lib    :pragma:overload.t
echo "::macos:perl -I::lib    :pragma:strict.t"
::macos:perl -I::lib    :pragma:strict.t
echo "::macos:perl -I::lib    :pragma:sub_lval.t"
::macos:perl -I::lib    :pragma:sub_lval.t
echo "::macos:perl -I::lib    :pragma:subs.t"
::macos:perl -I::lib    :pragma:subs.t
echo "::macos:perl -I::lib    :pragma:utf8.t"
::macos:perl -I::lib    :pragma:utf8.t
# echo "::macos:perl -I::lib    :pragma:warnings.t"
# ::macos:perl -I::lib    :pragma:warnings.t
echo "::macos:perl -I::lib    :run:runenv.t"
::macos:perl -I::lib    :run:runenv.t


echo "These tests are known to fail.  Run if you want to, but beware"
echo "because crashes are possible."
echo "::macos:perl -I::lib    :lib:db-btree.t"
echo "::macos:perl -I::lib    :lib:db-hash.t"
echo "::macos:perl -I::lib    :lib:db-recno.t"
echo "::macos:perl -I::lib    :lib:dosglob.t"
echo "::macos:perl -I::lib    :lib:dprof.t"
echo "::macos:perl -I::lib    :lib:ftmp-mktemp.t"
echo "::macos:perl -I::lib    :lib:ftmp-posix.t"
echo "::macos:perl -I::lib    :lib:ftmp-security.t"
echo "::macos:perl -I::lib    :lib:ftmp-tempfile.t"
echo "::macos:perl -I::lib    :lib:ndbm.t"
echo "::macos:perl -I::lib    :lib:posix.t"
echo "::macos:perl -I::lib    :op:die_exit.t"
echo "::macos:perl -I::lib    :op:magic.t"
echo "::macos:perl -I::lib    :op:misc.t"
echo "::macos:perl -I::lib    :op:sprintf.t"
echo "::macos:perl -I::lib    :pragma:warnings.t"
