// Recebe requisição e envia resposta
import { criarCliente, buscarClientes, buscarClienteId, deletarClienteId, atualizarCliente } from './cliente.service.js'
import { type Response, type Request } from 'express'

export async function criarClienteController(req: Request, res: Response) {
    try {
        const { nome, telefone } = req.body
        const cliente = await criarCliente(nome, telefone);
        return res.status(201).json(cliente)
    } catch (error) {
        return res.status(500).json({
            message: "Erro ao criar usuário"
        })
    }
}


export async function buscarClientesController(req: Request, res: Response) {
    try {
        const clientes = await buscarClientes();
        return res.status(200).json(clientes)
    } catch (error) {
        return res.status(500).json({
            message: "Erro ao buscar clientes"
        })
    }
}

export async function buscarClienteIdController(req: Request, res: Response) {
    try {
        const idCliente = Number(req.params.id)
        if (!Number.isInteger(idCliente) || idCliente <= 0) {
            return res.status(400).json({
                error: "ID inválido"
            })
        }

        const cliente = await buscarClienteId(idCliente)

        if(!cliente){
            return res.status(404).json({
                message: "Cliente não encontrado"
            })
        }
        return res.status(200).json(cliente)
    } catch (error) {
        return res.status(500).json({
            message: "Erro interno do servidor"
        })
    }
}

export async function atualizarClienteIdController(req: Request, res: Response) {
    try {
        const idCliente = Number(req.params.id)
        const { nome, telefone } = req.body

        if (!Number.isInteger(idCliente) || idCliente <= 0) {
            return res.status(400).json({
                error: "ID inválido"
            })
        }

        const novoCliente = await atualizarCliente(idCliente, nome, telefone)

        return res.status(200).json(novoCliente)
    } catch (error) {
        return res.status(500).json({ error: error })
    }
}

export async function deletarClienteIdController(req: Request, res: Response) {
    try {
        const idCliente = Number(req.params.id)
        const cliente = await deletarClienteId(idCliente)
        return res.status(200).json({
            message: `Cliente de id: ${idCliente} deletado com sucesso!`,
            data: cliente
        })
    } catch (error) {
        return res.status(500).json({
            message: `Erro ao deletar cliente`
        })
    }
}