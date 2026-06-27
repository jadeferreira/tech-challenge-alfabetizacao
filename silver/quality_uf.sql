SELECT
  COUNTIF(ano IS NULL) AS nulos_ano,
  COUNTIF(sigla_uf IS NULL) AS nulos_sigla_uf,
  COUNTIF(taxa_alfabetizacao IS NULL) AS nulos_taxa
FROM `tc-alfabetizacao.silver.uf_alfabetizacao_silver`;