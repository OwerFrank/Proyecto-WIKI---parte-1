#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use DBI;


print "Content-type: text/html\n\n";
print <<HTML;
 <!DOCTYPE html>
 <html>
 <head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="../css/stylesnh.css">
    <title>Pagina eliminada</title>
  </head>
<body>
HTML

my $q =CGI->new;
my $titulo =$q->param('titulo');

my $user='alumno';
my $password='pweb1';
my $dsn="DBI:MariaDB:database=pweb1;host=192.168.1.23";
my $dbh=DBI->connect($dsn, $user,$password) or die ("no se puede conectar");;
my $sth=$dbh->prepare("delete from Wiki where titulo=?");
$sth->execute($titulo);
$dbh->disconnect;
print<<HTML;
   <hr><h1 align="center">LA PAGINA HA SIDO ELIMINADA </h1><hr>
   <div class="nextbotc">
      <input type="button" value="Atrás" onclick="location.href='list.pl'" class="buttonNH">
   </div>
</body>
</html>
HTML



