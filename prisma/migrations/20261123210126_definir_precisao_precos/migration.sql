/*
  Warnings:

  - You are about to alter the column `precoUnitario` on the `ItemPedido` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `Decimal(10,2)`.
  - You are about to alter the column `preco_total` on the `ItemPedido` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `Decimal(10,2)`.
  - You are about to alter the column `preco` on the `Produto` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `Decimal(10,2)`.

*/
-- AlterTable
ALTER TABLE "ItemPedido" ALTER COLUMN "precoUnitario" SET DATA TYPE DECIMAL(10,2),
ALTER COLUMN "preco_total" SET DATA TYPE DECIMAL(10,2);

-- AlterTable
ALTER TABLE "Produto" ALTER COLUMN "preco" SET DATA TYPE DECIMAL(10,2);
