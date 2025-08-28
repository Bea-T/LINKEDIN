<?php
// modelo/LlamadosModel.php
require_once 'Conexion.php';

class LlamadosModel {
    private $conn;
    public function __construct() {
        $this->conn = connection();
    }
    public function traerLlamados() {
        $sql = "SELECT * FROM llamados";
        $result = $this->conn->query($sql);
        $llamados = [];
        while ($row = $result->fetch_assoc()) {
            $llamados[] = $row;
        }
        return $llamados;
    }
}
