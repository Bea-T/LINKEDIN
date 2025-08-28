<?php
session_start();
require_once __DIR__ . '/../../conexion.php';
header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
  http_response_code(401);
  echo json_encode(['ok'=>false, 'msg'=>'No autenticado']);
  exit;
}

$llamado_id = intval($_POST['llamado_id'] ?? 0);
if ($llamado_id <= 0) {
  http_response_code(400);
  echo json_encode(['ok'=>false, 'msg'=>'Llamado inválido']);
  exit;
}

// Evita duplicados por UNIQUE (usuario_id,llamado_id)
$stmt = $pdo->prepare('INSERT IGNORE INTO postulaciones (usuario_id, llamado_id) VALUES (?,?)');
$stmt->execute([$_SESSION['user_id'], $llamado_id]);
echo json_encode(['ok'=>true]);
