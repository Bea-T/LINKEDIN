<?php
$host='localhost'; $db='linkedin'; $user='root'; $pass=''; $charset='utf8mb4';
$dsn="mysql:host=$host;dbname=$db;charset=$charset";
$options=[
  PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION,
  PDO::ATTR_DEFAULT_FETCH_MODE=>PDO::FETCH_ASSOC,
  PDO::ATTR_EMULATE_PREPARES=>false
];
try {
  $pdo=new PDO($dsn,$user,$pass,$options);
} catch(PDOException $e) {
  if (!headers_sent()) header('Content-Type: application/json');
  http_response_code(500);
  echo json_encode(['ok'=>false,'where'=>'conexion','error'=>$e->getMessage()]);
  exit;
}
