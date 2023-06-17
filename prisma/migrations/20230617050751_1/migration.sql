/*
  Warnings:

  - You are about to alter the column `brandId` on the `Product` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Int`.
  - You are about to alter the column `id` on the `Product` table. The data in that column will be cast from `BigInt` to `Int`. This cast may fail. Please make sure the data in the column can be cast.
  - You are about to alter the column `price` on the `Product` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Int`.
  - You are about to alter the column `id` on the `Brand` table. The data in that column will be cast from `BigInt` to `Int`. This cast may fail. Please make sure the data in the column can be cast.

*/
-- RedefineTables
CREATE TABLE "_prisma_new_Product" (
    "id" INT4 NOT NULL DEFAULT unique_rowid(),
    "title" STRING NOT NULL,
    "price" INT4 NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "brandId" INT4 NOT NULL,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);
INSERT INTO "_prisma_new_Product" ("brandId","createdAt","id","price","title","updatedAt") SELECT "brandId","createdAt","id","price","title","updatedAt" FROM "Product";
DROP TABLE "Product" CASCADE;
ALTER TABLE "_prisma_new_Product" RENAME TO "Product";
ALTER TABLE "Product" ADD CONSTRAINT "Product_brandId_fkey" FOREIGN KEY ("brandId") REFERENCES "Brand"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
CREATE TABLE "_prisma_new_Brand" (
    "id" INT4 NOT NULL DEFAULT unique_rowid(),
    "name" STRING NOT NULL,

    CONSTRAINT "Brand_pkey" PRIMARY KEY ("id")
);
INSERT INTO "_prisma_new_Brand" ("id","name") SELECT "id","name" FROM "Brand";
DROP TABLE "Brand" CASCADE;
ALTER TABLE "_prisma_new_Brand" RENAME TO "Brand";
