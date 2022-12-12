<html>

<head>
<title>Com�rcio do Toshiro</title>
<style>
    table { width: 100%; }
    th { text-align: center; }
    td { text-align: center; }
	h1 { text-align: center; }
</style>

</head>
<body>

<?php
ini_set("display_errors", 1);
header('Content-Type: text/html; charset=iso-8859-1');

echo 'Vers�o Atual do PHP: '. phpversion() .'<br>';

$servername = "mysql";
$username = "root";
$password = "Senha123";
$database = "bd_toshiro";

// Criar conex�o
$link = new mysqli($servername, $username, $password, $database);

/* check connection */
if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}

$valor_rand1 =  rand(1, 999);
$valor_rand2 = strtoupper(substr(bin2hex(random_bytes(5)), 1));
$valor_rand3 = strtoupper(substr(bin2hex(random_bytes(5)), 1));
$valor_rand4 = strtoupper(substr(bin2hex(random_bytes(5)), 1));
$valor_rand5 = strtoupper(substr(bin2hex(random_bytes(5)), 1));
$host_name = gethostname();

$query = "INSERT INTO clientes (idCliente, nome, endereco, email, telefone, host)
 VALUES (null , 'Nome Completo do Cliente', 'Endere�o detalhado do cliente', 'cliente@email.com', '(71) 12345-6789','$host_name')";

if ($link->query($query) === TRUE) {
  //echo "Novo registro criado com sucesso.<br>";
}
else if ($link->errno == "1146") {
	$query = "CREATE TABLE clientes (
		idCliente INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
		nome VARCHAR(50) NOT NULL,
		endereco VARCHAR(100) NOT NULL,
		email VARCHAR(60) NOT NULL,
		telefone VARCHAR(15) NOT NULL,
		host VARCHAR(50)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;";
	echo "Erro: " . $link->error . "<br>";
	if ($link->query($query) === TRUE) {
		echo "A tabela clientes n�o existia, mas foi criada com sucesso.";
	}
}
else {
  echo "Erro: " . $link->error;
}
?>

<hr>
<table>
<thead>
<tr><th colspan="5" style="font-size: 28px;">Com�rcio do Toshiro</th></tr>
<tr>
	<th>Nome</th>
	<th>Endere�o</th>
	<th>E-mail</th>
	<th>Telefone</th>
    <th>Host</th>
</tr>
</thead>
<tbody>
<?php
	$query = "SELECT * from clientes ORDER BY idCliente";
    $matrizDados = $link->query($query);
	while ($dados = $matrizDados->fetch_array()) {
		if ($dados['idCliente'] == '50') {
			$query = 'TRUNCATE TABLE clientes;';
			if ($link->query($query) === TRUE) {
				echo "<tr><td colspan='5'><b>Dados zerados na tabela clientes</b></td></tr>";
			}
		} else {
echo "<tr>"
	."<td>".$dados['nome']."</td>"
	."<td>".$dados['endereco']."</td>"
	."<td>".$dados['email']."</td>"
	."<td>".$dados['telefone']."</td>"
    ."<td>".$dados['host']."</td>"
	."</tr>";
		}
	}
?>
</tbody>
</table>
</hr>

</body>
</html>