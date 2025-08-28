<?php
// controller/LlamadosController.php
require_once '../modelo/LlamadosModel.php';

class LlamadosController {
    public function getLlamados() {
        $model = new LlamadosModel();
        $llamados = $model->traerLlamados();
        return json_encode(['llamados' => $llamados]);
    }
}
