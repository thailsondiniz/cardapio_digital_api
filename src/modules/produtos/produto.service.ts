import { Prisma } from '../../../generated/prisma/client.js'
import { prisma } from '../../config/prisma.js'

export async function criarProduto(data: Prisma.ProdutoCreateInput){
    return await prisma.produto.create({
        data
    })
}

export async function buscarProdutos(){
    return await prisma.produto.findMany()
}

export async function buscarProdutoId(id: number){
    return await prisma.produto.findUnique({
        where: {
            id: id
        }
    })
}

export async function atualizarProduto(id:number, data: Prisma.ProdutoUpdateInput){
    return await prisma.produto.update({
        where: {
            id: id
        },
        data: data
    })
}


export async function deletarProdutoId(id: number){
    return await prisma.produto.delete({
        where: {
            id: id
        }
    })
}