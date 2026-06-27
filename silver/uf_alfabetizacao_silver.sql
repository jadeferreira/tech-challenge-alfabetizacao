CREATE OR REPLACE TABLE `tc-alfabetizacao.silver.uf_alfabetizacao_silver` AS
WITH base AS (
  SELECT
    SAFE_CAST(b.ano AS INT64) AS ano,
    UPPER(TRIM(b.sigla_uf)) AS sigla_uf,

    b.taxa_alfabetizacao,

    ROW_NUMBER() OVER (
      PARTITION BY b.ano, b.sigla_uf
      ORDER BY b.ano
    ) AS rn
  FROM `tc-alfabetizacao.bronze.indicador_crianca_bronze` AS b
)
SELECT
  ano,
  sigla_uf,
  taxa_alfabetizacao,
FROM base
WHERE rn = 1;