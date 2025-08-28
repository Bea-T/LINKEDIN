<?php
session_start();
require_once __DIR__ . '/../../conexion.php';
header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
  http_response_code(401);
  echo json_encode(['ok'=>false, 'msg'=>'No autenticado']);
  exit;
}

$stmt = $pdo->prepare('
  SELECT p.id, p.fecha_postulacion, l.id AS llamado_id, l.titulo, l.descripcion
  FROM postulaciones p
  INNER JOIN llamados l ON l.id = p.llamado_id
  WHERE p.usuario_id = ?
  ORDER BY p.fecha_postulacion DESC
');
$stmt->execute([$_SESSION['user_id']]);
echo json_encode(['ok'=>true, 'postulaciones'=>$stmt->fetchAll(PDO::FETCH_ASSOC)]);
