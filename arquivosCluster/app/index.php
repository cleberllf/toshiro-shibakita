<html>

<head>
<title>Comércio do Toshiro Shibakita</title>
<style>
    table { width: 100%; }
    th { text-align: center; }
    td { text-align: center; }
</style>
</head>
<body>

<?php
ini_set("display_errors", 1);
header('Content-Type: text/html; charset=iso-8859-1');

echo 'Versão Atual do PHP: ' . phpversion() . '<br>';

$servername = "mysql";
$username = "root";
$password = "Senha123";
$database = "bd_toshiro";

// Criar conexão
$link = new mysqli($servername, $username, $password, $database);

/* check connection */
if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}

$valor_rand1 =  rand(1, 999);
$valor_rand2 = strtoupper(substr(bin2hex(random_bytes(4)), 1));
$valor_rand3 = strtoupper(substr(bin2hex(random_bytes(4)), 1));
$valor_rand4 = strtoupper(substr(bin2hex(random_bytes(4)), 1));
$valor_rand5 = strtoupper(substr(bin2hex(random_bytes(4)), 1));
$host_name = gethostname();

$query = "INSERT INTO clientes (idCliente, nome, endereco, email, telefone, host)
 VALUES (null , '$valor_rand2', '$valor_rand3', '$valor_rand4', '$valor_rand5','$host_name')";


if ($link->query($query) === TRUE) {
  echo "Novo registro criado com sucesso.";
}
else if ($link->errno == 1146) {
$query = "CREATE TABLE clientes (
	idCliente INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL,
	endereco VARCHAR(100) NOT NULL,
	email VARCHAR(60) NOT NULL,
	telefone VARCHAR(15) NOT NULL,
	host VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;";
  if ($link->query($query) === TRUE) {
    echo "A tabela clientes não existia, mas foi criada com sucesso."
  }
}
else {
  echo "Erro: " . $link->error;
}
?>

<blockquote>
<h1>Comércio do Toshiso</h1>
<br/>
<table>
<thead>
<tr>
	<th>Nome</th>
	<th>Endereço</th>
	<th>E-mail</th>
	<th>Telefone</th>
    <th>Host</th>
</tr>
</thead>
<tbody>
<?php
	$query = "SELECT * from clientes ORDER BY id";
    $matrizDados = $link->query($query);
	while ($dados = $matrizDados->fetch_array()) {
?>
<tr>
	<td><?php echo $dados['nome']; ?></td>
	<td><?php echo $dados['endereco']; ?></td>
	<td><?php echo $dados['email']; ?></td>
	<td><?php echo $dados['telefone']; ?></td>
    <td><?php echo $dados['host']; ?></td>
</tr>
<?php
	}
?>
</tbody>
</table>

</blockquote>

</body>
</html>