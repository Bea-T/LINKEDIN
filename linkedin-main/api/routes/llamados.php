<?php
session_start();
header('Content-Type: application/json');

try {
  require_once __DIR__ . '/../../conexion.php';

  // user actual (o -1 si no hay sesión) para evaluar postulaciones
  $uid = isset($_SESSION['user_id']) ? (int)$_SESSION['user_id'] : -1;

  // ¿Existe la vista con logos/empresa?
  $hasView = false;
  try {
    $pdo->query("SELECT 1 FROM vista_llamados_empresas LIMIT 1");
    $hasView = true;
  } catch (Throwable $e) {
    $hasView = false;
  }

  if ($hasView) {
    // Usamos la vista y LEFT JOIN a postulaciones sólo del usuario actual
    $sql = "
      SELECT v.id,
             v.titulo,
             v.descripcion,
             v.fecha,
             v.tipo,
             v.empresa_id,
             v.empresa_nombre,
             v.logo,
             IF(p.usuario_id IS NULL, 0, 1) AS ya_postulado
      FROM vista_llamados_empresas v
      LEFT JOIN postulaciones p
             ON p.llamado_id = v.id
            AND p.usuario_id = :uid
      ORDER BY v.id DESC
    ";
  } else {
    // Respaldo sin vista: JOIN directo a empresas y LEFT JOIN a postulaciones
    $sql = "
      SELECT l.id,
             l.titulo,
             l.descripcion,
             l.fecha,
             l.tipo,
             l.empresa_id,
             e.nombre AS empresa_nombre,
             e.logo,
             IF(p.usuario_id IS NULL, 0, 1) AS ya_postulado
      FROM llamados l
      INNER JOIN empresas e ON e.id = l.empresa_id
      LEFT JOIN postulaciones p
             ON p.llamado_id = l.id
            AND p.usuario_id = :uid
      ORDER BY l.id DESC
    ";
  }

  $stmt = $pdo->prepare($sql);
  $stmt->execute(['uid' => $uid]);
  $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

  echo json_encode([
    'ok'     => true,
    'llamados' => $rows,
    'logged' => isset($_SESSION['user_id']),
    'nombre' => ($_SESSION['user_name'] ?? null)
  ]);
} catch (Throwable $e) {
  http_response_code(500);
  echo json_encode(['ok' => false, 'where' => 'llamados', 'error' => $e->getMessage()]);
}
