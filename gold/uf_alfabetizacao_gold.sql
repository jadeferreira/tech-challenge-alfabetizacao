CREATE OR REPLACE VIEW `tc-alfabetizacao.gold.uf_alfabetizacao_gold` AS
SELECT
  -- chaves principais
  u.ano,
  u.sigla_uf,

  -- indicador de alfabetização vindo da Silver de UF
  u.taxa_alfabetizacao,

  -- informações de metas / histórico
  m.saeb_2019,
  m.saeb_2021,
  m.pc_aluno_alfabetizado,
  m.meta_2024,
  m.meta_2025,
  m.meta_2026,
  m.meta_2027,
  m.meta_2028,
  m.meta_2029,
  m.meta_2030,

  -- gap em relação à meta de 2030
  (u.taxa_alfabetizacao - m.meta_2030) AS gap_meta_2030,

  -- status em relação à meta de 2030
  CASE
    WHEN u.taxa_alfabetizacao IS NULL OR m.meta_2030 IS NULL THEN 'sem_dado'
    WHEN u.taxa_alfabetizacao < m.meta_2030 THEN 'abaixo_meta_2030'
    ELSE 'acima_meta_2030'
  END AS status_meta_2030,

  -- classificação por faixas genéricas de taxa (mantendo sua lógica original)
  CASE
    WHEN u.taxa_alfabetizacao IS NULL THEN 'sem_dado'
    WHEN u.taxa_alfabetizacao < 40 THEN 'muito_baixo'
    WHEN u.taxa_alfabetizacao < 60 THEN 'baixo'
    WHEN u.taxa_alfabetizacao < 80 THEN 'adequado_parcial'
    ELSE 'acima_meta_2030'
  END AS classe_taxa

FROM `tc-alfabetizacao.silver.uf_alfabetizacao_silver` AS u
LEFT JOIN `tc-alfabetizacao.silver.metas_uf_silver` AS m
  ON u.ano = m.ano
 AND u.sigla_uf = m.sigla_uf;