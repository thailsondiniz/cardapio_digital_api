import { criarMesa, buscarMesaId, buscarMesas, deletarMesa, atualizarMesa } from "./mesa.service.js";
import { type Response, type Request } from 'express'


export async function criarMesaController(req: Request, res: Response) {
    try {
        const mesa = await criarMesa(req.body)
        return res.status(201).json(mesa)
    } catch (error) {
        console.error(error)
        return res.status(500).json({
            message: "Erro interno do servidor"
        })
    }
}

export async function buscarMesasController(req: Request, res: Response) {
    try {
        const mesas = await buscarMesas()
        return res.status(200).json(mesas)
    } catch (error) {
        console.error(error)
        return res.status(500).json({
            message: "Erro interno do servidor"
        })
    }
}

export async function buscarMesaIdController(req: Request, res: Response) {
    try {
        const idMesa = Number(req.params.id)

        if (!idMesa) {
            return res.status(404).json({
                message: "Mesa não encontrada"
            })
        }
        const mesa = await buscarMesaId(idMesa)

        return res.status(200).json(mesa)
    } catch (error) {
        console.error(error)
        return res.status(500).json({
            message: "Erro interno do servidor"
        })
    }
}

export async function atualizarMesaController(req: Request, res: Response) {
    try {
        const idMesa = Number(req.params.id)
        const mesa = req.body
        if (!Number.isInteger(idMesa) || idMesa <= 0) {
            return res.status(400).json({
                message: "ID inválido"
            })
        }

        const mesaAtualizada = await atualizarMesa(idMesa, mesa)

        return res.status(200).json({
            message: "Mesa atualizada com sucesso!",
            data: mesaAtualizada
        })
    } catch (error) {
        console.error(error)
        return res.status(500).json({
            message: "Erro interno do servidor"
        })
    }
}


export async function deletarMesaController(req: Request, res: Response) {
    try {
        const idMesa = Number(req.params.id)

        if (!Number.isInteger(idMesa) || idMesa <= 0) {
            return res.status(400).json({
                message: "ID inválido"
            })
        }

        const mesa = await deletarMesa(idMesa)
        return res.status(200).json({
            message: `Mesa de id: ${idMesa} excluído com sucesso`,
            data: mesa
        })
    } catch (error) {
        console.error(error)
        return res.status(500).json({
            message: "Erro interno do servidor"
        })
    }
}