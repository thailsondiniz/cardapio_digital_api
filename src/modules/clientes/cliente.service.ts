//Executa as regras de negócio
import { prisma } from '../../config/prisma.js'

export async function criarCliente(nome: string, telefone: string) {
    return await prisma.cliente.create({
        data: {
            nome,
            telefone
        }
    });
}

export async function buscarClientes() {
    return await prisma.cliente.findMany()
}

export async function buscarClienteId(id: number) {
    return await prisma.cliente.findUnique({
        where: {
            id: id
        }
    })
}

export async function atualizarCliente(id: number, nome: string, telefone: string) {
    return await prisma.cliente.update({
        where: { id }, 
        data: {
            nome,
            telefone
        }
    })
}

export async function deletarClienteId(id: number) {
    return await prisma.cliente.delete({
        where: {
            id: Number(id)
        }
    })
}