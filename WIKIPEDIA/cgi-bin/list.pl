#!/usr/bin/perl -w
use strict;
use warnings;
use DBI;


print "Content-type: text/html\n\n";
print <<HTML;
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../css/styles.css">
    <title>Wiki</title>
</head>
<body>
    <section class="cuerpo">
      <h1>Paginas de Wiki</h1>
      <div class="contenedor">
        <h2>Lista de paginas guardadas:</h2>
      <ul class="lista">
HTML
my $user='alumno';
my $password='pweb1';
my $dsn="DBI:MariaDB:database=pweb1;host=192.168.1.23";
my $dbh=DBI->connect($dsn, $user,$password) or die ("no se puede conectar");;
my $sth=$dbh->prepare("select titulo from Wiki");
$sth->execute();

print "<nav><ul>\n";
while(my @row = $sth->fetchrow_array){
    print "<li>\n";
    print "<a href='view.pl?titulo=@row'>@row</a>\n";
    print "<a href='delete.pl?titulo=@row' class='buttonNH'>ELIMINAR</a>\n";
    print "<a href='edit.pl?titulo=@row' class='buttonNH'>EDITAR</a>\n";
    print "</li>\n";
}
print "</ul></nav>\n";
$sth->finish;
$dbh->disconnect;
print<<HTML;
      </ul>
      </div>
        <div class="nextbotc">
            <input type="button" value="Nueva Pagina" onclick="location.href='./../new.html'" class="buttonNH">
            <input type="button" value="Volver al inicio" onclick="location.href='../index.html'" class="buttonNH">
        </div>
    </section>
 </body>
 </html>
HTML



