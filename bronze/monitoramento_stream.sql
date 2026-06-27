-- Quantidade total de eventos na tabela de stream
SELECT
  COUNT(*) AS total_eventos
FROM `tc-alfabetizacao.bronze.indicador_crianca_stream`;

-- Eventos por UF
SELECT
  sigla_uf,
  COUNT(*) AS eventos_por_uf
FROM `tc-alfabetizacao.bronze.indicador_crianca_stream`
GROUP BY sigla_uf
ORDER BY eventos_por_uf DESC;

-- Último evento
SELECT
  sigla_uf,
  MAX(ts_evento) AS ultimo_evento
FROM `tc-alfabetizacao.bronze.indicador_crianca_stream`
GROUP BY sigla_uf
ORDER BY ultimo_evento DESC;