#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use DBI;


my $q =CGI->new;
my $titulo =$q->param('titulo');
my $contenido =$q->param('contenido');

print $q->header('text/html;charset=UTF-8');

my $user='alumno';
my $password='pweb1';
my $dsn="DBI:MariaDB:database=pweb1;host=192.168.1.23";
my $dbh=DBI->connect($dsn, $user,$password) or die ("no se puede conectar");;
my $sth=$dbh->prepare("select titulo from Wiki where titulo=?");
$sth->execute($titulo);
my @titles;
my @row; 
while(@row=$sth->fetchrow_array)
{ push(@titles,@row);

}

$sth->finish;
my $estado="";
if($titles[0]eq($titulo)){
   my $sth1 = $dbh->prepare("update Wiki set texto=? where titulo=?");
   $sth1->execute($contenido,$titulo);
   $sth1->finish;
   $estado="Pagina Actualizada";
}
else{
   my $sth2 = $dbh->prepare("insert into Wiki (titulo,texto) values (?,?)");
   $sth2->execute($titulo,$contenido);
   $sth2->finish;
   $estado="Pagina guardada";

}

$dbh->disconnect;

my $body = renderBody($titulo,$contenido,$estado);
print renderHTMLpage('Edit',$body);
sub renderBody{
    my $titulo =$_[0];
    my $contenido =$_[1];
    my $estado =$_[2];
    my $body =<<"BODY";
    <section class="cuerpo">
          <div class="contenedorV">
            <h2 align="center">ESTADO: $estado</h2>
            <h1 >$titulo</h1>
            <pre>$contenido</pre><hr>
          </div>
            <input type="button" value="Ver pagina" onclick="location.href='view.pl?titulo=$titulo'" class="buttonNH">
            <input type="button" value="Lista de paginas" onclick="location.href='list.pl'" class="buttonNH">
    </section>
BODY
  return $body;
}
  sub renderHTMLpage{
  my $title =$_[0];
  my $body =$_[1];
  my $html = <<"HTML";
    <!DOCTYPE html>
      <html lang="es">

        <head>
          <link rel="stylesheet" href="../css/stylesv.css">
          <title>$title</title>
          <meta charset="UTF-8">
        </head>

      <body>
          $body
      </body>
    </html>
HTML
    return $html;
  }
