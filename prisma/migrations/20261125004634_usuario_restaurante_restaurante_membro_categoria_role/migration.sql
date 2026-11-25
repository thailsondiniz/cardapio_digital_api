/*
  Warnings:

  - A unique constraint covering the columns `[id,restauranteId]` on the table `Atendimento` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id,restauranteId]` on the table `Cliente` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[restauranteId,telefone]` on the table `Cliente` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id,restauranteId]` on the table `Mesa` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[restauranteId,numero]` on the table `Mesa` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id,restauranteId]` on the table `Pedido` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[id,restauranteId]` on the table `Produto` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `restauranteId` to the `Atendimento` table without a default value. This is not possible if the table is not empty.
  - Added the required column `restauranteId` to the `Cliente` table without a default value. This is not possible if the table is not empty.
  - Added the required column `restauranteId` to the `ItemPedido` table without a default value. This is not possible if the table is not empty.
  - Added the required column `restauranteId` to the `Mesa` table without a default value. This is not possible if the table is not empty.
  - Added the required column `restauranteId` to the `Pedido` table without a default value. This is not possible if the table is not empty.
  - Added the required column `categoriaId` to the `Produto` table without a default value. This is not possible if the table is not empty.
  - Added the required column `restauranteId` to the `Produto` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Role" AS ENUM ('PROPRIETARIO', 'ADMIN', 'FUNCIONARIO');

-- DropForeignKey
ALTER TABLE "Atendimento" DROP CONSTRAINT "Atendimento_clienteId_fkey";

-- DropForeignKey
ALTER TABLE "Atendimento" DROP CONSTRAINT "Atendimento_mesaId_fkey";

-- DropForeignKey
ALTER TABLE "ItemPedido" DROP CONSTRAINT "ItemPedido_pedidoId_fkey";

-- DropForeignKey
ALTER TABLE "ItemPedido" DROP CONSTRAINT "ItemPedido_produtoId_fkey";

-- DropForeignKey
ALTER TABLE "Pedido" DROP CONSTRAINT "Pedido_atendimentoId_fkey";

-- DropIndex
DROP INDEX "Cliente_telefone_key";

-- DropIndex
DROP INDEX "Mesa_numero_key";

-- CreateTable
CREATE TABLE "Usuario" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "senha" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Usuario_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Restaurante" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Restaurante_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RestauranteMembro" (
    "id" SERIAL NOT NULL,
    "usuarioId" INTEGER NOT NULL,
    "restauranteId" INTEGER NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'FUNCIONARIO',

    CONSTRAINT "RestauranteMembro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Categoria" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "restauranteId" INTEGER NOT NULL,

    CONSTRAINT "Categoria_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_email_key" ON "Usuario"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Restaurante_slug_key" ON "Restaurante"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "RestauranteMembro_usuarioId_restauranteId_key" ON "RestauranteMembro"("usuarioId", "restauranteId");

-- CreateIndex
CREATE UNIQUE INDEX "Categoria_id_restauranteId_key" ON "Categoria"("id", "restauranteId");

-- CreateIndex
CREATE UNIQUE INDEX "Categoria_restauranteId_nome_key" ON "Categoria"("restauranteId", "nome");

-- AddForeignKey
ALTER TABLE "RestauranteMembro" ADD CONSTRAINT "RestauranteMembro_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RestauranteMembro" ADD CONSTRAINT "RestauranteMembro_restauranteId_fkey" FOREIGN KEY ("restauranteId") REFERENCES "Restaurante"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Categoria" ADD CONSTRAINT "Categoria_restauranteId_fkey" FOREIGN KEY ("restauranteId") REFERENCES "Restaurante"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- =============================================================
-- Seed: restaurante padrão para migrar dados existentes
-- =============================================================
INSERT INTO "Restaurante" ("nome", "slug", "ativo", "createdAt", "updatedAt")
VALUES ('Restaurante Padrão', 'restaurante-padrao', true, NOW(), NOW());

-- Categoria padrão (necessária para Produto.categoriaId)
INSERT INTO "Categoria" ("nome", "restauranteId")
VALUES ('Sem Categoria', (SELECT id FROM "Restaurante" WHERE slug = 'restaurante-padrao'));

-- =============================================================
-- AlterTable: adicionar colunas nullable primeiro
-- =============================================================
ALTER TABLE "Atendimento" ADD COLUMN "restauranteId" INTEGER;
ALTER TABLE "Cliente"     ADD COLUMN "restauranteId" INTEGER;
ALTER TABLE "ItemPedido"  ADD COLUMN "restauranteId" INTEGER;
ALTER TABLE "Mesa"        ADD COLUMN "restauranteId" INTEGER;
ALTER TABLE "Pedido"      ADD COLUMN "restauranteId" INTEGER;
ALTER TABLE "Produto"     ADD COLUMN "categoriaId"   INTEGER;
ALTER TABLE "Produto"     ADD COLUMN "restauranteId" INTEGER;

-- =============================================================
-- Preencher dados existentes com o restaurante/categoria padrão
-- =============================================================
UPDATE "Atendimento" SET "restauranteId" = (SELECT id FROM "Restaurante" WHERE slug = 'restaurante-padrao') WHERE "restauranteId" IS NULL;
UPDATE "Cliente"     SET "restauranteId" = (SELECT id FROM "Restaurante" WHERE slug = 'restaurante-padrao') WHERE "restauranteId" IS NULL;
UPDATE "ItemPedido"  SET "restauranteId" = (SELECT id FROM "Restaurante" WHERE slug = 'restaurante-padrao') WHERE "restauranteId" IS NULL;
UPDATE "Mesa"        SET "restauranteId" = (SELECT id FROM "Restaurante" WHERE slug = 'restaurante-padrao') WHERE "restauranteId" IS NULL;
UPDATE "Pedido"      SET "restauranteId" = (SELECT id FROM "Restaurante" WHERE slug = 'restaurante-padrao') WHERE "restauranteId" IS NULL;
UPDATE "Produto"     SET "restauranteId" = (SELECT id FROM "Restaurante" WHERE slug = 'restaurante-padrao') WHERE "restauranteId" IS NULL;
UPDATE "Produto"     SET "categoriaId"   = (SELECT id FROM "Categoria"   WHERE nome = 'Sem Categoria' AND "restauranteId" = (SELECT id FROM "Restaurante" WHERE slug = 'restaurante-padrao')) WHERE "categoriaId" IS NULL;

-- =============================================================
-- Tornar colunas NOT NULL após preenchimento
-- =============================================================
ALTER TABLE "Atendimento" ALTER COLUMN "restauranteId" SET NOT NULL;
ALTER TABLE "Cliente"     ALTER COLUMN "restauranteId" SET NOT NULL;
ALTER TABLE "ItemPedido"  ALTER COLUMN "restauranteId" SET NOT NULL;
ALTER TABLE "Mesa"        ALTER COLUMN "restauranteId" SET NOT NULL;
ALTER TABLE "Pedido"      ALTER COLUMN "restauranteId" SET NOT NULL;
ALTER TABLE "Produto"     ALTER COLUMN "categoriaId"   SET NOT NULL;
ALTER TABLE "Produto"     ALTER COLUMN "restauranteId" SET NOT NULL;

-- =============================================================
-- Índices únicos
-- =============================================================
CREATE UNIQUE INDEX "Atendimento_id_restauranteId_key" ON "Atendimento"("id", "restauranteId");
CREATE UNIQUE INDEX "Cliente_id_restauranteId_key"     ON "Cliente"("id", "restauranteId");
CREATE UNIQUE INDEX "Cliente_restauranteId_telefone_key" ON "Cliente"("restauranteId", "telefone");
CREATE UNIQUE INDEX "Mesa_id_restauranteId_key"        ON "Mesa"("id", "restauranteId");
CREATE UNIQUE INDEX "Mesa_restauranteId_numero_key"    ON "Mesa"("restauranteId", "numero");
CREATE UNIQUE INDEX "Pedido_id_restauranteId_key"      ON "Pedido"("id", "restauranteId");
CREATE UNIQUE INDEX "Produto_id_restauranteId_key"     ON "Produto"("id", "restauranteId");

-- =============================================================
-- Foreign Keys
-- =============================================================
ALTER TABLE "Cliente" ADD CONSTRAINT "Cliente_restauranteId_fkey" FOREIGN KEY ("restauranteId") REFERENCES "Restaurante"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "Produto" ADD CONSTRAINT "Produto_restauranteId_fkey" FOREIGN KEY ("restauranteId") REFERENCES "Restaurante"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "Produto" ADD CONSTRAINT "Produto_categoriaId_restauranteId_fkey" FOREIGN KEY ("categoriaId", "restauranteId") REFERENCES "Categoria"("id", "restauranteId") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "Pedido" ADD CONSTRAINT "Pedido_atendimentoId_restauranteId_fkey" FOREIGN KEY ("atendimentoId", "restauranteId") REFERENCES "Atendimento"("id", "restauranteId") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "ItemPedido" ADD CONSTRAINT "ItemPedido_pedidoId_restauranteId_fkey" FOREIGN KEY ("pedidoId", "restauranteId") REFERENCES "Pedido"("id", "restauranteId") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "ItemPedido" ADD CONSTRAINT "ItemPedido_produtoId_restauranteId_fkey" FOREIGN KEY ("produtoId", "restauranteId") REFERENCES "Produto"("id", "restauranteId") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "Mesa" ADD CONSTRAINT "Mesa_restauranteId_fkey" FOREIGN KEY ("restauranteId") REFERENCES "Restaurante"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "Atendimento" ADD CONSTRAINT "Atendimento_clienteId_restauranteId_fkey" FOREIGN KEY ("clienteId", "restauranteId") REFERENCES "Cliente"("id", "restauranteId") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "Atendimento" ADD CONSTRAINT "Atendimento_mesaId_restauranteId_fkey" FOREIGN KEY ("mesaId", "restauranteId") REFERENCES "Mesa"("id", "restauranteId") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "Atendimento" ADD CONSTRAINT "Atendimento_restauranteId_fkey" FOREIGN KEY ("restauranteId") REFERENCES "Restaurante"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
