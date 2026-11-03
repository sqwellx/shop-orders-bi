-- Данные учебные, синтетические. Схема таблицы: orders.
-- 1. Объем заказов по месяцам и стоимость реально доставленных заказов.
SELECT
    month,
    COUNT(*) AS orders_total,
    SUM(is_delivered) AS delivered_orders,
    SUM(delivered_amount) AS delivered_amount_rub
FROM orders
GROUP BY month
ORDER BY month;

-- 2. Стоимость доставленных заказов по категориям.
SELECT
    category,
    COUNT(*) AS orders_total,
    SUM(delivered_amount) AS delivered_amount_rub
FROM orders
GROUP BY category
ORDER BY delivered_amount_rub DESC;

-- 3. Успешность закрытых заказов по городам.
-- В знаменатель НЕ входят заказы in_progress.
SELECT
    city,
    SUM(is_delivered) AS delivered_orders,
    SUM(is_finished) AS finished_orders,
    ROUND(100.0 * SUM(is_delivered) / NULLIF(SUM(is_finished), 0), 1) AS delivered_share_pct
FROM orders
GROUP BY city
ORDER BY delivered_share_pct DESC;

-- 4. Средний срок доставки только для доставленных заказов.
SELECT
    city,
    ROUND(AVG(delivery_days), 2) AS avg_delivery_days
FROM orders
WHERE status = 'delivered'
GROUP BY city
ORDER BY avg_delivery_days ASC;
