<?php
session_start();
header('Content-Type: application/json');
try {
  require_once __DIR__ . '/../../conexion.php';
  $nombre=trim($_POST['nombre']??'');
  $email=trim($_POST['email']??'');
  $password=$_POST['password']??'';
  if ($nombre==='' || $email==='' || $password==='') { http_response_code(400); echo json_encode(['ok'=>false,'msg'=>'Faltan campos']); exit; }
  $hash=password_hash($password,PASSWORD_BCRYPT);
  $stmt=$pdo->prepare('INSERT INTO usuarios (nombre,email,password) VALUES (?,?,?)');
  $stmt->execute([$nombre,$email,$hash]);
  echo json_encode(['ok'=>true]);
} catch(PDOException $e) {
  if ($e->getCode()==='23000') { http_response_code(409); echo json_encode(['ok'=>false,'msg'=>'El email ya está registrado']); }
  else { http_response_code(500); echo json_encode(['ok'=>false,'where'=>'register','error'=>$e->getMessage()]); }
} catch(Throwable $e) {
  http_response_code(500);
  echo json_encode(['ok'=>false,'where'=>'register','error'=>$e->getMessage()]);
}
