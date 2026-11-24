//Define os endpoints HTTP
import { Router } from 'express';
import { criarClienteController, buscarClientesController, buscarClienteIdController, deletarClienteIdController, atualizarClienteIdController } from './cliente.controller.js';
const router = Router();

router.post('/', criarClienteController)
router.get('/', buscarClientesController)
router.get('/:id', buscarClienteIdController)
router.delete('/:id', deletarClienteIdController)
router.patch('/:id', atualizarClienteIdController)


export default router