/* PROJETO: E-commerce ML Olist
   AUTORA: Isabella
   OBJETIVO: Limpeza, Padronização e Tratamento de Outliers (Bronze -> Silver)
*/

-- [LOG] 1. Contagem inicial da Bronze
SELECT 'LINHAS INICIAIS (BRONZE)' as categoria, COUNT(*) as total FROM bronze.order_items_dataset;

-- 2. Limpeza do terreno (CORRIGIDO: adicionado CASCADE para não travar na View de outliers)
DROP TABLE IF EXISTS silver.order_items CASCADE;

-- 3. Criação da Silver com as regras do Contrato de Dados + Winsorização
CREATE TABLE silver.order_items AS
WITH base_tratada AS (
    SELECT 
        order_id,
        order_item_id,
        product_id,
        seller_id,
        CAST(shipping_limit_date AS TIMESTAMP) as shipping_limit_date,
        COALESCE(price, 0) as price_bruto,
        COALESCE(freight_value, 0) as freight_bruto,
        
        -- [NOTA TÉCNICA EXIGIDA] Identificar duplicados por ordem de data
        ROW_NUMBER() OVER(
            PARTITION BY order_id, order_item_id 
            ORDER BY shipping_limit_date DESC
        ) as rank_duplicado
    FROM bronze.order_items_dataset
)
SELECT 
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    
    -- WINSORIZAÇÃO DO PREÇO: Teto cravado em 277.40
    CASE 
        WHEN price_bruto > 277.40 THEN 277.40
        ELSE price_bruto
    END AS price,

    -- WINSORIZAÇÃO DO FRETE: Teto cravado em 33.40
    CASE 
        WHEN freight_bruto > 33.40 THEN 33.40
        ELSE freight_bruto
    END AS freight_value

FROM base_tratada
WHERE rank_duplicado = 1 AND price_bruto > 0;          
      

-- [LOG] 4. Verificação de Sucesso 
SELECT 'DUPLICADOS RESTANTES' as validacao, COUNT(*) 
FROM silver.order_items 
GROUP BY order_id, order_item_id 
HAVING COUNT(*) > 1;

-- [LOG] 5. Contagem Final da Silver
SELECT 'LINHAS FINAIS (SILVER)' as categoria, COUNT(*) as total FROM silver.order_items;