print "1..12\n";

use URI;

$u = URI->new("<http://www.perl.com/path?q=f�o>");

#print "$u\n";
print "not " unless $u eq "http://www.perl.com/path?q=f%F4o";
print "ok 1\n";

print "not " unless $u->port == 80;
print "ok 2\n";

# play with port
$old = $u->port(8080);
print "not " unless $old == 80 && $u eq "http://www.perl.com:8080/path?q=f%F4o";
print "ok 3\n";

$u->port(80);
print "not " unless $u eq "http://www.perl.com:80/path?q=f%F4o";
print "ok 4\n";

$u->port("");
print "not " unless $u eq "http://www.perl.com:/path?q=f%F4o" && $u->port == 80;
print "ok 5\n";

$u->port(undef);
print "not " unless $u eq "http://www.perl.com/path?q=f%F4o";
print "ok 6\n";

@q = $u->query_form;
print "not " unless @q == 2 && "@q" eq "q f�o";
print "ok 7\n";

$u->query_form(foo => "bar", bar => "baz");
print "not " unless $u->query eq "foo=bar&bar=baz";
print "ok 8\n";

print "not " unless $u->host eq "www.perl.com";
print "ok 9\n";

print "not " unless $u->path eq "/path";
print "ok 10\n";

$u->scheme("https");
print "not " unless $u->port == 443;
print "ok 11\n";

print "not " unless $u eq "https://www.perl.com/path?foo=bar&bar=baz";
print "ok 12\n";
