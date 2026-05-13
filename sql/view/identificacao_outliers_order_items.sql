/* OBJETIVO: Identificação de Outliers (IQR)
   LOGICA: Cálculo separado dos quartis para evitar erro de 'OVER'
*/

DROP VIEW IF EXISTS silver.v_outliers_order_items;

CREATE OR REPLACE VIEW silver.v_outliers_order_items AS
WITH estatisticas AS (
    -- Aqui calculamos os quartis de forma pura
    SELECT 
        percentile_cont(0.25) WITHIN GROUP (ORDER BY price) AS q1_p,
        percentile_cont(0.75) WITHIN GROUP (ORDER BY price) AS q3_p,
        percentile_cont(0.25) WITHIN GROUP (ORDER BY freight_value) AS q1_f,
        percentile_cont(0.75) WITHIN GROUP (ORDER BY freight_value) AS q3_f
    FROM silver.order_items
),
limites AS (
    -- Aqui transformamos os quartis em limites inferior e superior
    SELECT 
        q1_p, q3_p,
        (q3_p + 1.5 * (q3_p - q1_p)) AS lim_sup_p,
        (q1_p - 1.5 * (q3_p - q1_p)) AS lim_inf_p,
        (q3_f + 1.5 * (q3_f - q1_f)) AS lim_sup_f,
        (q1_f - 1.5 * (q3_f - q1_f)) AS lim_inf_f
    FROM estatisticas
)
-- Agora selecionamos os dados da silver que estão fora desses limites
SELECT 
    i.*,
    CASE 
        WHEN i.price > l.lim_sup_p THEN 'Preço Acima do Limite'
        WHEN i.price < l.lim_inf_p THEN 'Preço Abaixo do Limite'
        WHEN i.freight_value > l.lim_sup_f THEN 'Frete Acima do Limite'
        WHEN i.freight_value < l.lim_inf_f THEN 'Frete Abaixo do Limite'
    END AS motivo_outlier,
    l.lim_sup_p as teto_preco,
    l.lim_sup_f as teto_frete
FROM silver.order_items i
CROSS JOIN limites l -- O CROSS JOIN aplica os limites em todas as linhas para comparação
WHERE i.price > l.lim_sup_p 
   OR i.price < l.lim_inf_p 
   OR i.freight_value > l.lim_sup_f 
   OR i.freight_value < l.lim_inf_f;