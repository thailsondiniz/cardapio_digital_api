import { prisma } from '../../config/prisma.js'
import { Prisma } from '../../../generated/prisma/client.js'


export async function criarMesa(data: Prisma.MesaCreateInput) {
    return await prisma.mesa.create({ data })
}

export async function buscarMesas(){
    return await prisma.mesa.findMany()
}

export async function buscarMesaId(idMesa: number){
    return await prisma.mesa.findUnique({
        where: {
            id: idMesa
        }
    })
}

export async function atualizarMesa(idMesa: number, data: Prisma.MesaUpdateInput){
    return await prisma.mesa.update({
        where: {
            id: idMesa
        },
        data: data
    })
}

export async function deletarMesa(idMesa: number){
    return await prisma.mesa.delete({
        where: {
            id: idMesa
        }
    })
}