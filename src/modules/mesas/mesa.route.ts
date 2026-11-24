import { Router } from 'express';
import { criarMesaController, atualizarMesaController, buscarMesaIdController, buscarMesasController, deletarMesaController } from './mesa.controller.js';

const router = Router()

router.get('/', buscarMesasController)
router.post('/', criarMesaController)
router.get('/:id', buscarMesaIdController)
router.patch('/:id', atualizarMesaController)
router.delete('/:id', deletarMesaController)

export default router