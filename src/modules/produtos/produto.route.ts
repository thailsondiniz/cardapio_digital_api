import { Router } from 'express';
import { criarProdutoController, buscarProdutoController, buscarProdutoIdController, atualizarProdutoController, deletarProdutoController } from './produto.controller.js';

const router = Router()

router.post('/', criarProdutoController)
router.get('/', buscarProdutoController)
router.get('/:id', buscarProdutoIdController)
router.patch('/:id', atualizarProdutoController)
router.delete('/:id', deletarProdutoController)

export default router