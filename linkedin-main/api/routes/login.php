<?php
session_start();
header('Content-Type: application/json');
try {
  require_once __DIR__ . '/../../conexion.php';
  $email = $_POST['email'] ?? '';
  $password = $_POST['password'] ?? '';
  if ($email === '' || $password === '') { http_response_code(400); echo json_encode(['ok'=>false,'msg'=>'Faltan campos']); exit; }
  $stmt=$pdo->prepare('SELECT id, nombre, password FROM usuarios WHERE email=?');
  $stmt->execute([$email]);
  $u=$stmt->fetch(PDO::FETCH_ASSOC);
  if ($u && password_verify($password, $u['password'])) {
    $_SESSION['user_id']=(int)$u['id'];
    $_SESSION['user_name']=$u['nombre'];
    echo json_encode(['ok'=>true,'nombre'=>$u['nombre']]);
  } else {
    http_response_code(401);
    echo json_encode(['ok'=>false,'msg'=>'Credenciales inválidas']);
  }
} catch(Throwable $e) {
  http_response_code(500);
  echo json_encode(['ok'=>false,'where'=>'login','error'=>$e->getMessage()]);
}
