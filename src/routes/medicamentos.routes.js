import { Router } from 'express';
import {getMedicamentos,
  getMedicamentoById,
  getMedicamentosByReceta,
  getMedicamentosBytipo,
  registerMedicamento,
  updateMedicamento,
  deleteMedicamento
 } from '../controllers/medicamentos.controller.js';

const router = Router();

router.get('/medicamentos', getMedicamentos);
router.get('/medicamentos/:id', getMedicamentoById);
router.get('/medicamentos/receta/:receta', getMedicamentosByReceta);
router.get('/medicamentos/tipo/:tipo', getMedicamentosBytipo);

router.post('/medicamentos/', registerMedicamento);

router.put('/medicamentos/:id', updateMedicamento);

router.delete('/medicamentos/:id', deleteMedicamento);

export default router;




