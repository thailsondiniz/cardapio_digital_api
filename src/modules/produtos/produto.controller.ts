import { criarProduto, buscarProdutos, buscarProdutoId, atualizarProduto, deletarProdutoId } from './produto.service.js'
import { type Response, type Request } from 'express'
import { Prisma } from '../../../generated/prisma/client.js'


export async function criarProdutoController(req: Request, res: Response) {
    try {
        const produto = await criarProduto(req.body)
        return res.status(201).json(produto)
    } catch (error) {
        console.error(error)
        return res.status(500).json({
            message: "Erro ao criar produto",
            error
        })
    }
}

export async function buscarProdutoController(req: Request, res: Response) {
    try {
        const produtos = await buscarProdutos()
        return res.status(200).json(produtos)
    } catch (error) {
        return res.status(500).json({ message: "Erro ao buscar produtos" })
    }
}

export async function buscarProdutoIdController(req: Request, res: Response) {
    try {
        const idProduto = Number(req.params.id)
        const produto = await buscarProdutoId(idProduto)
        if (!produto) {
            return res.status(404).json({
                message: 'Produto não encontrado'
            })
        }
        return res.status(200).json(produto)
    } catch (error) {
        console.error(error)
        return res.status(500).json({
            message: "Erro interno do servidor"
        })
    }
}


export async function atualizarProdutoController(req: Request, res: Response) {
    try {
        const idProduto = Number(req.params.id)
        const produto = req.body

        if (!Number.isInteger(idProduto) || idProduto <= 0) {
            return res.status(400).json({
                message: "ID inválido"
            })
        }

        const produtoAtualizado = await atualizarProduto(idProduto, produto)
        return res.status(200).json({
            message: "Produto atualizado com sucesso",
            produto: produtoAtualizado
        })
    } catch (error) {
        console.error(error)

        if (
            error instanceof Prisma.PrismaClientKnownRequestError &&
            error.code === "P2025"
        ) {
            return res.status(404).json({
                message: "Produto não encontrado"
            })
        }

        return res.status(500).json({
            message: "Erro interno do servidor"
        })
    }
}

export async function deletarProdutoController(req: Request, res: Response){
    try {
        const idProduto = Number(req.params.id)

        if (!Number.isInteger(idProduto) || idProduto <= 0) {
            return res.status(400).json({
                message: "ID inválido"
            })
        }

        const cliente = await deletarProdutoId(idProduto)

        return res.status(200).json({
            message: `Produto de ID: ${idProduto} deletado com sucesso!`,
            data: cliente
        })


    } catch (error) {
        console.error(error)
        return res.status(500).json({
            message: "Erro interno do servidor"
        })
    }
}