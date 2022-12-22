#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use DBI;


my $q =CGI->new;
my $titulo =$q->param('titulo');
print $q->header('text/html;charset=UTF-8');

my $user='alumno';
my $password='pweb1';
my $dsn="DBI:MariaDB:database=pweb1;host=192.168.1.23";
my $dbh=DBI->connect($dsn, $user,$password) or die ("no se puede conectar");;
my $sth=$dbh->prepare("select texto from Wiki where titulo=?");
$sth->execute($titulo);
my @text;
my @row; 
while(@row=$sth->fetchrow_array)
{ push(@text,@row);
}

$sth->finish;
$dbh->disconnect;

my $body = renderBody($titulo,@text);
print renderHTMLpage('Edit',$body);
sub renderBody{
   my $titulo =$_[0];
   my $contenido =$_[1];
   my $body =<<"BODY";
   <section class="cuerpo">
      <h1>$titulo</h1>
         <div class="contenedorV">
            <form action="new.pl">
               <label for="contenido">.</label>
                  <textarea class="cajaContent" name="contenido" required>$contenido</textarea>
                  <br>
                     <input type="hidden" name="name" value="$titulo" class="buttonNH">
                     <input type="submit" name="name" value="ENVIAR" class="buttonNH">
                     <input type="button" value="CANCELAR" onclick="location.href='list.pl'" class="buttonNH">
            </form>
         </div>
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
            <link rel="stylesheet" href="../css/stylesnh.css">
            <title>$title</title>
            <meta charset="UTF-8">
         </head>

         <body>
               $body<hr>
         </body>
      </html>
HTML
      return $html;
   }