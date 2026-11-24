/*
  Warnings:

  - A unique constraint covering the columns `[qrCodeToken]` on the table `Mesa` will be added. If there are existing duplicate values, this will fail.
  - The required column `qrCodeToken` was added to the `Mesa` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - Added the required column `updatedAt` to the `Mesa` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "StatusMesa" AS ENUM ('DISPONIVEL', 'OCUPADA', 'INATIVA');

-- AlterTable
ALTER TABLE "Mesa" ADD COLUMN     "ativa" BOOLEAN NOT NULL DEFAULT true,
ADD COLUMN     "capacidade" INTEGER NOT NULL DEFAULT 4,
ADD COLUMN     "qrCodeToken" TEXT NOT NULL,
ADD COLUMN     "status" "StatusMesa" NOT NULL DEFAULT 'DISPONIVEL',
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Mesa_qrCodeToken_key" ON "Mesa"("qrCodeToken");
