/* PROJETO: E-commerce ML Olist
   AUTORA: Isabella
   OBJETIVO: Limpeza e Padronização da tabela Order Items (Bronze -> Silver)
*/

-- [LOG] 1. Contagem inicial da Bronze
SELECT 'LINHAS INICIAIS (BRONZE)' as categoria, COUNT(*) as total FROM bronze.order_items_dataset;

-- 2. Limpeza do terreno
DROP TABLE IF EXISTS silver.order_items;

-- 3. Criação da Silver com as regras do Contrato de Dados
CREATE TABLE silver.order_items AS
WITH base_tratada AS (
    SELECT 
        order_id,
        order_item_id,
        product_id,
        seller_id,
        -- Regra 1.3: Data como TIMESTAMP
        CAST(shipping_limit_date AS TIMESTAMP) as shipping_limit_date,
        -- Regra 1.5: Tratar Nulos com Mediana (ou 0 para flag de erro)
        COALESCE(price, 0) as price,
        COALESCE(freight_value, 0) as freight_value,
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
    price,
    freight_value
FROM base_tratada
WHERE rank_duplicado = 1 AND price > 0;           
      

-- [LOG] 4. Verificação de Sucesso 
SELECT 'DUPLICADOS RESTANTES' as validacao, COUNT(*) 
FROM silver.order_items 
GROUP BY order_id, order_item_id 
HAVING COUNT(*) > 1;

-- [LOG] 5. Contagem Final da Silver
SELECT 'LINHAS FINAIS (SILVER)' as categoria, COUNT(*) as total FROM silver.order_items;